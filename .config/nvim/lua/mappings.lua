local vim = vim
require "nvchad.mappings"

vim.cmd "set expandtab"
vim.cmd "set tabstop=2"
vim.cmd "set softtabstop=2"
vim.cmd "set shiftwidth=2"
vim.cmd "set relativenumber"
vim.g.mapleader = " "
vim.opt.termguicolors = true

-- Shortcut untuk masuk ke mode command
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("i", "jk", "<ESC>")

-- Memasukkan blok kode Python dengan kursor di dalamnya
vim.keymap.set("i", "<leader>cp", function()
  local start_code = "```python"
  local end_code = "```"
  local line = vim.fn.line "."

  -- Sisipkan ```python sebelum kursor
  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { start_code })
  -- Sisipkan ``` setelah kursor
  vim.api.nvim_buf_set_lines(0, line + 1, line + 1, false, { end_code })

  -- Pindahkan kursor ke dalam blok kode
  vim.fn.cursor(line + 1, 1)
end, { desc = "Insert Python Code Block with cursor inside" })

local vim = vim
require "nvchad.mappings"

-- Pengaturan tab dan tampilan
vim.cmd "set expandtab"
vim.cmd "set tabstop=2"
vim.cmd "set softtabstop=2"
vim.cmd "set shiftwidth=2"
vim.cmd "set relativenumber"
vim.g.mapleader = " "
vim.opt.termguicolors = true

-- Shortcut untuk masuk ke mode command
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("i", "jk", "<ESC>")

-- Memasukkan blok kode Python dengan kursor di dalamnya
vim.keymap.set("i", "<leader>cp", function()
  local start_code = "```python"
  local end_code = "```"
  local line = vim.fn.line "."

  -- Sisipkan ```python sebelum kursor
  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { start_code })
  -- Sisipkan ``` setelah kursor
  vim.api.nvim_buf_set_lines(0, line + 1, line + 1, false, { end_code })

  -- Pindahkan kursor ke dalam blok kode
  vim.fn.cursor(line + 1, 1)
end, { desc = "Insert Python Code Block with cursor inside" })

-- Autocommand untuk menyisipkan template ke file .ipynb baru
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.ipynb",
  callback = function()
    local template = [[
---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.16.6
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
cells: []     # Tambahan ini membantu memastikan struktur metadata lengkap
---

```python
print("test")
```
]]
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
  end,
})
