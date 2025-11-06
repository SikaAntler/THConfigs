import json
import shutil
import sys
import tarfile
from argparse import ArgumentParser
from pathlib import Path
from typing import Literal
from zipfile import ZipFile

import requests
from tqdm import tqdm

# fmt: off
FIXED_PKGS = {
    "duf": (            "https://github.com/muesli/duf/releases/tag/v0.9.1",                   "duf_0.9.1_linux_x86_64.tar.gz",     "duf"),
   "dust": (         "https://github.com/bootandy/dust/releases/tag/v1.2.3",    "dust-v1.2.3-x86_64-unknown-linux-musl.tar.gz",    "dust"),
     "fd": (           "https://github.com/sharkdp/fd/releases/tag/v10.3.0",     "fd-v10.3.0-x86_64-unknown-linux-musl.tar.gz",      "fd"),
    "fzf": (         "https://github.com/junegunn/fzf/releases/tag/v0.66.1",                   "fzf-0.66.1-linux_amd64.tar.gz",     "fzf"),
"lazygit": ("https://github.com/jesseduffield/lazygit/releases/tag/v0.55.1",              "lazygit_0.55.1_linux_x86_64.tar.gz", "lazygit"),
     "rg": (    "https://github.com/BurntSushi/ripgrep/releases/tag/15.1.0", "ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz",      "rg"),
 "zoxide": (    "https://github.com/ajeetdsouza/zoxide/releases/tag/v0.9.8",   "zoxide-0.9.8-x86_64-unknown-linux-musl.tar.gz",  "zoxide"),
}
PACKAGES = {
"csvtk": (        "shenwei356/csvtk",             "csvtk_linux_amd64.tar.gz",        "csvtk"),
 "btop": (       "aristocratos/btop",           "btop-x86_64-linux-musl.tbz",         "btop"),
  "eza": (       "eza-community/eza", "eza_x86_64-unknown-linux-musl.tar.gz",          "eza"),
   "jq": (               "jqlang/jq",                       "jq-linux-amd64",           "jq"),
 "nvim": (           "neovim/neovim",           "nvim-linux-x86_64.appimage",         "nvim"),
 "tmux": ("nelsonenzo/tmux-appimage",                        "tmux.appimage",         "tmux"),
   "uv": (            "astral-sh/uv",  "uv-x86_64-unknown-linux-musl.tar.gz",  ["uv", "uvx"]),
 "yazi": (             "sxyazi/yazi",   "yazi-x86_64-unknown-linux-musl.zip", ["yazi", "ya"]),
   "yq": (            "mikefarah/yq",                       "yq_linux_amd64",           "yq"),
}
# fmt: on
DOWNLOAD_DIR = Path("~/Downloads/").expanduser()
RUN_DIR = Path("~/.local/bin/").expanduser()


def extract_tar(
    download_file: Path, mode: Literal["r:gz", "r:bz2"], exe_file: str
) -> None:
    with tarfile.open(download_file, mode) as tar_ref:
        for filename in tar_ref.getnames():
            name = filename.split("/")[-1]
            if name == exe_file:
                target = RUN_DIR / name
                print(f"Extracting {filename} to {target}")
                with open(target, "wb") as fw:
                    file_obj = tar_ref.extractfile(filename)
                    if file_obj:
                        fw.write(file_obj.read())
                target.chmod(0o755)


def extract_zip(download_file: Path, exe_file: str) -> None:
    with ZipFile(download_file) as fr:
        for filename in fr.namelist():
            name = filename.split("/")[-1]
            if name == exe_file:
                target = RUN_DIR / name
                print(f"Extracting {filename} to {target}")
                with open(target, "wb") as fw:
                    fw.write(fr.read(filename))
                target.chmod(0o755)


