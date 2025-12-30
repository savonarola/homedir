local minuet = require("minuet")

minuet.setup({
  provider = "claude",

  cmp = {
    enable_auto_complete = false,
  },

  provider_options = {
    claude = {
      model = "claude-haiku-4-5",
      api_key = "ANTHROPIC_API_KEY",
      max_tokens = 1024,
    },
  },

  n_completions = 4,
  context_window = 16000,
  throttle = 1000,
  debounce = 200,
  request_timeout = 3,
  notify = "warn",
})
