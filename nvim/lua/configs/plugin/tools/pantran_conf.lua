return function ()
  local pantran = require("pantran")
  --local actions = require("pantran.ui.actions")
  --local engines = require("pantran.engines")
  --local async = require("pantran.async")

  local default_engine = vim.env.DEEPL_AUTH_KEY and "deepl" or "google"
  pantran.setup({
    default_engine = default_engine,
    engines = {
      deepl = {
        free_api = false,
        default_source = vim.NIL,
        default_target = "EN-US",
        auth_key = vim.env.DEEPL_AUTH_KEY,
        split_sentences = 0,
        preserve_formatting = 0,
        --formality = "more"
        formality = "default" -- NOTE: formality: 'more' is not given for target_language 'EN-US'
      },
      google = {
        default_source = vim.NIL,
        default_target = "en",
        bearer_token = vim.env.GOOGLE_BEARER_TOKEN,
        api_key = vim.env.GOOGLE_API_KEY,
        format = "text",
        fallback = {
          default_source = "auto",
          default_target = "en"
        }
      }
    }
  })
end
