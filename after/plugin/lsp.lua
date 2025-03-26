-- Require lsp-zero and set up the preset
local lsp = require("lsp-zero")
lsp.preset("recommended")

-- Ensure LSP servers are installed
lsp.ensure_installed({
  'tsserver',
  'pyright',
  -- Add other servers if needed
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

-- Require nvim-cmp
local cmp = require('cmp')

-- Configure cmp selection behavior
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- Define cmp mappings
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- Remove Tab and Shift-Tab mappings if not needed
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

-- Set up nvim-cmp with the defined mappings and sources
lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    -- Add other global sources if needed
  })
})

-- Set preferences for lsp-zero
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

-- Define on_attach function for keybindings
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Finalize lsp setup
lsp.setup()

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = true
})

-- ----------------------------
-- Add cmp-omni Configuration
-- ----------------------------

-- Global nvim-cmp setup
cmp.setup({
  -- Global completion settings
  snippet = {
    expand = function(args)
      -- You can configure snippet expansion here if you're using a snippet engine
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp_mappings, -- Reuse the existing mappings
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'omni' }, -- Add omni as a global source if desired
    -- Add other global sources here
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        omni = "[Omni]",
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        -- Add other sources here
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- Filetype-specific configuration for TeX files
cmp.setup.filetype("tex", {
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
        buffer = "[Buffer]",
        -- Add formatting for other sources if needed
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = "omni", option = { type = "tex" }, trigger_characters = { "{", "\\" } },
    { name = 'buffer' },
    -- Add other sources specific to tex if needed
  }),
})

