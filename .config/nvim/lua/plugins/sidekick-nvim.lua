return {
  'folke/sidekick.nvim',
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = 'zellij',
        enabled = true,
      },
      tools = {
        amp = {
          cmd = { 'amp', '--ide' },
        },
      },
      prompts = {
        pr = 'create pr to Q4Dev using the template',
        resume_update = 'Update the resume in the @main.tex file to align perfectly with the job description provided in @job-description.md . Make sure to highlight relevant skills, experiences, and qualifications that directly match the requirements of the job. Tailor the resume to showcase how your background and expertise make you an ideal candidate for the position. Be sure to emphasize any specific achievements or accomplishments demonstrate your ability to excel in this role, run `make` to make sure that the cv build fine',
      },
    },
  },
  keys = {
    {
      '<tab>',
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require('sidekick').nes_jump_or_apply() then
          return '<Tab>' -- fallback to normal tab
        end
      end,
      expr = true,
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<c-.>',
      function()
        require('sidekick.cli').focus()
      end,
      mode = { 'n', 'x', 'i', 't' },
      desc = 'Sidekick Switch Focus',
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle { focus = true }
      end,
      desc = 'Sidekick Toggle CLI',
      mode = { 'n', 't' },
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').send { msg = '{selection}' }
      end,
      desc = 'Sidekick Toggle CLI',
      mode = { 'v' },
    },

    {
      '<leader>ac',
      function()
        require('sidekick.cli').send { msg = '{file}' }
      end,
      desc = 'Sidekick Claude Toggle',
      mode = { 'n', 'v' },
    },
    {
      '<leader>af',
      function()
        require('sidekick.cli').focus()
      end,
      desc = 'Sidekick Claude Toggle',
      mode = { 'n', 'v', 't' },
    },
    {
      '<leader>av',
      function()
        require('sidekick.cli').send { msg = '{selection}' }
      end,
      mode = { 'x' },
      desc = 'Send Visual Selection',
    },
    {
      '<leader>as',
      function()
        require('sidekick.cli').select()
      end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = 'Select CLI',
    },
    {
      '<leader>ad',
      function()
        require('sidekick.cli').close()
      end,
      desc = 'Detach a CLI Session',
    },
    {
      '<leader>at',
      function()
        require('sidekick.cli').send { msg = '{this}' }
      end,
      mode = { 'x', 'n' },
      desc = 'Send This',
    },

    {
      '<leader>ag',
      function()
        require('sidekick.cli').toggle { name = 'grok', focus = true }
      end,
      desc = 'Sidekick Grok Toggle',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ap',
      function()
        require('sidekick.cli').prompt()
      end,
      desc = 'Sidekick Ask Prompt',
      mode = { 'n', 'v' },
    },
  },
}
