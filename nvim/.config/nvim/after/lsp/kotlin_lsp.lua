return {
    cmd = vim.lsp.rpc.connect('127.0.0.1', 9999),
    root_markers = {
        { 'settings.gradle.kts', 'settings.gradle' },
        { 'build.gradle.kts',    'build.gradle',   'pom.xml' },
    },
}
