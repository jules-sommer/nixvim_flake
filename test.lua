vim.lsp.config['nil'] = {
        autostart = true,
        capabilities = caps,
        cmd = { lsp_path },
        settings = {
                ['nil'] = {
                        formatting = {
                                command = { "nixfmt" },
                        },
                },
        },
}
