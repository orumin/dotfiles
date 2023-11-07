return function ()
  require("conform").setup({
    formatter_by_ft = {
      lua = { "stylua" },
    },
  })
end
