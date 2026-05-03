return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      local function apply_code_highlights(colors)
        local set_hl = vim.api.nvim_set_hl

        local highlights = {
          Function = { fg = colors.blue, bold = true },
          Identifier = { fg = colors.text },
          Type = { fg = colors.yellow, bold = true, italic = true },
          Structure = { fg = colors.yellow, bold = true, italic = true },
          ["@module"] = { fg = colors.lavender, bold = true },
          ["@namespace"] = { fg = colors.lavender, bold = true },
          ["@function"] = { fg = colors.blue, bold = true },
          ["@function.call"] = { fg = colors.blue, bold = true },
          ["@function.method"] = { fg = colors.sapphire, bold = true },
          ["@function.method.call"] = { fg = colors.sapphire, bold = true },
          ["@function.builtin"] = { fg = colors.red, bold = true },
          ["@variable"] = { fg = colors.text },
          ["@variable.member"] = { fg = colors.lavender },
          ["@parameter"] = { fg = colors.maroon, italic = true },
          ["@variable.parameter"] = { fg = colors.maroon, italic = true },
          ["@type"] = { fg = colors.yellow, bold = true, italic = true },
          ["@type.builtin"] = { fg = colors.peach, bold = true, italic = true },
          ["@type.definition"] = { fg = colors.yellow, bold = true, italic = true },
          ["@property"] = { fg = colors.teal },
          ["@field"] = { fg = colors.teal },
          ["@lsp.type.function"] = { fg = colors.blue, bold = true },
          ["@lsp.type.method"] = { fg = colors.sapphire, bold = true },
          ["@lsp.type.variable"] = { fg = colors.text },
          ["@lsp.type.parameter"] = { fg = colors.maroon, italic = true },
          ["@lsp.type.property"] = { fg = colors.teal },
          ["@lsp.type.type"] = { fg = colors.yellow, bold = true, italic = true },
          ["@lsp.type.struct"] = { fg = colors.yellow, bold = true, italic = true },
          ["@lsp.type.interface"] = { fg = colors.yellow, bold = true, italic = true },
          ["@lsp.type.typeParameter"] = { fg = colors.peach, bold = true, italic = true },
          ["@function.go"] = { fg = colors.blue, bold = true },
          ["@function.call.go"] = { fg = colors.blue, bold = true },
          ["@function.method.go"] = { fg = colors.sapphire, bold = true },
          ["@function.method.call.go"] = { fg = colors.sapphire, bold = true },
          ["@function.builtin.go"] = { fg = colors.red, bold = true },
          ["@module.go"] = { fg = colors.lavender, bold = true },
          ["@namespace.go"] = { fg = colors.lavender, bold = true },
          ["@variable.go"] = { fg = colors.text },
          ["@variable.member.go"] = { fg = colors.lavender },
          ["@parameter.go"] = { fg = colors.maroon, italic = true },
          ["@variable.parameter.go"] = { fg = colors.maroon, italic = true },
          ["@type.go"] = { fg = colors.yellow, bold = true, italic = true },
          ["@type.definition.go"] = { fg = colors.yellow, bold = true, italic = true },
          ["@property.go"] = { fg = colors.teal },
          ["@field.go"] = { fg = colors.teal },
          ["@lsp.type.function.go"] = { fg = colors.blue, bold = true },
          ["@lsp.type.method.go"] = { fg = colors.sapphire, bold = true },
          ["@lsp.type.variable.go"] = { fg = colors.text },
          ["@lsp.type.parameter.go"] = { fg = colors.maroon, italic = true },
          ["@lsp.type.property.go"] = { fg = colors.teal },
          ["@lsp.type.struct.go"] = { fg = colors.yellow, bold = true, italic = true },
          ["@lsp.type.interface.go"] = { fg = colors.yellow, bold = true, italic = true },
          ["@lsp.type.type.go"] = { fg = colors.yellow, bold = true, italic = true },
        }

        for group, spec in pairs(highlights) do
          set_hl(0, group, spec)
        end
      end

      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          functions = { "bold" },
          keywords = { "italic" },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          neotree = true,
          telescope = { enabled = true, style = "nvchad" },
          which_key = true,
          dap = true,
          dap_ui = true,
          harpoon = true,
          indent_blankline = { enabled = true, colored_indent_levels = false },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          notify = true,
          mason = true,
          noice = true,
        },
        custom_highlights = function(colors)
          return {
            -- Floating windows
            NormalFloat = { bg = colors.mantle },
            FloatBorder = { fg = colors.blue, bg = colors.mantle },
            -- Telescope
            TelescopeBorder = { fg = colors.blue, bg = colors.mantle },
            TelescopeNormal = { bg = colors.mantle },
            TelescopePromptBorder = { fg = colors.mauve, bg = colors.mantle },
            TelescopePromptTitle = { fg = colors.base, bg = colors.mauve },
            TelescopePreviewTitle = { fg = colors.base, bg = colors.green },
            TelescopeResultsTitle = { fg = colors.base, bg = colors.blue },
            -- Pmenu (completion)
            Pmenu = { bg = colors.mantle },
            PmenuSel = { bg = colors.surface1, fg = colors.text },
            -- Cursor line
            CursorLine = { bg = colors.surface0 },
            -- Which-key
            WhichKeyFloat = { bg = colors.mantle },
            -- Stronger syntax contrast
            Comment = { fg = colors.overlay1, style = { "italic" } },
            Keyword = { fg = colors.mauve, style = { "italic", "bold" } },
            Conditional = { fg = colors.mauve, style = { "italic", "bold" } },
            Repeat = { fg = colors.mauve, style = { "italic", "bold" } },
            Statement = { fg = colors.mauve, style = { "bold" } },
            Function = { fg = colors.blue, style = { "bold" } },
            Identifier = { fg = colors.lavender },
            Type = { fg = colors.yellow, style = { "bold" } },
            StorageClass = { fg = colors.peach, style = { "bold" } },
            Structure = { fg = colors.yellow, style = { "bold" } },
            Constant = { fg = colors.peach },
            String = { fg = colors.green },
            Number = { fg = colors.peach },
            Boolean = { fg = colors.peach, style = { "bold" } },
            Operator = { fg = colors.sky },
            PreProc = { fg = colors.red },
            Special = { fg = colors.flamingo },
            -- Treesitter and semantic tokens
            ["@keyword"] = { fg = colors.mauve, style = { "italic", "bold" } },
            ["@keyword.function"] = { fg = colors.red, style = { "bold" } },
            ["@keyword.import"] = { fg = colors.red, style = { "bold" } },
            ["@keyword.return"] = { fg = colors.red, style = { "bold" } },
            ["@conditional"] = { fg = colors.mauve, style = { "italic", "bold" } },
            ["@repeat"] = { fg = colors.mauve, style = { "italic", "bold" } },
            ["@function"] = { fg = colors.blue, style = { "bold" } },
            ["@function.call"] = { fg = colors.blue, style = { "bold" } },
            ["@function.method"] = { fg = colors.sapphire, style = { "bold" } },
            ["@function.method.call"] = { fg = colors.sapphire, style = { "bold" } },
            ["@constructor"] = { fg = colors.yellow, style = { "bold" } },
            ["@variable"] = { fg = colors.text },
            ["@variable.member"] = { fg = colors.lavender },
            ["@parameter"] = { fg = colors.maroon, style = { "italic" } },
            ["@type"] = { fg = colors.yellow, style = { "bold", "italic" } },
            ["@type.builtin"] = { fg = colors.peach, style = { "bold", "italic" } },
            ["@type.definition"] = { fg = colors.yellow, style = { "bold", "italic" } },
            ["@property"] = { fg = colors.teal },
            ["@field"] = { fg = colors.teal },
            ["@string"] = { fg = colors.green },
            ["@string.escape"] = { fg = colors.peach, style = { "bold" } },
            ["@number"] = { fg = colors.peach },
            ["@boolean"] = { fg = colors.peach, style = { "bold" } },
            ["@operator"] = { fg = colors.sky },
            ["@punctuation.bracket"] = { fg = colors.overlay2 },
            ["@punctuation.delimiter"] = { fg = colors.overlay2 },
            ["@module"] = { fg = colors.blue },
            ["@namespace"] = { fg = colors.blue },
            ["@tag"] = { fg = colors.mauve },
            ["@tag.attribute"] = { fg = colors.teal },
            ["@lsp.type.function"] = { link = "@function" },
            ["@lsp.type.method"] = { link = "@function.method" },
            ["@lsp.type.parameter"] = { link = "@parameter" },
            ["@lsp.type.property"] = { link = "@property" },
            ["@lsp.type.variable"] = { fg = colors.text },
            ["@lsp.type.type"] = { link = "@type" },
            ["@lsp.type.class"] = { link = "@type" },
            ["@lsp.type.struct"] = { link = "@type" },
            ["@lsp.type.interface"] = { link = "@type" },
            ["@lsp.type.typeParameter"] = { fg = colors.gold or colors.yellow, style = { "bold", "italic" } },
            ["@lsp.type.namespace"] = { link = "@namespace" },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")

      local colors = require("catppuccin.palettes").get_palette("mocha")
      apply_code_highlights(colors)

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "catppuccin",
        callback = function()
          apply_code_highlights(require("catppuccin.palettes").get_palette("mocha"))
        end,
      })
    end,
  },

  -- Noice for better UI (cmdline, messages, popupmenu)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = true },
        hover = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          border = { style = "rounded", padding = { 0, 1 } },
          position = { row = "40%", col = "50%" },
          size = { width = 60, height = "auto" },
        },
        popupmenu = {
          border = { style = "rounded", padding = { 0, 1 } },
        },
      },
    },
    keys = {
      { "<leader>nl", "<cmd>Noice last<CR>", desc = "Last message" },
      { "<leader>nh", "<cmd>Noice history<CR>", desc = "Message history" },
      { "<leader>nd", "<cmd>Noice dismiss<CR>", desc = "Dismiss messages" },
    },
  },

  -- Keymap discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 200,
      preset = "helix",
      icons = {
        group = "▸ ",
      },
      spec = {
        { "<leader>b", group = "Buffers", icon = "󰓩" },
        { "<leader>c", group = "Copilot/Code", icon = "󰚩" },
        { "<leader>d", group = "Debug", icon = "󰃤" },
        { "<leader>e", group = "Explorer", icon = "󰙅" },
        { "<leader>f", group = "Find", icon = "󰍉" },
        { "<leader>g", group = "Git", icon = "󰊢" },
        { "<leader>h", group = "Harpoon", icon = "󰛢" },
        { "<leader>k", group = "Kubernetes", icon = "󱃾" },
        { "<leader>n", group = "Notifications", icon = "󰍡" },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
    },
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1e1e2e",
      fps = 60,
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
      timeout = 3000,
      top_down = true,
      max_width = 50,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
    },
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          offsets = {{ filetype = "neo-tree", text = "Explorer", separator = true }},
          separator_style = "thin",
          always_show_bufferline = true,
        },
      })
    end,
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
      { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
      { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
      { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
      { "<leader>b4", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
    },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")

      return {
        options = {
          theme = {
            normal = {
              a = { bg = colors.blue, fg = colors.base, gui = "bold" },
              b = { bg = colors.surface0, fg = colors.blue },
              c = { bg = colors.mantle, fg = colors.text },
            },
            insert = {
              a = { bg = colors.green, fg = colors.base, gui = "bold" },
              b = { bg = colors.surface0, fg = colors.green },
              c = { bg = colors.mantle, fg = colors.text },
            },
            visual = {
              a = { bg = colors.mauve, fg = colors.base, gui = "bold" },
              b = { bg = colors.surface0, fg = colors.mauve },
              c = { bg = colors.mantle, fg = colors.text },
            },
            replace = {
              a = { bg = colors.red, fg = colors.base, gui = "bold" },
              b = { bg = colors.surface0, fg = colors.red },
              c = { bg = colors.mantle, fg = colors.text },
            },
            command = {
              a = { bg = colors.yellow, fg = colors.base, gui = "bold" },
              b = { bg = colors.surface0, fg = colors.yellow },
              c = { bg = colors.mantle, fg = colors.text },
            },
            inactive = {
              a = { bg = colors.surface0, fg = colors.overlay1 },
              b = { bg = colors.surface0, fg = colors.overlay1 },
              c = { bg = colors.mantle, fg = colors.overlay1 },
            },
          },
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "diagnostics", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "File explorer" },
      { "<leader>E", "<cmd>Neotree reveal<CR>", desc = "Reveal file in explorer" },
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = "filesystem", display_name = "  Files " },
          { source = "buffers", display_name = "  Buffers " },
          { source = "git_status", display_name = "  Git " },
        },
      },
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
          highlight = "NeoTreeFileIcon",
        },
        modified = { symbol = "●", highlight = "NeoTreeModified" },
        name = { trailing_slash = false, use_git_status_colors = true },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        position = "left",
        width = 35,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ["<space>"] = "none",
          ["<cr>"] = "open",
          ["o"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["a"] = { "add", config = { show_path = "relative" } },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          -- Resize with H and L
          ["H"] = function(state)
            local w = vim.api.nvim_win_get_width(state.winid)
            vim.api.nvim_win_set_width(state.winid, math.max(w - 5, 20))
          end,
          ["L"] = function(state)
            local w = vim.api.nvim_win_get_width(state.winid)
            vim.api.nvim_win_set_width(state.winid, w + 5)
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { "node_modules", ".git" },
          never_show = { ".DS_Store", "thumbs.db" },
        },
        follow_current_file = { enabled = true, leave_dirs_open = true },
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
      },
      buffers = {
        follow_current_file = { enabled = true, leave_dirs_open = true },
        group_empty_dirs = true,
        show_unloaded = true,
      },
      git_status = {
        window = { position = "float" },
      },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local themes = require("telescope.themes")

      telescope.setup({
        defaults = {
          prompt_prefix = "    ",
          selection_caret = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          file_ignore_patterns = { "%.git/", "node_modules/", "%.terraform/", "dist/", "build/" },
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.90,
            height = 0.85,
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
          buffers = {
            sort_mru = true,
            ignore_current_buffer = true,
          },
        },
        extensions = {
          ["ui-select"] = themes.get_dropdown({
            previewer = false,
            initial_mode = "normal",
          }),
        },
      })
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
    },
    keys = {
      { "]h", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
      { "[h", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "Blame line" },
    },
  },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
      vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
    end,
  },

  -- Which-key
  -- Autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Comments
  { "numToStr/Comment.nvim", opts = {} },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = { indent = { char = "│" }, scope = { enabled = true } },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    opts = { open_mapping = [[<C-\>]], direction = "float" },
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" } },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "  Recent", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "  Grep", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("e", "  Explorer", "<cmd>Neotree<CR>"),
        dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
      }
      require("alpha").setup(dashboard.config)
    end,
  },

  -- Smooth scroll
  { "karb94/neoscroll.nvim", opts = {} },

  -- Better UI
  { "stevearc/dressing.nvim", opts = {} },
}
