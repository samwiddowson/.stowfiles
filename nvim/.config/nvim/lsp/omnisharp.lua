return {
    cmd = {
        "/home/sam/.local/share/nvim/mason/bin/omnisharp-mono",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid())
    },
    root_dir = require "lspconfig".util.root_pattern("*.sln", "*.csproj", ".git"),
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
}
