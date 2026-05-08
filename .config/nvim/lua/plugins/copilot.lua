return {
  -- GitHub Copilot (Lua rewrite — required for copilot-cmp)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ["*"] = true,
        markdown = true,
        yaml = true,
      },
    },
    keys = {
      { "<leader>cs", "<cmd>Copilot status<CR>", desc = "Copilot status" },
      { "<leader>cA", "<cmd>Copilot auth<CR>", desc = "Copilot auth" },
    },
  },

  -- Copilot chat (optional but nice)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
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
