return {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
        { "blazkowolf/gruber-darker.nvim" },
        { "neanias/everforest-nvim" },
        { "catppuccin/nvim" },
        { "xero/miasma.nvim" },
        { 'sainnhe/gruvbox-material' },
    },
    config = function()
        require("everforest").setup({
            colours_override = function(palette)
                -- palette.green = "#dbbc7f"
                -- palette.yellow = "#a7c080"
            end
        })
    end
}
