return
{
    'mason-org/mason.nvim',
    config = function()
        require('mason').setup({})
        require('mason-registry').refresh()
    end
}
