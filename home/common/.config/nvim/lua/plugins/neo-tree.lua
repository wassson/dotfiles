return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "float",
      width = 80,
      height = 25,
    },
    popup_border_style = "rounded",
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "float" })
      end,
      desc = "Explorer NeoTree (Float)",
    },
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), position = "float" })
      end,
      desc = "Explorer NeoTree (cwd, Float)",
    },
  },
}