vim.filetype.add {
  extension = { rasi = 'rasi', rofi = 'rasi' },
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['.*/kitty/*.conf'] = 'bash',
    ['.*/waybar/config'] = 'jsonc',
    ['%.env%.[%w_.-]+'] = 'sh',
  },
}
