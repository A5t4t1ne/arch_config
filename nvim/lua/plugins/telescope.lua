local telescope = require('telescope')

telescope.setup {
  defaults = {
    preview = {
      timeout = 501,
    },
  },
  pickers = {
    live_grep = {
      additional_args = function(_)
        return {"--hidden", "--glob", "!{.git,node_modules,vendor,docs,*.egg-info,.venv}/**"}
      end
    },
  },
}

