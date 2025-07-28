---@type snacks.Config
return {
  bigfile = {
    enabled = true,
    notify = true,
    ---@param ctx {buf: number, ft:string}
    setup = function(ctx)
      if vim.fn.exists(":NoMatchParen") ~= 0 then
        vim.cmd([[NoMatchParen]])
      end
      if vim.fn.exists(":DisableHLChunk") ~= 0 then
        vim.cmd([[DisableHLBlank]])
        vim.cmd([[DisableHLChunk]])
        vim.cmd([[DisableHLIndent]])
        vim.cmd([[DisableHLLineNum]])
      end
      vim.b.minianimate_disable = true
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(ctx.buf) then
          vim.bo[ctx.buf].syntax = ctx.ft
        end
      end)
      vim.g.bigfile_detected = true
    end,
  },
  image = { enabled = true },
  picker = { enabled = true },
}
