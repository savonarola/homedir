local minuet = require("minuet")

minuet.setup({
  -- provider = "claude",
  provider = "codestral",

  cmp = {
    enable_auto_complete = true,
  },

  provider_options = {
    claude = {
      model = "claude-haiku-4-5",
      api_key = "ANTHROPIC_API_KEY",
      max_tokens = 1024,
    },
    codestral = {
      model = "codestral-latest",
      api_key = "CODESTRAL_API_KEY",
      end_point = "https://api.mistral.ai/v1/fim/completions",
      max_tokens = 1024,
      optional = {
        max_tokens = 1024,
        stop = { "\n\n" },
        top_p = 1,
      },
    }
  },

  n_completions = 4,
  context_window = 16000,
  throttle = 1000,
  debounce = 200,
  request_timeout = 3,
  notify = "warn",
})
