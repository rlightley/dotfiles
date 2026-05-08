return {
  -- Mason
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "html", "cssls", "jsonls", "tailwindcss" },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    opts = {
      servers = {
        html = {},
        cssls = {},
        jsonls = {},
        tailwindcss = {},
      },
    },
    config = function(_, opts)
      local caps = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = function(k, f, d) vim.keymap.set("n", k, f, { buffer = ev.buf, desc = d }) end
          map("gd", vim.lsp.buf.definition, "Definition")
          map("gr", vim.lsp.buf.references, "References")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })

      for server, server_opts in pairs(opts.servers or {}) do
        vim.lsp.config[server] = vim.tbl_deep_extend("force", { capabilities = caps }, server_opts or {})
      end

      vim.lsp.enable(vim.tbl_keys(opts.servers or {}))
    end,
  },

  -- Treesitter - use built-in for 0.12+
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {},
      highlight_filetypes = {},
    },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed or {})

      if #opts.highlight_filetypes > 0 then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.highlight_filetypes,
          callback = function(args)
            pcall(vim.treesitter.start, args.buf)
          end,
        })
      end
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      { "zbirenbaum/copilot-cmp", dependencies = { "zbirenbaum/copilot.lua" } },
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("copilot_cmp").setup()
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          }),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = {
              Copilot = "",
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fb)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fb() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fb)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fb() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "copilot", priority = 1100 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
      })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format" },
    },
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
      format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
    },
  },
}
