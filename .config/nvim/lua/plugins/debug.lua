local arrows = require('icons').arrows

local icons = {
  Stopped = { '', 'DiagnosticWarn', 'DapStoppedLine' },
  Breakpoint = '●',
  BreakpointCondition = '',
  BreakpointRejected = { '', 'DiagnosticError' },
  LogPoint = arrows.right,
}

for name, sign in pairs(icons) do
  sign = type(sign) == 'table' and sign or { sign }
  vim.fn.sign_define('Dap' .. name, {
    -- stylua: ignore
    text = sign[1] --[[@as string]] .. ' ',
    texthl = sign[2] or 'DiagnosticInfo',
    linehl = sign[3],
    numhl = sign[3],
  })
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap-python',
    'theHamsta/nvim-dap-virtual-text',
    {
      'jbyuki/one-small-step-for-vimkind',
      keys = {
        {
          '<leader>osv',
          function()
            require('osv').launch { port = 8086 }
          end,
          desc = 'start lua sever debug',
        },
      },
    },
    'theHamsta/nvim-dap-virtual-text',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    {
      'rcarriga/nvim-dap-ui',
      keys = {
        {
          '<leader>de',
          function()
            -- Calling this twice to open and jump into the window.
            require('dapui').eval()
            require('dapui').eval()
          end,
          desc = 'Evaluate expression',
        },
      },
      opts = {
        icons = {
          collapsed = arrows.right,
          current_frame = arrows.right,
          expanded = arrows.down,
        },
        floating = { border = 'rounded' },
        layouts = {
          {
            elements = {
              { id = 'stacks', size = 0.30 },
              { id = 'breakpoints', size = 0.20 },
              { id = 'scopes', size = 0.50 },
            },
            position = 'left',
            size = 40,
          },
          {
            elements = {
              { id = 'repl', size = 1 },
            },
            position = 'bottom',
            size = 10,
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader>dui',
      function()
        require('dapui').toggle()
      end,
      desc = 'Toggle debuger UI',
    },
    {
      '<leader>dd',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle breakpoints',
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Toggle breakpoints',
    },
    {
      '<leader>dC',
      function()
        require('dap').close()
      end,
      desc = 'Stop Debugging',
    },
    {
      '<leader>dk',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = 'Show context',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'Show context',
    },
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Continue',
    },
    {
      '<F10>',
      function()
        require('dap').step_over()
      end,
      desc = 'Step over',
    },
    {
      '<F11>',
      function()
        require('dap').step_into()
      end,
      desc = 'Step into',
    },
    {
      '<F12>',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
  },
  config = function()
    require('nvim-dap-virtual-text').setup {}
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      automatic_installation = true,
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          config.adapters = {
            type = 'executable',
            command = '/usr/bin/python3',
            args = {
              '-m',
              'debugpy.adapter',
            },
          }
          require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
      },
      ensure_installed = {
        'delve',
      },
    }
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()

    require('dap-python').setup '/home/simanga/.virtualenvs/debugpy/bin/python'
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = 'Attach to running Neovim instance',
      },
    }

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/linux-x64/', 'file')
        end,
      },
    }

    dap.adapters.coreclr = {
      type = 'executable',
      command = '/home/simanga/.local/share/nvim/mason/bin/netcoredbg',
      args = { '--interpreter=vscode' },
    }

    dap.adapters.nlua = function(callback, config)
      callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
    end
  end,
}
