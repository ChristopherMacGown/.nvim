local lsp = vim.lsp
local config = lsp.config
local map = vim.keymap.set

config("gopls", {})
config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})
config("ruff", {
	init_options = {
		settings = {
			fixAll = true,
			organizeImports = true,
			lint = {
				select = { "E", "F", "I", "UP", "B", "SIM" },
			},
			-- lineLength = 100,
		},
	},
})
config("hls", {
	settings = {
		haskell = {
			formattingProvider = "fourmolu",
			checkProject = true,
			plugin = {
				["fourmolu"] = {
					config = {
						external = true,
					},
				},
			},
		}
	}
})
config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			rustfmt = {
				extraArgs = {},
			},
		}
	}
})
config("jsonls", {
	init_options = {
		provideFormatter = true,
	},
})
config("ts_ls", {})
config("svelte", {})
local function has_pep723_header(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
	for _, line in ipairs(lines) do
		if line:match("^#%s*///%s*script%s*$") then return true end
	end
	return false
end

config("basedpyright", {
	root_dir = function(bufnr, on_dir)
		-- PEP 723 scripts are handled by the autocmd below, which starts a
		-- per-script client with the uv-managed interpreter. Decline to
		-- auto-attach the project-wide client here so we don't inherit the
		-- surrounding direnv VIRTUAL_ENV.
		if has_pep723_header(bufnr) then return end
		local root = vim.fs.root(bufnr, {
			"pyproject.toml", "setup.py", "setup.cfg",
			"requirements.txt", "Pipfile", "pyrightconfig.json",
		})
		on_dir(root or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function(args)
		local bufnr = args.buf
		if not has_pep723_header(bufnr) then return end

		local fname = vim.api.nvim_buf_get_name(bufnr)
		if fname == "" then return end

		local out = vim.fn.systemlist({ "uv", "python", "find", "--script", fname })
		if vim.v.shell_error ~= 0 or not out[1] then
			vim.notify("uv python find --script failed for " .. fname, vim.log.levels.WARN)
			return
		end
		local py = out[1]

		vim.lsp.start({
			name = "basedpyright-pep723",
			cmd = { "basedpyright-langserver", "--stdio" },
			root_dir = vim.fs.dirname(fname),
			workspace_folders = nil,
			settings = {
				python = { pythonPath = py },
				basedpyright = {
					analysis = {
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
						autoSearchPaths = false,
						extraPaths = {},
					},
				},
			},
		})
	end,
})
config("ty", {
	settings = {
		ty = {
			experimental = {
				autoImport = true,
				rename = true,
			}
		}
	}
})


lsp.enable({ "basedpyright", "gopls", "hls", "jsonls", "lua_ls", "ruff", "rust_analyzer", "svelte", "ts_ls", "ty" })
map("n", "<leader>lf", lsp.buf.format)
map("n", "<leader>la", lsp.buf.code_action)
map("n", "<leader>lh", lsp.buf.hover)
map("n", "<leader>lg", lsp.buf.definition)
map("n", "<leader>li", lsp.buf.implementation)
map("n", "<leader>lt", lsp.buf.type_definition)
map("n", "<leader>lr", lsp.buf.references)
map("n", "<leader>lR", lsp.buf.rename)
map("n", "<leader>ls", vim.lsp.buf.signature_help)
