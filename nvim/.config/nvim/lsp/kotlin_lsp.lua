return {
    cmd = vim.lsp.rpc.connect('127.0.0.1', 9999),
    cmd_env = { IJ_JAVA_OPTIONS = '-Xmx8g' },
    root_markers = {
        { 'settings.gradle.kts', 'settings.gradle' },
        { 'build.gradle.kts',    'build.gradle',   'pom.xml' },
    },
}
