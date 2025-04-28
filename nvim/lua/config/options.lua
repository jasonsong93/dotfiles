local opt = vim.opt

-- Line numbers
opt.number = true  -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers for better navigation

-- Indentation
opt.expandtab = true  -- Convert tabs to spaces
opt.shiftwidth = 4  -- Number of spaces to use for each indentation level
opt.tabstop = 4  -- Number of spaces a tab counts for
opt.autoindent = true  -- Automatically insert indentation in some cases

-- Searching
opt.ignorecase = true  -- Ignore case when searching
opt.smartcase = true  -- Override ignorecase if the search contains uppercase letters
opt.incsearch = true  -- Show search results as you type

-- Appearance
opt.termguicolors = true  -- Enable 24-bit RGB colors
opt.cursorline = true  -- Highlight the line the cursor is on

-- Scrolling
opt.scrolloff = 13 -- Keep lines visible above and below the cursor when scrolling
opt.sidescrolloff = 13 -- Keep columns visible to the left and right of the cursor

-- Splits
opt.splitbelow = true  -- Open horizontal splits below the current window
opt.splitright = true  -- Open vertical splits to the right of the current window

-- Miscellaneous
opt.wrap = false -- Don't wrap long lines
opt.signcolumn = "yes" -- Keep signcolumn on by default (errors etc from LSP)
opt.mouse = 'a'  -- Enable mouse support in all modes
opt.clipboard = 'unnamedplus'  -- Use system clipboard for copy/paste
opt.updatetime = 300  -- Faster completion and diagnostics updates
opt.signcolumn = 'yes'  -- Always show the sign column to prevent text shifting
opt.showmode = false -- Doesn't show the mode since it's already part of statusline
opt.list = true -- Show invisible characters
opt.listchars = {
    tab = "▸ ",       -- Display tabs as "▸ " (a visible arrow)
    trail = "·",      -- Display trailing spaces as "·" (a dot)
    extends = "›",    -- Display the character for lines that extend beyond the screen
    precedes = "‹",   -- Display the character for lines that wrap to the left
    nbsp = "␣"        -- Display non-breaking spaces as "␣" (a visible space)
}
opt.cmdheight = 0 -- Disable commandline (cleaner look, extra line)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true }), -- Create a unique group
    callback = function()
        -- Highlight the yanked text momentarily
        vim.highlight.on_yank({
            higroup = "IncSearch",  -- Highlight group (use any preferred group)
            timeout = 200,          -- Duration of the highlight in milliseconds
        })
    end,
})

-- File backups
opt.backup = false  -- Disable backup file creation
opt.swapfile = false  -- Disable swap file creation
opt.undofile = true -- Store undos between sessions
