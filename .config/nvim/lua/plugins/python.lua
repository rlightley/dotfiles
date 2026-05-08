return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "pyright", "ruff" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.pyright = {}
      opts.servers.ruff = {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.highlight_filetypes = opts.highlight_filetypes or {}
      vim.list_extend(opts.ensure_installed, { "python", "requirements" })
      vim.list_extend(opts.highlight_filetypes, { "python", "requirements" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.python = { "ruff_fix", "ruff_format" }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>dpt", function() require("dap-python").test_method() end, desc = "Debug Python test method" },
      { "<leader>dpc", function() require("dap-python").test_class() end, desc = "Debug Python test class" },
    },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.languages = opts.languages or {}
      vim.list_extend(opts.ensure_installed, { "python" })

      opts.languages.python = function(context)
        local debugpy_python = context.get_package_path("debugpy", "venv/bin/python")
        if not debugpy_python then
          context.warn("debugpy is not installed yet. Run :Mason before debugging Python.")
          return
        end

        require("dap-python").setup(debugpy_python)
      end
    end,
  },
}