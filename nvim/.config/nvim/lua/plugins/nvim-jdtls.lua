return {
    'mfussenegger/nvim-jdtls',
    config = function()
        local jdtlsLanguageServerLocation = vim.fn.stdpath 'data' ..
            '/mason/packages/jdtls/bin/jdtls'
        local project_root = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])

        if project_root ~= "" then
            require('jdtls').start_or_attach({
                cmd = { jdtlsLanguageServerLocation },
                root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
            })
            vim.keymap.set('n', '<A-o>', '<Cmd>lua require"jdtls".organize_imports()<CR>')
            vim.keymap.set('n', 'crv', '<Cmd>lua require("jdtls").extract_variable()<CR>')
            vim.keymap.set('v', 'crv', '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>')
            vim.keymap.set('n', 'crc', '<Cmd>lua require("jdtls").extract_constant()<CR>')
            vim.keymap.set('v', 'crc', '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>')
            vim.keymap.set('v', 'crm', '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR> ')
        end
    end,
}
