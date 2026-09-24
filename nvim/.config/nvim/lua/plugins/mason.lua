return
{
    'mason-org/mason.nvim',
    config = function()
        require('mason').setup({})
        require('mason-registry').refresh()

        local registry = require('mason-registry')
        if registry.has_package('js-debug-adapter') and not registry.is_installed('js-debug-adapter') then
            registry.get_package('js-debug-adapter'):install()
        end
    end
}
