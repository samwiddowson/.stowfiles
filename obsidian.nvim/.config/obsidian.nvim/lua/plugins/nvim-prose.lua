return
{
    'skwee357/nvim-prose',
    config = function()
        local nvim_prose = require('nvim-prose')

        nvim_prose.setup {
            wpm = 200.0,
            filetypes = { 'markdown' },
            placeholders = {
                words = 'words',
                minutes = 'min'
            }
        }
    end
}
