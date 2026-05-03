return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      -- Disable default Tab mapping, we'll handle it in cmp config
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Prev Copilot suggestion" })
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot" })

      -- Filetypes to enable
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["markdown"] = true,
        ["yaml"] = true,
      }

      vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<CR>", { desc = "Copilot status" })
      vim.keymap.set("n", "<leader>cA", "<cmd>Copilot auth<CR>", { desc = "Copilot auth" })
    end,
  },

  -- Copilot chat (optional but nice)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatTests",
      "CopilotChatDocs",
      "CopilotChatReset",
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-4.1",
      tools = "copilot",
      trusted_tools = { "buffer", "file", "glob", "grep", "gitdiff" },
      resources = { "buffer:active" },
      sticky = { "@copilot", "#buffer:active" },
      show_help = true,
      auto_insert_mode = true,
      window = {
        layout = "float",
        width = 0.8,
        height = 0.8,
        border = "rounded",
        title = "  Copilot Chat ",
      },
      prompts = {
        Project = {
          prompt = "Inspect the current workspace and describe the project: purpose, languages, structure, tooling, and the main development workflows.",
          tools = "copilot",
          resources = { "buffer:active" },
          sticky = { "@copilot", "#buffer:active" },
        },
      },
      mappings = {
        close = { normal = "q", insert = "<C-c>" },
        reset = { normal = "<C-r>", insert = "<C-r>" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        accept_diff = { normal = "<C-y>", insert = "<C-y>" },
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Copilot Chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Explain code", mode = { "n", "v" } },
      { "<leader>cr", "<cmd>CopilotChatReview<CR>", desc = "Review code", mode = { "n", "v" } },
      { "<leader>cF", "<cmd>CopilotChatFix<CR>", desc = "Fix code", mode = { "n", "v" } },
      { "<leader>co", "<cmd>CopilotChatOptimize<CR>", desc = "Optimize code", mode = { "n", "v" } },
      { "<leader>cp", "<cmd>CopilotChatProject<CR>", desc = "Describe project" },
      { "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "Generate tests", mode = { "n", "v" } },
      { "<leader>cd", "<cmd>CopilotChatDocs<CR>", desc = "Generate docs", mode = { "n", "v" } },
    },
  },
}
