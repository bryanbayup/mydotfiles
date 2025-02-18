-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "lua_ls", "ruff", "pyright" }
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.pyright.setup {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = { ignore = { "*" } } },
  },
}

lspconfig.ruff.setup {
  capabilities = capabilities,
  init_options = {
    settings = {
      -- Dapat menambahkan argumen khusus misalnya: { "--extend-select=ALL" }
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
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "otter" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
