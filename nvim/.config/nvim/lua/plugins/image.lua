return {
    -- This plugin has an issue with displaying images in tmux windows.
    -- When the image is displayed, switching to another tmux session without
    -- switching window causes the image to remain visible until it is no longer
    -- rendered in the original window.
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
        processor = "magick_cli",
    },
    config = function(_, opts)
        require("image").setup({
            backend = "kitty",        -- or "ueberzug" or "sixel"
            processor = "magick_cli", -- or "magick_rock"
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    only_render_image_at_cursor_mode = "popup", -- "popup" or "inline"
                    floating_windows = false,                   -- if true, images will be rendered in floating markdown windows
                    filetypes = { "markdown", "vimwiki" },      -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = false,
                    filetypes = { "norg" },
                },
                typst = {
                    enabled = false,
                    filetypes = { "typst" },
                },
                html = {
                    enabled = true,
                    filetypes = { "html", "htm" },
                },
                css = {
                    enabled = true,
                    filetypes = { "css", "scss", "sass" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            scale_factor = 1.0,
            window_overlap_clear_enabled = false,                                               -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
            editor_only_render_when_focused = true,                                             -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = true,                                             -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
        })
    end,

}
