local luasnip = require("luasnip")
local insert = luasnip.insert_node
local snippet = luasnip.snippet
local text = luasnip.text_node
local fn = luasnip.function_node
local fmt = require("luasnip.extras.fmt").fmt

local same_as = function(args)
    return args[1]
end

luasnip.add_snippets("python", {
    -- ╭───────────────────────────────────────────╮
    -- │                  Packages                 │
    -- ╰───────────────────────────────────────────╯
    snippet("enum", text("from enum import Enum")),
    snippet("np", text("import numpy as np")),
    snippet("pd", text("import pandas as pd")),
    snippet("path", text("from pathlib import Path")),
    snippet("rich", text("from rich import print")),
    snippet("tqdm", text("from tqdm import tqdm")),
    snippet("typing", text("from typing import Literal, Optional")),

    -- ╭───────────────────────────────────────────╮
    -- │                    Main                   │
    -- ╰───────────────────────────────────────────╯
    snippet("pyright-ignore", text("# pyright: ignore")),

    -- ╭───────────────────────────────────────────╮
    -- │                    Main                   │
    -- ╰───────────────────────────────────────────╯
    snippet(
        "main",
        fmt(
            [[
from argparse import ArgumentParser


def main(cfg) -> None:
    pass


if __name__ == "__main__":
    parser = ArgumentParser()
    {}

    main(parser.parse_args())
            ]],
            insert(1)
        )
    ),
    snippet("add_argument", fmt("parser.add_argument({})", insert(1))),

    -- ╭───────────────────────────────────────────╮
    -- │                    Main                   │
    -- ╰───────────────────────────────────────────╯
    snippet(
        "fr",
        fmt(
            [[
with open({}, "r", encoding="utf-8") as fr:
    {}
            ]],
            { insert(1, "filename"), insert(2, "pass") }
        )
    ),
    snippet(
        "fw",
        fmt(
            [[
with open({}, "w", encoding="utf-8") as fw:
    {}
            ]],
            { insert(1, "filename"), insert(2, "pass") }
        )
    ),

    -- ╭───────────────────────────────────────────╮
    -- │                   Image                   │
    -- ╰───────────────────────────────────────────╯
    snippet("pil", text("from PIL import Image")),
    snippet(
        "imread",
        fmt(
            [[
{} = np.fromfile({}, np.uint8)
{} = cv2.imdecode({}, cv2.IMREAD_UNCHANGED)
            ]],
            { insert(1, "image"), insert(2, "img_file"), fn(same_as, 1), fn(same_as, 1) }
        )
    ),
    snippet(
        "imwrite1",
        fmt(
            "cv2.imencode({}, {})[1].tofile({})",
            { insert(1, "suffix"), insert(2, "image"), insert(3, "img_file") }
        )
    ),
    snippet(
        "bgr2rgb",
        fmt("{} = cv2.cvtColor({}, cv2.COLOR_BGR2RGB)", { insert(1, "image"), fn(same_as, 1) })
    ),
    snippet(
        "rgb2gray",
        fmt("{} = cv2.cvtColor({}, cv2.COLOR_RGB2GRAY)", { insert(1, "image"), fn(same_as, 1) })
    ),
    snippet(
        "rgb2bgr",
        fmt("{} = cv2.cvtColor({}, cv2.COLOR_RGB2BGR)", { insert(1, "image"), fn(same_as, 1) })
    ),

    -- ╭───────────────────────────────────────────╮
    -- │                Matplotlib                 │
    -- ╰───────────────────────────────────────────╯
    snippet(
        "matplotlib",
        text({
            "import matplotlib.pyplot as plt",
            "from matplotlib import font_manager",
            "from matplotlib.axes import Axes",
        })
    ),
    snippet(
        "songti",
        fmt(
            [[
font_manager.fontManager.addfont("{}")
plt.rcParams["font.sans-serif"] = ["Songti SC"]
plt.rcParams["axes.unicode_minus"] = False
            ]],
            { insert(1, "Songti.ttc") }
        )
    ),
    snippet(
        "subplots",
        text({
            "fig, ax = plt.subplots()",
            "ax: Axes",
        })
    ),

    -- ╭───────────────────────────────────────────╮
    -- │                  PySide6                  │
    -- ╰───────────────────────────────────────────╯
    snippet("core", text("from PySide6.QtCore import Property, QObject, Qt, QUrl, Signal, Slot")),
    snippet("gui", text("from PySide6.QtGui import QGuiApplication")),
    snippet(
        "qml",
        text({
            "from PySide6.QtQml import (",
            "    QmlElement,",
            "    QmlSingleton,",
            "    QQmlApplicationEngine,",
            "    qmlRegisterSingletonType,",
            "    qmlRegisterType,",
            ")",
        })
    ),
    snippet(
        "qml_import",
        fmt(
            [[
QML_IMPORT_NAME = "{}"
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0
            ]],
            { insert(1, "module") }
        )
    ),
})
