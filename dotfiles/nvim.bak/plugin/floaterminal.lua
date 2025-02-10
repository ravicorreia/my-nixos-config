local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

local function create_floating_window(config)
  -- config = config or {}
  -- Default configuration
  local defaults = {
    width = 0.7,  -- 70% of the screen width
    height = 0.7, -- 70% of the screen height
  }

  -- Merge user-provided config with defaults
  config = vim.tbl_extend('force', defaults, config or {})

  -- Get the current UI dimensions
  local ui = vim.api.nvim_list_uis()[1]
  local screen_width = ui.width
  local screen_height = ui.height

  -- Calculate the width and height of the floating window
  local width = math.floor(screen_width * config.width)
  local height = math.floor(screen_height * config.height)

  -- Calculate the position to center the window
  local col = math.floor((screen_width - width) / 2)
  local row = math.floor((screen_height - height) / 2)

  -- Create a new buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(config.buf) then
    buf = config.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded', -- Optional: Add a border
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)


  -- Return the buffer and window IDs
  return { buf = buf, win = win }
end

-- Create a toggle command
local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})

-- Toggle hotkey keybind
vim.keymap.set('n', ';ft', '<cmd>Floaterminal<CR>')
