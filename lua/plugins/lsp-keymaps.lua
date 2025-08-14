return {
  {
    "ray-x/go.nvim",
    keys = {
      { "<leader>gsj", "<cmd>GoAddTag json<cr>", desc = "Add json struct tags" },
      { "<leader>gsy", "<cmd>GoAddTag yaml<cr>", desc = "Add yaml struct tags" },
      { "<leader>gst", "<cmd>GoAddTag toml<cr>", desc = "Add toml struct tags" },
      { "<leader>gsf", "<cmd>GoFillStruct<cr>", desc = "Fill struct" },
      { "<leader>gse", "<cmd>GoIfErr<cr>", desc = "Add if err" },
      { "<leader>gch", "<cmd>GoClearTag<cr>", desc = "Clear tags" },
      { "<leader>gco", "<cmd>GoCmt<cr>", desc = "Generate comment" },
      { "<leader>gie", "<cmd>GoIfErr<cr>", desc = "Generate if err" },
      { "<leader>gdj", "<cmd>GoDebug -s<cr>", desc = "Debug" },
      { "<leader>gdt", "<cmd>GoDebug -t<cr>", desc = "Debug test" },
      { "<leader>gdT", "<cmd>GoDebug -T<cr>", desc = "Debug test file" },
      { "<leader>gtr", "<cmd>GoTestFunc<cr>", desc = "Test function" },
      { "<leader>gtf", "<cmd>GoTestFile<cr>", desc = "Test file" },
      { "<leader>gta", "<cmd>GoTest<cr>", desc = "Test all" },
      { "<leader>gtc", "<cmd>GoCoverage<cr>", desc = "Test coverage" },
      { "<leader>gtT", "<cmd>GoTestFunc -T<cr>", desc = "Test function verbose" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>co",
        function()
          vim.lsp.buf_request(0, "workspace/executeCommand", {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
          })
        end,
        desc = "Organize Imports",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      }

      keys[#keys + 1] = {
        "<leader>cI",
        function()
          vim.lsp.buf_request(0, "workspace/executeCommand", {
            command = "gopls.add_import",
            arguments = {
              {
                ImportPath = vim.fn.input("Import path: "),
              },
            },
          })
        end,
        desc = "Add Import",
        ft = "go",
      }

      keys[#keys + 1] = {
        "<leader>cj",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format JSON",
        ft = { "json", "jsonc" },
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        bash = { "shfmt" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        lua = { "stylua" },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "prettier",
        "stylua", 
        "shfmt",
        "gofumpt",
        "goimports",
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        bash = { "shellcheck" },
        sh = { "shellcheck" },
        json = { "jsonlint" },
        markdown = { "markdownlint-cli2" },
      },
    },
  },
}