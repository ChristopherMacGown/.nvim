--
--
--
--
--

local map = vim.keymap.set
local opt = vim.opt
local global = vim.g

global.mapleader = ' '
global.python3_host_prog = "/Users/chris/.pyenv/shims/python"

opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect", "popup" }
opt.errorbells = false
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.ts = 4
opt.sw = 4
opt.swapfile = false
opt.signcolumn = "yes"
opt.winborder = "rounded"
opt.background = "light"
opt.termguicolors = true
opt.smartindent = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		vim.opt_local.expandtab = true
	end,
})


if global.neovide then
	global.neovide_cursor_animation_length = 0.125
	global.neovide_cursor_short_animation_length = 0.125
	global.neovide_cursor_trail_size = 0
end


vim.pack.add({
	{ src = "https://github.com/felipefdl/warm-burnout" },
	{ src = "https://github.com/nkxxll/ghostty-default-style-dark.nvim" },
	-- { src = "https://github.com/sainnhe/everforest" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/direnv/direnv.vim" },
	{ src = "https://github.com/leafOfTree/vim-svelte-plugin" },

	{ src = "https://github.com/jghauser/mkdir.nvim" },

	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	-- neo-tree dependencies
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/saghen/blink.cmp",                         version = vim.version.range("^1") },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim" },
	{ src = "/Users/Chris/Projects/jj.nvim" },

	--  Go nvim-dap
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" }, -- dap-ui dep
})
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site/pack/core/opt/warm-burnout/nvim")

require "lsp"
require "mini.pick".setup({
	window = {
		config = function()
			local width = math.floor(vim.o.columns * 0.4)
			return {
				anchor = "NW",
				row = 0,
				col = math.floor((vim.o.columns - width) / 2),
				width = width,
				height = math.floor(vim.o.lines * 0.4),
			}
		end,
	},
})
require "bufferline".setup({
	options = {
		mode = "buffers",
		show_buffer_close_icons = true,
		separator_style = "slant",
		offsets = {
			{ filetype = "neo-tree", text = "Files", highlight = "Directory" }
		},
	}
})
require "blink.cmp".setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
	keymap = {
		preset        = "super-tab",
		['<C-space>'] = {},
		['<CR>']      = { "accept", "fallback" },
		['<C-/>']     = { 'show', 'show_documentation', 'hide_documentation' },
	},
	completion = {
		ghost_text = { enabled = true },
		menu = {
			auto_show = true
		},
		list = {
			selection = {
				preselect = true,
				auto_insert = true,
			}
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		}
	},
})

require "nvim-autopairs".setup()
require "neo-tree".setup({
	filesystem = {
		follow_current_file = {
			enabled = true
		}
	}
})
require("render-markdown").setup({})
require("jj").setup({})
require("toggleterm").setup({
	direction = "horizontal",
	size = 15,
	shading_ratio = 0.2,
	winbar = { enabled = true }
})
require("warm-burnout").setup({ variant = 'dark' })
require("dap-go").setup()
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dn", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test)
vim.keymap.set("n", "<leader>dr", dap.repl.toggle)

map("n", "<leader>o", ":update<CR> :source ~/.config/nvim/init.lua<CR>", { silent = true })
map("n", "<leader>w", ":write<CR>")
map("n", "<leader>q", ":quit<CR>")
map("n", "<leader>h", ":Pick help<CR>")
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })
for i = 1, 5 do
	map({ "n", "t" }, "<leader>t" .. i, "<cmd>" .. i .. "ToggleTerm<CR>", { silent = true })
end
map({ "n", "t" }, "<leader>t", "<cmd>1ToggleTerm<CR>", { silent = true })
map("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		map("n", "<Tab>", "<cmd>startinsert<CR>", { buffer = true, silent = true })
		map("n", "<S-Tab>", "<cmd>startinsert<CR>", { buffer = true, silent = true })
	end
})
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })
map("n", "<D-/>", "gcc", { remap = true })
map("x", "<D-/>", "gc", { remap = true })
map("c", "<D-v>", "<MiddleMouse>")

-- Tab switching
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })

map({ "n", "x" }, "<leader>y", '"+yy<CR>')
map({ "n", "x" }, "<leader>d", '"+dd<CR>')
map({ "n", "x" }, "<leader>p", '"+p<CR>')
map({ "n", "x" }, "<C-TAB>", ":tabprevious<CR>", { silent = true })
map({ "n", "x" }, "<C-S-TAB>", ":tabnext<CR>", { silent = true })
map({ "n", "i", "x", "v" }, "<D-t>", "<cmd>vsplit<CR>")
map({ "n", "i", "x", "v" }, "<D-t>s", "<cmd>split<CR>")
map("n", "<leader><leader>", "<cmd>Pick files<CR>")
map({ "n", "i", "x", "v", "x" }, "<D-p>", "<cmd>Pick files<CR>")
map({ "n", "i", "x", "v", "x" }, "<D-b>", "<cmd>Neotree toggle<CR>")
map({ "n", "i", "x", "v", "x" }, "<D-B>", "<cmd>Neotree toggle buffers<CR>")


vim.cmd.colorscheme("ghostty-default-style-dark")
vim.cmd.colorscheme("warm-burnout-light")
-- vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#888888" })
