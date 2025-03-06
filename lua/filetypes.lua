vim.filetype.add({
  extension = { rasi = 'rasi', rofi = 'rasi', mdx = 'markdown' },
  filename = {
    ['.npmignore'] = 'ignore',
  },
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['.*/kitty/*.conf'] = 'bash',
    ['.*/waybar/config'] = 'jsonc',
    ['%.env%.[%w_.-]+'] = 'sh',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
    ['tsconfig*.json'] = 'jsonc',
  },
})
