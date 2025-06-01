return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    settings = {
        basedpyright = {
            disableOrganizedImport = true,
            analysis = {
                autoImportCompletions = false,
                inlayHints = { variableTypes = false },
                typeCheckingMode = "basic",
            },
        },
    },
}
