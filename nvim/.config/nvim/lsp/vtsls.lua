local vueLanguageServerLocation = vim.fn.stdpath 'data' ..
    '/mason/packages/vue-language-server/node_modules/@vue/language-server'

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vueLanguageServerLocation,
    languages = { 'vue' },
    configNamespace = 'typescript',
}

return {
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
    root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
}
