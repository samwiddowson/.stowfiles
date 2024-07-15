return {
    'xiyaowong/transparent.nvim',
    build = ':TransparentEnable',
    config = function()
        require("transparent").setup({
            extra_groups = {
                'NormalFloat'
            }
        })
    end
}
