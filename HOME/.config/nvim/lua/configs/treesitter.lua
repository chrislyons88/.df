local options = {
  ensure_installed = {
    -- vim/lua
    "vim",
    "lua",
    "vimdoc",

    -- frontend web
    "html",
    "css",
    "scss",
    "javascript",
    "typescript",
    "json",
    "graphql",
    "vue",
    "svelte",
    "astro",
    "tsx",

    -- general purpose
    "markdown",
    "markdown_inline",
    "mermaid",
    "toml",
    "yaml",
    "xml",
    "csv",
    "dockerfile",
    "terraform",
    "tmux",
    "ssh_config",
    "regex",
    "git_config",
    "gitignore",

    -- backend and shell
    "bash",
    "python",
    "rust",
    "sql",
  },
  auto_install = true, -- Enable automatic installation of missing parsers
}

return options
