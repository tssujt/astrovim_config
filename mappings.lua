local utils = require "astronvim.utils"
local is_available = utils.is_available

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local maps = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>/"] = false,
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>D"] = { "<cmd>cd %:h<cr>", desc = "Set Working Directory to Current File" },
    ["<leader>fa"] = { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" },
    ["<leader>fc"] = {
      function()
        local cwd = vim.fn.stdpath "config" .. "/.."
        local search_dirs = {}
        for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
          if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
          if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
        end
        if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
          utils.notify("No user configuration files found", vim.log.levels.WARN)
        else
          if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
          require("telescope.builtin").find_files {
            prompt_title = "Config Files",
            search_dirs = search_dirs,
            cwd = cwd,
          } -- call telescope
        end
      end,
      desc = "Find AstroNvim config files",
    },
    ["<leader>fN"] = { "<cmd>Telescope noice<cr>", desc = "Find noice" },
    ["<leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" },
    ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    ["<leader>fw"] = {
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      desc = "Find words",
    },
    ["<leader>fW"] = false,
    ["<leader>tu"] = false,
    ["<leader>U"] = { "<cmd>Telescope undo<cr>", desc = "Undo" },
    ["<TAB>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-TAB>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {},
  x = {},
  o = {},
  v = {
    ["<leader>/"] = false,
    ["<leader>fr"] = {
      "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
      desc = "Find code refactors",
    },
  },
}

if is_available "vim-visual-multi" then
  -- visual multi
  vim.g.VM_mouse_mappings = 0
  vim.g.VM_theme = "iceblue"
  vim.g.VM_maps = {
    ["Find Under"] = "<C-n>",
    ["Find Subword Under"] = "<C-n>",
    ["Add Cursor Up"] = "<C-S-k>",
    ["Add Cursor Down"] = "<C-S-j>",
    ["Select All"] = "<C-S-n>",
    ["Skip Region"] = "<C-x>",
    Exit = "<C-c>",
  }
end

-- refactoring
if is_available "refactoring.nvim" then
  maps.n["<leader>r"] = { desc = " Refactor" }
  maps.v["<leader>r"] = { desc = " Refactor" }
end

-- trouble
if is_available "trouble.nvim" then
  maps.n["<leader>x"] = { desc = " Trouble" }
  maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
  maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
  maps.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
  maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
  maps.n["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" }
end

-- flash
if is_available "flash.nvim" then
  maps.n["<leader>s"] = {
    function() require("flash").jump() end,
    desc = "Flash",
  }
  maps.x["<leader>s"] = {
    function() require("flash").jump() end,
    desc = "Flash",
  }
  maps.o["<leader>s"] = {
    function() require("flash").jump() end,
    desc = "Flash",
  }
  maps.n["<leader><leader>s"] = {
    function() require("flash").treesitter() end,
    desc = "Flash Treesitter",
  }
  maps.x["<leader><leader>s"] = {
    function() require("flash").treesitter() end,
    desc = "Flash Treesitter",
  }
  maps.o["<leader><leader>s"] = {
    function() require("flash").treesitter() end,
    desc = "Flash Treesitter",
  }
end

return maps
