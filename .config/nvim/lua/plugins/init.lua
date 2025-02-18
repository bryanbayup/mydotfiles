return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "python",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
      },
    },
  },

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

  {
    "goerz/jupytext.nvim",
    version = "0.2.0",
    lazy = false,
    config = function()
      require("jupytext").setup {
        jupytext = "jupytext",
        format = "markdown",
        update = true,
        filetype = require("jupytext").get_filetype,
        new_template = require("jupytext").default_new_template(),
        sync_patterns = { "*.md", "*.py", "*.jl", "*.R", "*.Rmd", "*.qmd" },
        autosync = true,
        handle_url_schemes = true,
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

      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Molten Init Kernel" })
      vim.keymap.set(
        "n",
        "<leader>ml",
        ":MoltenEvaluateLine<CR>:MoltenEnterOutput<CR>",
        { silent = true, desc = "Molten Evaluate Line" }
      )
      vim.keymap.set(
        "v",
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<CR>:MoltenEnterOutput<CR>gv<ESC>",
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
}
