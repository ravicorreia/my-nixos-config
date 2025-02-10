---@diagnostic disable: missing-fields
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {

        --LINHAS DE CÓDIGO ESTÃO DUPLAMENTE COMENTADAS '----'

        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { 
          "vim",
          "vimdoc",
          "query",
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "tsx",
          "typescript",
          "yaml",
        },

        -- PROVAVELMENTE NÃO PRECISAREMOS DESSA OPÇÃO
        -- Install parsers synchronously (only applied to `ensure_installed`)
        ---- sync_install = false,

        -- PREFERÍVEL QUE EU MESMO ADICIONE A LINGUAGEM À LISTA
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        -- List of parsers to ignore installing (or "all")
        ---- ignore_install = { "javascript" },

        -- PROVAVELMENTE NÃO PRECISAREI DISSO (CUSTOM DIRECTORY)
        -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        ---- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          ---- disable = { "c", "rust" },
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          ---@diagnostic disable-next-line: unused-local
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            ---@diagnostic disable-next-line: undefined-field
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          -- ESSA OPÇÃO SE FAZ NECESSÁRIO SE ESTIVER USANDO PHP OU RUSTY
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  }
}
