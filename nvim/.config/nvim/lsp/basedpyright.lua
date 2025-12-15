return {
    root_dir = require('lspconfig.util').root_pattern('pyrightconfig.json', '.git'),
    settings = {
        basedpyright = {
            config = {
                typeCheckingMode = "basic"
            }
        }
    }
}
