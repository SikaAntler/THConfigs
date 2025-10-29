import json
import shutil
import sys
import tarfile
from argparse import ArgumentParser
from pathlib import Path
from zipfile import ZipFile

import requests
from tqdm import tqdm

# fmt: off
PACKAGES = {
  "csvtk": (        "shenwei356/csvtk",                        "csvtk_linux_amd64.tar.gz",        "csvtk"),
    "duf": (              "muesli/duf",                   "duf_0.9.1_linux_x86_64.tar.gz",          "duf"),
   "dust": (           "bootandy/dust",    "dust-v1.2.3-x86_64-unknown-linux-musl.tar.gz",         "dust"),
    "eza": (       "eza-community/eza",            "eza_x86_64-unknown-linux-musl.tar.gz",          "eza"),
     "fd": (              "sharkdp/fd",     "fd-v10.3.0-x86_64-unknown-linux-musl.tar.gz",           "fd"),
    "fzf": (            "junegunn/fzf",                   "fzf-0.65.2-linux_amd64.tar.gz",          "fzf"),
     "jq": (               "jqlang/jq",                                  "jq-linux-amd64",           "jq"),
"lazygit": (   "jesseduffield/lazygit",              "lazygit_0.55.1_linux_x86_64.tar.gz",      "lazygit"),
   "nvim": (           "neovim/neovim",                      "nvim-linux-x86_64.appimage",         "nvim"),
     "rg": (      "BurntSushi/ripgrep", "ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz",           "rg"),
   "tmux": ("nelsonenzo/tmux-appimage",                                   "tmux.appimage",         "tmux"),
     "uv": (            "astral-sh/uv",             "uv-x86_64-unknown-linux-musl.tar.gz",  ["uv", "uvx"]),
   "yazi": (             "sxyazi/yazi",              "yazi-x86_64-unknown-linux-musl.zip", ["yazi", "ya"]),
     "yq": (            "mikefarah/yq",                                  "yq_linux_amd64",           "yq"),
 "zoxide": (      "ajeetdsouza/zoxide",   "zoxide-0.9.8-x86_64-unknown-linux-musl.tar.gz",       "zoxide"),
}
# fmt: on
DOWNLOAD_DIR = Path("~/Downloads/").expanduser()
RUN_DIR = Path("~/.local/bin/").expanduser()


def extract_targz(download_file: Path, package: str) -> None:
    with tarfile.open(download_file, "r:gz") as tar_ref:
        for filename in tar_ref.getnames():
            name = filename.split("/")[-1]
            if name == package:
                target = RUN_DIR / name
                print(f"Extracting {filename} to {target}")
                with open(target, "wb") as fw:
                    file_obj = tar_ref.extractfile(filename)
                    if file_obj:
                        fw.write(file_obj.read())
                target.chmod(0o755)


def extract_zip(download_file: Path, package: str) -> None:
    with ZipFile(download_file) as fr:
        for filename in fr.namelist():
            name = filename.split("/")[-1]
            if name == package:
                target = RUN_DIR / name
                print(f"Extracting {filename} to {target}")
                with open(target, "wb") as fw:
                    fw.write(fr.read(filename))
                target.chmod(0o755)


def extract(download_file: Path, package: str) -> None:
    if download_file.suffix in ["", ".appimage"]:
        target = RUN_DIR / package
        shutil.copyfile(download_file, target)
        target.chmod(0o755)
    elif download_file.suffix == ".zip":
        extract_zip(download_file, package)
    elif download_file.suffixes[-2] == ".tar" and download_file.suffixes[-1] == ".gz":
        extract_targz(download_file, package)


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


def main(cfg) -> None:
    if cfg.package == "all":  # 更新全部
        upgrade_dict = {n: True for n in PACKAGES.keys()}
    else:  # 更新指定包
        upgrade_dict = {n: False for n in PACKAGES.keys()}
        if cfg.package in upgrade_dict:
            upgrade_dict[cfg.package] = True
        else:
            raise KeyError(f"package {cfg.package} is not included")

    package_info_file = Path("./packages.json")
    if package_info_file.exists():
        with open(package_info_file, "r", encoding="utf-8") as fr:
            package_info = json.load(fr)
    else:
        package_info = {}

    for pkg_name, (repo, pkg_file, executable_files) in PACKAGES.items():
        #         pkg_name: yazi
        #             repo: sxyazi/yazi
        #         pkg_file: yazi-x86_64-unknown-linux-musl
        # executable_files: ["yazi", "ya"]
        try:
            if not upgrade_dict[pkg_name]:
                continue

            url = f"https://github.com/{repo}/releases/latest"
            response = requests.get(url)
            response.raise_for_status()

            latest = response.url.split("/")[-1]

            requires_upgrade = False
            if pkg_name in package_info:
                if package_info[pkg_name] != latest:
                    requires_upgrade = True
            else:
                requires_upgrade = True

            if requires_upgrade:
                version = package_info[pkg_name] if pkg_name in package_info else "none"
                print(f"{pkg_name}: current {version} | latest {latest}")
                download_url = (
                    f"https://github.com/{repo}/releases/download/{latest}/{pkg_file}"
                )
                download_file = DOWNLOAD_DIR / pkg_file
                download(download_url, download_file)
                extract(download_file, pkg_name)
                if isinstance(executable_files, list):
                    for pkg_name in executable_files[1:]:
                        extract(download_file, pkg_name)
                package_info[pkg_name] = latest
            else:
                print(f"{pkg_name} is the latest")

        except requests.exceptions.RequestException as e:
            print(e)
            break

        else:
            with open(package_info_file, "w", encoding="utf-8") as fw:
                json.dump(package_info, fw, ensure_ascii=False, indent=2)


if __name__ == "__main__":
    if sys.platform == "linux":
        parser = ArgumentParser()
        subparsers = parser.add_subparsers()
        upgrade_parser = subparsers.add_parser("upgrade")
        upgrade_parser.add_argument("package", default="all", type=str)
        main(parser.parse_args())
    else:
        print(f"This script is only for linux, get {sys.platform} instead!")
