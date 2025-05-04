vim.filetype.add({
  extension = { rasi = "rasi", rofi = "rasi", mdx = "markdown", cshtml = "razor", razor = "razor" },
  filename = {
    [".git/ignore"] = "gitignore",
    [".npmignore"] = "ignore",
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*/kitty/*.conf"] = "bash",
    [".*/waybar/config"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "sh",
    [".*/%.vscode/.*%.json"] = "jsonc",
    ["tsconfig*.json"] = "jsonc",
    ["*.mts"] = "typescript",
    ["*.mjs"] = "javascript",
    ["*.cts"] = "typescript",
    ["*.cjs"] = "javascript",
  },
})
