local vim = vim

-- Muat konfigurasi LSP default dari NvChad
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Daftar LSP servers yang akan digunakan.
-- Perhatikan: gunakan "ruff" (server bawaan Ruff) bukan "ruff_lsp"
local servers = { "lua_ls", "ruff", "pyright" }

-- Setup masing-masing LSP server dengan konfigurasi default NvChad
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end

-- Konfigurasi khusus untuk Pyright.
-- Nonaktifkan organize imports dan sebagian analisis karena kita menggunakan Ruff
lspconfig.pyright.setup {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = { ignore = { "*" } } },
  },
}

-- Konfigurasi khusus untuk server bahasa bawaan Ruff.
lspconfig.ruff.setup {
  capabilities = capabilities,
  init_options = {
    settings = {
      -- Anda dapat menambahkan argumen khusus misalnya: { "--extend-select=ALL" }
      args = {},
    },
  },
}

-- Setup nvim-cmp (completion) beserta integrasi luasnip
local cmp = require "cmp"
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "otter" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
}
