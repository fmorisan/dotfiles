-- auto completion
return {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local types = require("cmp.types")
      local auto_select = true
      return {
        auto_brackets = { "lua", }, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
          keyword_length = 1,
        },
        preselect = (not auto_select) and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "lazydev", group_index = 0 }
        }, {
          { name = "buffer" },
        }),
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), {'i', 'c'}),
            ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), {'i', 'c'}),
            ["<Tab>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), {'i', 'c'}),
            ["<Leader>d"] = cmp.mapping(cmp.mapping.scroll_docs(3), {'i', 'c'}),
        }),
        sorting = defaults.sorting,
        docs = {
            auto_open = true,
        },
      }
    end,
  }
