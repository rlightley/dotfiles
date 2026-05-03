return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gopls" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            completeUnimported = true,
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.highlight_filetypes = opts.highlight_filetypes or {}
      vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      vim.list_extend(opts.highlight_filetypes, { "go", "gomod", "gosum", "gowork" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.go = { "goimports", "gofmt" }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
    },
    keys = {
      { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go test" },
      { "<leader>dgT", function() require("dap-go").debug_last_test() end, desc = "Debug last Go test" },
    },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.languages = opts.languages or {}
      vim.list_extend(opts.ensure_installed, { "delve" })

      opts.languages.go = function(context)
        local delve_path = context.get_package_path("delve", "dlv")
        if not delve_path or delve_path == "" then
          delve_path = vim.fn.exepath("dlv")
        end

        local setup_opts = {}
        if delve_path and delve_path ~= "" then
          setup_opts.delve = { path = delve_path }
        else
          context.warn("Delve is not installed yet. Run :Mason before debugging Go.")
        end

        require("dap-go").setup(setup_opts)
      end
    end,
  },
}