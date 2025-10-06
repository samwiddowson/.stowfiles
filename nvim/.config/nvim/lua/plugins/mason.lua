return
{
    'mason-org/mason.nvim',
    dependencies = {
        'mason-org/mason-registry'
    },
    config = function()
        require('mason').setup({
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            }
        })
        require('mason-registry').refresh()
    end
}
