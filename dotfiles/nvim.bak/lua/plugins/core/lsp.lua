return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Provavelmente irei mover o lazydev.nvim para um arquivo próprio
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},

			{ "williamboman/mason.nvim", opts = {} },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "saghen/blink.cmp" },
		},
		-- Using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {},
				nil_ls = {},
				ts_ls = {},
			},
		},
		config = function(_, opts)
			-- Mason-lspconfig ensures to install...
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = { "lua_ls", "ts_ls" },
				automatic_installation = false,
			})

			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- if client:supports_method('textDocument/implementation') then
					--   -- Create a keymap for vim.lsp.buf.implementation
					-- end

					-- if client:supports_method('textDocument/completion') then
					--   Enable auto-completion
					--   vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
					-- end

					-- Format the current buffer on save
					---@diagnostic disable-next-line: param-type-mismatch
					if client:supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end,
						})
					end
				end,
			})
		end,
	},
}