def extract(download_file: Path, exe_file: str) -> None:
    if download_file.suffix in ["", ".appimage"]:
        target = RUN_DIR / exe_file
        print(download_file, target)
        shutil.copyfile(download_file, target)
        target.chmod(0o755)
    elif download_file.suffix == ".zip":
        extract_zip(download_file, exe_file)
    elif download_file.suffix == ".tbz":
        extract_tar(download_file, "r:bz2", exe_file)
    elif download_file.suffixes[-2] == ".tar" and download_file.suffixes[-1] == ".gz":
        extract_tar(download_file, "r:gz", exe_file)


def download(download_url: str, download_file: Path) -> None:
    with requests.get(download_url, stream=True) as response:
        response.raise_for_status()
        file_size = int(response.headers["content-length"])
        pbar = tqdm(
            desc="Downloading",
            total=file_size,
            ncols=100,
            unit="B",
            unit_scale=True,
            unit_divisor=1024,
        )
        with open(download_file, "wb") as fw:
            for chunk in response.iter_content(8192):
                fw.write(chunk)
                pbar.update(len(chunk))
        pbar.close()


def upgrade_fixed_pkg(package: str, requires_download: bool) -> None:
    # EXAMPLE
    #  package: fzf
    #  release: https://github.com/junegunn/fzf/releases/tag/v0.66.1
    # pkg_file: fzf-0.66.1-linux_amd64.tar.gz
    # exe_file: fzf

    release, pkg_file, exe_file = FIXED_PKGS[package]
    download_url = release + "/" + pkg_file
    download_file = DOWNLOAD_DIR / pkg_file

    if requires_download:
        download(download_url, download_file)

    extract(download_file, exe_file)


def upgrade_package(package: str, requires_download: bool) -> None:
    package_info_file = Path("./packages.json")
    if package_info_file.exists():
        with open(package_info_file, "r", encoding="utf-8") as fr:
            package_info = json.load(fr)
    else:
        package_info = {}

    # EXAMPLE
    #   package: yazi
    #      repo: sxyazi/yazi
    #  pkg_file: yazi-x86_64-unknown-linux-musl
    # exe_files: ["yazi", "ya"]

    repo, pkg_file, exe_files = PACKAGES[package]

    url = f"https://github.com/{repo}/releases/latest"
    response = requests.get(url)
    response.raise_for_status()

    latest = response.url.split("/")[-1]

    requires_upgrade = False
    if package in package_info:
        if package_info[package] != latest:
            requires_upgrade = True
    else:
        requires_upgrade = True

    if requires_upgrade:
        version = package_info[package] if package in package_info else "none"
        print(f"{package}: current {version} | latest {latest}")

        download_url = (
            f"https://github.com/{repo}/releases/download/{latest}/{pkg_file}"
        )
        download_file = DOWNLOAD_DIR / pkg_file

        if requires_download:
            download(download_url, download_file)

        if isinstance(exe_files, str):
            exe_file = exe_files
            extract(download_file, exe_file)
        elif isinstance(exe_files, list):
            for exe_file in exe_files:
                extract(download_file, exe_file)
        package_info[package] = latest

        with open(package_info_file, "w", encoding="utf-8") as fw:
            json.dump(package_info, fw, ensure_ascii=False, indent=2)
    else:
        print(f"{package} is the latest")


def main(cfg) -> None:
    requires_download = not cfg.skip_download

    if cfg.package == "all":  # 更新全部
        for package in FIXED_PKGS.keys():
            upgrade_fixed_pkg(package, requires_download)
        for package in PACKAGES.keys():
            upgrade_package(package, requires_download)
    else:  # 更新指定包
        package = cfg.package
        if package in FIXED_PKGS:
            upgrade_fixed_pkg(package, requires_download)
        elif package in PACKAGES:
            upgrade_package(package, requires_download)
        else:
            raise KeyError(f"package {package} is not included")


if __name__ == "__main__":
    if sys.platform == "linux":
        parser = ArgumentParser()
        subparsers = parser.add_subparsers()
        upgrade_parser = subparsers.add_parser("upgrade")
        upgrade_parser.add_argument("package", default="all", type=str)
        upgrade_parser.add_argument("--skip-download", action="store_true")
        main(parser.parse_args())
    else:
        print(f"This script is only for linux, get {sys.platform} instead!")
