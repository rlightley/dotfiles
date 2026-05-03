return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "theHamsta/nvim-dap-virtual-text",
      { "jay-babu/mason-nvim-dap.nvim", dependencies = "williamboman/mason.nvim" },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional BP" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
      { "<leader>df", function() require("dapui").float_element() end, desc = "Float element" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "REPL" },
    },
    opts = {
      ensure_installed = {},
      languages = {},
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      local function warn(message)
        vim.schedule(function()
          vim.notify(message, vim.log.levels.WARN)
        end)
      end

      local function get_package_path(package_name, relative_path)
        local ok, registry = pcall(require, "mason-registry")
        if not ok or not registry.has_package(package_name) then
          return nil
        end

        local package = registry.get_package(package_name)
        if not package:is_installed() then
          return nil
        end

        local package_path = package:get_install_path()
        if relative_path then
          package_path = package_path .. "/" .. relative_path
        end

        if vim.uv.fs_stat(package_path) then
          return package_path
        end

        return nil
      end

      -- Breakpoint icons (using unicode circles that work in most terminals)
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

      -- Highlight colors for breakpoints
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f9a825" })
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#757575" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#007acc" })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#4caf50" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e3d29" })

      require("mason-nvim-dap").setup({
        ensure_installed = opts.ensure_installed or {},
        automatic_installation = true,
      })

      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
      })

      -- Beautiful DAP UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        element_mappings = {},
        expand_lines = true,
        force_buffers = true,
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.4 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks", size = 0.2 },
              { id = "watches", size = 0.2 },
            },
            size = 50,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.8,
          max_width = 0.8,
          border = "rounded",
          mappings = { close = { "q", "<Esc>" } },
        },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
            disconnect = "",
          },
        },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
          indent = 1,
        },
      })

      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

      for _, setup_language in pairs(opts.languages or {}) do
        setup_language({
          dap = dap,
          dapui = dapui,
          get_package_path = get_package_path,
          warn = warn,
        })
      end
    end,
  },
}
