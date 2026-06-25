vim.lsp.enable("lua_ls")
-- vim.lsp.enable("jsonls")
-- vim.lsp.enable('eslint')
-- vim.lsp.enable('html')
-- vim.lsp.enable('markdown_oxide')
vim.lsp.enable('groovyls')
vim.lsp.enable('basedpyright')
vim.lsp.enable('taplo')
vim.lsp.enable('helm-ls')
vim.lsp.enable('yaml-language-server')
vim.lsp.enable('copilot-language-server')
vim.lsp.enable('ts_ls')
-- vim.lsp.enable('kube-linter')
-- vim.lsp.enable('rust-analyzer')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup', 'preview' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end

        if client.name == "ts_ls" then
            vim.keymap.set("n", "<Leader>T", ":LspTypescriptSourceAction<CR>",
                { buffer = ev.buf, desc = "[typescript] organize imports" })
            vim.keymap.set("n", "gop", ":LspTypescriptGoToSourceDefinition<CR>",
                { buffer = ev.buf, desc = "[typescript] Go to definition" })
        end
    end,
})

vim.diagnostic.config({
    virtual_lines = false,
})
