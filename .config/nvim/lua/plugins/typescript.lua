return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "ts_ls", "eslint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.ts_ls = {}
      opts.servers.eslint = {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.highlight_filetypes = opts.highlight_filetypes or {}
      vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx" })
      vim.list_extend(opts.highlight_filetypes, {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.javascriptreact = { "prettier" }
      opts.formatters_by_ft.typescript = { "prettier" }
      opts.formatters_by_ft.typescriptreact = { "prettier" }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.languages = opts.languages or {}
      vim.list_extend(opts.ensure_installed, { "js" })

      opts.languages.typescript = function(context)
        local adapter_path = context.get_package_path("js-debug-adapter", "js-debug/src/dapDebugServer.js")
        if not adapter_path then
          context.warn("js-debug-adapter is not installed yet. Run :Mason or :Lazy sync before debugging TypeScript.")
          return
        end

        context.dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = { adapter_path, "${port}" },
          },
        }

        context.dap.adapters["pwa-chrome"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = { adapter_path, "${port}" },
          },
        }

        for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
          context.dap.configurations[lang] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach to process",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Debug Jest tests",
              runtimeExecutable = "node",
              runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand" },
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Debug npm script (dev)",
              runtimeExecutable = "npm",
              runtimeArgs = { "run", "dev" },
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              console = "integratedTerminal",
            },
            {
              type = "pwa-chrome",
              request = "launch",
              name = "Debug in Chrome (Vite :5173)",
              url = "http://localhost:5173",
              webRoot = "${workspaceFolder}",
              sourceMaps = true,
            },
            {
              type = "pwa-chrome",
              request = "launch",
              name = "Debug in Chrome (CRA :3000)",
              url = "http://localhost:3000",
              webRoot = "${workspaceFolder}",
              sourceMaps = true,
            },
          }
        end
      end
    end,
  },
}