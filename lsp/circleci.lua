vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemas = {
        ['https://json.schemastore.org/circleciconfig.json'] = '/.circleci/config.yml',
      },
    },
  },
})

return {
  cmd = { 'circleci-yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = { '.circleci' },
}
