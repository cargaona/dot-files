-- Enable filetype-based plugins and indentation
vim.cmd('filetype plugin indent on')

-- Set tab behavior
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.tabstop = 2        -- Number of spaces per tab
vim.opt.shiftwidth = 2     -- Number of spaces per indentation level
vim.opt.softtabstop = 2    -- Number of spaces per tab while editing

-- Set undo directory
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Live substitution preview
vim.opt.inccommand = "nosplit"

-- Toggle paste mode with F9
vim.api.nvim_set_keymap('n', '<F9>', ':set paste!<CR>', { noremap = true, silent = true })

-- UI improvements
vim.opt.fillchars = { eob = ' ' }  -- Removes `~` from empty lines
vim.opt.background = "dark"        -- Dark mode
vim.opt.signcolumn = "yes"         -- Always show sign column
vim.opt.encoding = "utf-8"        -- Use UTF-8 encoding
vim.opt.laststatus = 3             -- Global statusline
vim.opt.number = true              -- Show line numbers
vim.opt.termguicolors = true       -- Enable 24-bit colors
vim.opt.mouse = "a"               -- Enable mouse support
vim.opt.wrap = false               -- Disable text wrapping
vim.opt.wildmenu = true            -- Enhanced command-line completion
vim.opt.showmatch = true           -- Highlight matching brackets
vim.opt.path:append("**")         -- Allow recursive file searching

-- Search behavior
vim.opt.ignorecase = true  -- Case insensitive search
vim.opt.incsearch = true   -- Incremental search
vim.opt.hlsearch = true    -- Highlight search results

-- Indentation and formatting
vim.opt.autoindent = true  -- Maintain indentation when starting a new line
vim.opt.smartindent = true -- Smarter indentation based on syntax
vim.opt.smarttab = true    -- Smart tab behavior based on context
vim.opt.splitright = true  -- Open vertical splits to the right
vim.opt.splitbelow = true  -- Open horizontal splits below

-- Disable swap file
vim.opt.swapfile = false

-- Treat end of lines like an IDE
vim.opt.virtualedit = "onemore" -- Allows cursor to move one char beyond the last character
vim.opt.selection = "exclusive"

-- Status line integration with Fugitive (Git plugin)
if vim.fn.exists("*fugitive#statusline") == 1 then
  vim.opt.statusline:append("%{fugitive#statusline()}")
end

