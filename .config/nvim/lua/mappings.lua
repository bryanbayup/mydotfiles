require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General Settings
vim.cmd [[
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set relativenumber
]]
vim.g.mapleader = " "
vim.opt.termguicolors = true

-- Key Mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<Esc>", "<C-\\><C-n>")

-- Window Resizing
map("n", "<A-h>", "<C-w><", opts) -- Kurangi lebar window
map("n", "<A-l>", "<C-w>>", opts) -- Tambah lebar window
map("n", "<A-k>", "<C-w>+", opts) -- Tambah tinggi window
map("n", "<A-j>", "<C-w>-", opts) -- Kurangi tinggi window

-- Run Python Script
map("n", "<leader>r", ":w<CR>:!python %<CR>", opts)

-- Insert Python Code Block
map("i", "<leader>cp", function()
  local start_code = "```python"
  local end_code = "```"
  local line = vim.fn.line "."

  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { start_code })
  vim.api.nvim_buf_set_lines(0, line + 1, line + 1, false, { end_code })
  vim.fn.cursor(line + 1, 1)
end, { desc = "Insert Python Code Block with cursor inside" })

-- Autocommand for New .ipynb File Template
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
cells: []
---

```python
print("test")
```
    ]]
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
  end,
})
