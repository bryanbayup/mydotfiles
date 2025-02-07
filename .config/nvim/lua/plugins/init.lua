local vim = vim

return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Format otomatis saat save
    opts = require "configs.conform",
  },

  -- LSP Config & Tools
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "ruff", "pyright" },
      }
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "python", "markdown", "markdown_inline", "vim", "vimdoc" },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  -- Data Science Plugins
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  -- {
  --   "GCBallesteros/jupytext.nvim",
  --   lazy = false,
  --   config = function()
  --     require("jupytext").setup {
  --       style = "markdown",
  --       output_extension = "md",
  --       force_ft = "markdown",
  --     }
  --   end,
  -- },
  {
    "goerz/jupytext.nvim",
    version = "0.2.0",
    lazy = false,
    config = function()
      require("jupytext").setup {
        jupytext = "jupytext", -- Pastikan jupytext ada di PATH
        format = "markdown", -- Menggunakan format markdown
        update = true, -- Menjaga output yang ada saat menyimpan
        filetype = require("jupytext").get_filetype, -- Menentukan filetype
        new_template = require("jupytext").default_new_template(),
        sync_patterns = { "*.md", "*.py", "*.jl", "*.R", "*.Rmd", "*.qmd" },
        autosync = true, -- Sinkronisasi otomatis dengan Jupyter
        handle_url_schemes = true, -- Menangani skema URL seperti oil-ssh://
      }
    end,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    lazy = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 1

      -- Keymaps untuk Molten
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Molten Init Kernel" })
      vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Molten Evaluate Line" })
      vim.keymap.set(
        "v",
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<CR>gv<ESC>",
        { silent = true, desc = "Molten Evaluate Visual" }
      )
      vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "Molten Hide Output" })
      vim.keymap.set(
        "n",
        "<leader>mo",
        ":noautocmd MoltenEnterOutput<CR>",
        { silent = true, desc = "Molten Enter Output" }
      )
    end,
  },

  -- Null-ls (Formatter tambahan)
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
        },
      }
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },

  -- Quarto Support
  {
    "quarto-dev/quarto-nvim",
    lazy = false,
    ft = { "quarto", "markdown" },
    config = function()
      require("quarto").setup {
        lspFeatures = {
          languages = { "r", "python", "rust" },
          chunks = "all",
          diagnostics = { enabled = true, triggers = { "BufWritePost" } },
          completion = { enabled = true },
        },
        keymap = {
          hover = "H",
          definition = "gd",
          rename = "<leader>rn",
          references = "gr",
          format = "<leader>gf",
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      }
    end,
    dependencies = {
      "jmbuhr/otter.nvim",
    },
  },

  -- Telescope UI Select
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },

  -- Markdown dan Obsidian Support
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-web-devicons" },
    opts = {},
    config = function()
      require("render-markdown").setup {}
    end,
  },
  {
    "vimwiki/vimwiki",
    config = function()
      require("render-markdown").setup {
        file_types = { "markdown", "vimwiki" },
      }
      vim.treesitter.language.register("markdown", "vimwiki")
    end,
  },
}
