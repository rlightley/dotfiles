local function command_exists(command)
  return vim.fn.executable(command) == 1
end

local function notify_missing(command)
  vim.notify(command .. " is not installed or not on PATH", vim.log.levels.WARN)
end

local function current_namespace()
  return vim.g.platform_namespace or "default"
end

local function open_float_command(cmd, name)
  local Terminal = require("toggleterm.terminal").Terminal
  local terminal = Terminal:new({
    cmd = cmd,
    direction = "float",
    close_on_exit = false,
    hidden = true,
    display_name = name,
  })

  terminal:toggle()
end

local function telescope_picker(title, results, on_select)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = title,
    finder = finders.new_table({ results = results }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          on_select(selection[1])
        end
      end)
      return true
    end,
  }):find()
end

local function pick_kubectl_context()
  if not command_exists("kubectl") then
    notify_missing("kubectl")
    return
  end

  local contexts = vim.fn.systemlist({ "kubectl", "config", "get-contexts", "-o", "name" })
  if vim.v.shell_error ~= 0 or #contexts == 0 then
    vim.notify("No kubectl contexts found", vim.log.levels.WARN)
    return
  end

  telescope_picker("Kubernetes Contexts", contexts, function(selection)
    vim.fn.system({ "kubectl", "config", "use-context", selection })
    if vim.v.shell_error == 0 then
      vim.notify("Switched kubectl context to " .. selection, vim.log.levels.INFO)
    else
      vim.notify("Failed to switch kubectl context", vim.log.levels.ERROR)
    end
  end)
end

local function pick_kubernetes_namespace()
  if not command_exists("kubectl") then
    notify_missing("kubectl")
    return
  end

  local namespaces = vim.fn.systemlist({ "kubectl", "get", "namespaces", "-o", "jsonpath={range .items[*]}{.metadata.name}{'\n'}{end}" })
  if vim.v.shell_error ~= 0 or #namespaces == 0 then
    vim.notify("No Kubernetes namespaces found", vim.log.levels.WARN)
    return
  end

  telescope_picker("Kubernetes Namespaces", namespaces, function(selection)
    vim.g.platform_namespace = selection
    vim.notify("Set active namespace to " .. selection, vim.log.levels.INFO)
  end)
end

local function kubectl_cmd(args, name)
  if not command_exists("kubectl") then
    notify_missing("kubectl")
    return
  end

  open_float_command("kubectl -n " .. current_namespace() .. " " .. args, name)
end

local function helm_cmd(args, name)
  if not command_exists("helm") then
    notify_missing("helm")
    return
  end

  open_float_command("helm -n " .. current_namespace() .. " " .. args, name)
end

local function kubectl_logs()
  if not command_exists("kubectl") then
    notify_missing("kubectl")
    return
  end

  vim.ui.input({ prompt = "Pod for kubectl logs: " }, function(pod)
    if not pod or pod == "" then
      return
    end
    kubectl_cmd("logs -f " .. pod, "kubectl logs")
  end)
end

return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bashls",
        "dockerls",
        "helm_ls",
        "terraformls",
        "yamlls",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.bashls = {}
      opts.servers.dockerls = {}
      opts.servers.helm_ls = {}
      opts.servers.terraformls = {}
      opts.servers.yamlls = {
        settings = {
          yaml = {
            keyOrdering = false,
            validate = true,
            format = { enable = true },
            hover = true,
            completion = true,
            schemas = {
              kubernetes = { "k8s/**/*.yaml", "k8s/**/*.yml", "kubernetes/**/*.yaml", "kubernetes/**/*.yml" },
              ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
              ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
            },
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
      vim.list_extend(opts.ensure_installed, { "bash", "dockerfile", "helm", "hcl", "terraform", "toml", "yaml" })
      vim.list_extend(opts.highlight_filetypes, { "bash", "dockerfile", "helm", "hcl", "sh", "terraform", "toml", "yaml", "zsh" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.bash = { "shfmt" }
      opts.formatters_by_ft.hcl = { "terraform_fmt" }
      opts.formatters_by_ft.sh = { "shfmt" }
      opts.formatters_by_ft.terraform = { "terraform_fmt" }
      opts.formatters_by_ft.yaml = { "prettier" }
      opts.formatters_by_ft.zsh = { "shfmt" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        bash = { "shellcheck" },
        dockerfile = { "hadolint" },
        helm = { "yamllint" },
        sh = { "shellcheck" },
        terraform = { "tflint" },
        yaml = { "yamllint" },
        zsh = { "shellcheck" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("platform_linting", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          require("lint").try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>xl", function()
        require("lint").try_lint()
      end, { desc = "Lint current file" })
    end,
  },
  {
    "towolf/vim-helm",
    ft = { "helm" },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics list" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>kc", pick_kubectl_context, desc = "Kube context" },
      { "<leader>kn", pick_kubernetes_namespace, desc = "Kube namespace" },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<leader>kp", function() kubectl_cmd("get pods", "kubectl pods") end, desc = "Kube pods" },
      { "<leader>kd", function() kubectl_cmd("get deploy", "kubectl deploy") end, desc = "Kube deployments" },
      { "<leader>ks", function() kubectl_cmd("get svc", "kubectl services") end, desc = "Kube services" },
      { "<leader>kl", kubectl_logs, desc = "Kube logs" },
      { "<leader>kh", function() helm_cmd("list", "helm list") end, desc = "Helm list" },
      { "<leader>kH", function() helm_cmd("history $(basename $PWD)", "helm history") end, desc = "Helm history" },
    },
  },
}