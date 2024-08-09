return {
    {
        "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
            },
        },
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "stylua", "shfmt", },
            registries = {
                -- "file:~/.config/nvim/mason-registry",
                "github:mason-org/mason-registry",
            },
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "williamboman/mason-lspconfig.nvim", config = function () end },
			"williamboman/mason.nvim",
		},
		opts = {
			servers = {
				llua_ls = {
					settings = { Lua = {
						-- codeLens = { enable = true },
						-- hint = { enable = true },
                        workspace = {
                            checkThirdParty = true,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
					}}
				},
				solidity = {
				},
			},
			diagnostics = {
				underline = true,
				virtual_text = {
					spacing = 4,
					source = "if_many",
				},
				severity_sort = true,
			},
			inlay_hints = {
				enabled = true,
			},
			document_highlight = {
				enabled = true,
			},
		},
		config = function (_, opts)
			local installed = require("mason-registry").get_installed_packages()
			local translate = require("mason-lspconfig.mappings.server").package_to_lspconfig
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for _, server in pairs(installed) do
				local translated = translate[server.name]
				local conf = opts.servers[translated]
                --local default_conf = require('lspconfig.server_configurations')[translated]

				if translated ~= nil then
					local setup = require("lspconfig")[translated]
					if setup ~= nil then
						if conf ~= nil then
							conf.capabilities = capabilities
							--setup.setup(default_conf)
							setup.setup({})
						else
							setup.setup({})
						end
					end
				end
			end
		end,
	},
    {
      "rmagatti/goto-preview",
      event = "BufEnter",
      config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
      opts = {
          default_mappings = true,
      },
    }
}
