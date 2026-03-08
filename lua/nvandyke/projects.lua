if vim.loop.cwd():find('polco-node', nil, true) then
  vim.o.makeprg = 'yarn build:typescript'
end
