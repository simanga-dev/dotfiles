return {
  'microsoft/vscode-js-debug',
  event = 'VeryLazy',
  run = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
  dependencies = {
    'mxsdev/nvim-dap-vscode-js',
  },
}
