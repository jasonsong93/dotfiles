-- nvim/lua/plugins/lsp.lua
local lsp_keymaps = require('config.keymaps')

local function lsp_on_attach(client, bufnr)
    lsp_keymaps.setup_lsp_keymaps(bufnr, client)

    -- Format keymap (Leader + Shift + F)
    vim.keymap.set('n', '<leader>F', function()
        if client.name == 'roslyn_ls' and vim.fn.executable('dotnet') == 1 then
            -- Check if CSharpier is available by running `dotnet csharpier --version`
            local handle = io.popen('dotnet csharpier --version 2>&1')
            local result = handle:read("*a")
            handle:close()

            -- Lua pattern '%d+%.%d+%.%d+' matches a semantic version number like 1.2.3
            -- %d+  -> one or more digits
            -- %.   -> literal dot
            -- This ensures we only run CSharpier if it exists and returns a proper version
            if result:match('%d+%.%d+%.%d+') then
                local file = vim.fn.expand('%:p')
                vim.fn.system('dotnet csharpier format ' .. vim.fn.shellescape(file))
                vim.cmd('edit!')
            else
                -- Fallback to LSP formatting if CSharpier is not available
                vim.lsp.buf.format({ async = false })
            end
        else
            vim.lsp.buf.format({ async = false })
        end
    end, { buffer = bufnr, desc = 'Format buffer' })

    -- Format-on-Save
    if client.server_capabilities.documentFormattingProvider or client.name == 'roslyn_ls' then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                if client.name == 'roslyn_ls' and vim.fn.executable('dotnet') == 1 then
                    local handle = io.popen('dotnet csharpier --version 2>&1')
                    local result = handle:read("*a")
                    handle:close()

                    -- Same semantic version check as above
                    if result:match('%d+%.%d+%.%d+') then
                        local file = vim.fn.expand('%:p')
                        vim.fn.system('dotnet csharpier format ' .. vim.fn.shellescape(file))
                    else
                        vim.lsp.buf.format({ async = false })
                    end
                else
                    vim.lsp.buf.format({ async = false })
                end
            end,
        })
    end

    -- Roslyn-specific features
    if client.name == 'roslyn_ls' then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                buffer = bufnr,
                callback = function()
                    vim.lsp.codelens.refresh({ bufnr = bufnr })
                end,
            })
            vim.lsp.codelens.refresh({ bufnr = bufnr })
        end
    end
end

local lsp_servers = {
    roslyn_ls = {
        on_attach = lsp_on_attach,
        settings = {
            ['csharp|background_analysis'] = {
                dotnet_analyzer_diagnostics_scope = 'fullSolution',
                dotnet_compiler_diagnostics_scope = 'fullSolution',
            },
            ['csharp|code_lens'] = {
                dotnet_enable_references_code_lens = true,
                dotnet_enable_tests_code_lens = true,
            },
            ['csharp|completion'] = {
                dotnet_provide_regex_completions = true,
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
            },
            ['csharp|inlay_hints'] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
                csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                csharp_enable_inlay_hints_for_types = true,
                dotnet_enable_inlay_hints_for_indexer_parameters = true,
                dotnet_enable_inlay_hints_for_literal_parameters = true,
                dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                dotnet_enable_inlay_hints_for_other_parameters = true,
                dotnet_enable_inlay_hints_for_parameters = true,
                dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ['csharp|symbol_search'] = {
                dotnet_search_reference_assemblies = true,
            },
        },
    },
    lua_ls = {
        on_attach = lsp_on_attach,
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },
}

return {
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        opts = {
            ui = {
                border = 'rounded',
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
            ensure_installed = { 'lua_ls', 'roslyn_ls' },
            automatic_installation = true,
        },
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = 'rounded', source = 'always' },
            })

            local signs = { Error = '✘', Warn = '▲', Hint = '⚑', Info = 'ℹ' }
            for type, icon in pairs(signs) do
                vim.fn.sign_define('DiagnosticSign' .. type, { text = icon, texthl = 'DiagnosticSign' .. type })
            end

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
                { border = 'rounded' })

            vim.lsp.config('roslyn_ls', {
                cmd = {
                    'dotnet',
                    vim.fn.expand(
                        '~/.local/share/roslyn-ls/content/LanguageServer/neutral/Microsoft.CodeAnalysis.LanguageServer.dll'),
                    '--logLevel', 'Information',
                    '--extensionLogDirectory', vim.fn.stdpath('cache') .. '/roslyn_ls/logs',
                    '--stdio'
                },
                filetypes = { 'cs' },
                root_markers = { '*.sln', '*.csproj', '.git' },
                on_attach = lsp_servers.roslyn_ls.on_attach,
                settings = lsp_servers.roslyn_ls.settings,
            })

            for server_name, config in pairs(lsp_servers) do
                if server_name ~= 'roslyn_ls' then
                    vim.lsp.config(server_name, config)
                end
            end

            vim.lsp.enable(vim.tbl_keys(lsp_servers))
        end,
    },
}
