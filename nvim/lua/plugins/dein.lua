-- directory
local dein_dir = vim.fn.expand(vim.env.XDG_CACHE_HOME .. '/nvim/plugins')
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'

-- download dein.vim if it's not installed
if not string.find(vim.api.nvim_get_option('runtimepath'), '/dein.vim') then
    if not (vim.fn.isdirectory(dein_repo_dir) == 1) then
        os.execute('git clone https://github.com/Shougo/dein.vim ' .. dein_repo_dir)
    end
    vim.api.nvim_set_option('runtimepath', dein_repo_dir .. ',' .. vim.api.nvim_get_option('runtimepath'))
end

-- TOML File for plugin list
local toml         = vim.fn.expand('$XDG_CONFIG_HOME/nvim/dein/dein.toml')
local lazy_toml    = vim.fn.expand('$XDG_CONFIG_HOME/nvim/dein/dein_lazy.toml')
local ddc_toml     = vim.fn.expand('$XDG_CONFIG_HOME/nvim/dein/dein_ddc.toml')
local ddu_toml     = vim.fn.expand('$XDG_CONFIG_HOME/nvim/dein/dein_ddu.toml')

-- caching TOML
if vim.fn['dein#load_state'](dein_dir) == 1 then
    -- start configuration for dein.vim
    vim.fn['dein#begin'](dein_dir)
    vim.fn['dein#load_toml'](toml,      {lazy= 0})
    vim.fn['dein#load_toml'](lazy_toml, {lazy= 1})
    vim.fn['dein#load_toml'](ddc_toml,  {lazy= 1})
    vim.fn['dein#load_toml'](ddu_toml,  {lazy= 0})

    -- finish configuration for dein.vim
    vim.fn['dein#end']()

    vim.fn['dein#save_state']()
end

-- install plugins (if it have not installed that)
if vim.fn['dein#check_install']() ~= 0 then
    vim.fn['dein#install']()
end

local removed_plugins = vim.fn['dein#check_clean']()
if vim.fn.len(removed_plugins) > 0 then
  vim.fn.map(removed_plugins, "delete(v:val, 'rf')")
  vim.fn['dein#recache_runtimepath']()
end
