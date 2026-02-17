return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_markers = { '.git' },
    settings = {
        yaml = {
            schemas = {
                -- Add schemas as needed, e.g.:
                -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
        },
    },
}
