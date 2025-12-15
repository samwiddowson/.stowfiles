return {
    root_markers = { "pyrightconfig.json", ".git" },
    settings = {
        basedpyright = {
            config = {
                typeCheckingMode = "basic"
            }
        },
        -- TODO: remove when finished troubleshooting venv/dependency issue
        -- python = {
        --     pythonPath = "/Users/sam.widdowson/.pyenv/versions/3.9.25/envs/concord/bin/python"
        -- }
    }
}
