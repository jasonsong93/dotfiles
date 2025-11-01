
local M = {}

-- Setup LSP-specific keymaps when a language server attaches
function M.setup_lsp_keymaps(bufnr, client)
    local opts = { buffer = bufnr, silent = true }
    
    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, 
        vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, 
        vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, 
        vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, 
        vim.tbl_extend('force', opts, { desc = 'Show references' }))
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, 
        vim.tbl_extend('force', opts, { desc = 'Go to type definition' }))
    
    -- Documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, 
        vim.tbl_extend('force', opts, { desc = 'Show hover documentation' }))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, 
        vim.tbl_extend('force', opts, { desc = 'Show signature help' }))
    
    -- Code actions
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 
        vim.tbl_extend('force', opts, { desc = 'Code action' }))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, 
        vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
    
    -- Diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, 
        vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, 
        vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, 
        vim.tbl_extend('force', opts, { desc = 'Show diagnostic' }))
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, 
        vim.tbl_extend('force', opts, { desc = 'Diagnostic list' }))
    
    -- Workspace
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 
        vim.tbl_extend('force', opts, { desc = 'Add workspace folder' }))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 
        vim.tbl_extend('force', opts, { desc = 'Remove workspace folder' }))
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend('force', opts, { desc = 'List workspace folders' }))
    
    -- Inlay hints toggle (Neovim 0.10+)
    if vim.lsp.inlay_hint then
        vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, vim.tbl_extend('force', opts, { desc = 'Toggle inlay hints' }))
    end
    
    -- CodeLens (if supported)
    if client.server_capabilities.codeLensProvider then
        vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, 
            vim.tbl_extend('force', opts, { desc = 'Run CodeLens' }))
        vim.keymap.set('n', '<leader>cr', function()
            vim.lsp.codelens.refresh({ bufnr = bufnr })
        end, vim.tbl_extend('force', opts, { desc = 'Refresh CodeLens' }))
    end
end

return M
