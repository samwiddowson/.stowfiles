return  {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require'cmp'

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.scroll_docs(1),
                ['<C-p>'] = cmp.mapping.scroll_docs(-1),
                ['<C-y>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
        })
    end
}
