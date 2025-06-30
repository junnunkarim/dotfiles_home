local available_bling, bling = pcall(require, "custom_modules.bling")
local available_rubato, rubato = pcall(require, "custom_modules.rubato") -- Totally optional, only required if you are using animations.

if available_rubato then
  -- These are example rubato tables. You can use one for just y, just x, or both.
  -- The duration and easing is up to you. Please check out the rubato docs to learn more.
  anim_y = rubato.timed {
    pos = 1090,
    rate = 60,
    easing = rubato.bouncy,
    intro = 0.1,
    duration = 0.2,
    awestore_compat = true -- This option must be set to true.
  }

  anim_x = rubato.timed {
    pos = -970,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.2,
    awestore_compat = true -- This option must be set to true.
  }
end

if available_bling then
  scratch_term = bling.module.scratchpad {
    command = "konsole --name scratch_term", -- How to spawn the scratchpad
    -- command = "alacritty --class scratch_term --config-file $HOME/.config/alacritty/alacritty_scratchpad.toml", -- How to spawn the scratchpad
    --command = "kitty --class scratch_term", -- How to spawn the scratchpad
    rule = {
      instance = "scratch_term"
    },                 -- The rule that the scratchpad will be searched by
    sticky = true,     -- Whether the scratchpad should be sticky
    autoclose = false, -- Whether it should hide itself when losing focus
    floating = true,   -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
    geometry = {
      x = 350,
      y = 50,
      height = 800,
      width = 1200
    },                               -- The geometry in a floating state
    reapply = true,                  -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
    dont_focus_before_close = false, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
    rubato = {
      -- x = anim_x,
      y = anim_y,
    } -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
  }

  scratch_btop = bling.module.scratchpad {
    command                 = "alacritty --class scratch_btop --config-file $HOME/.config/alacritty/alacritty_scratchpad.toml -e btop",
    rule                    = {
      instance = "scratch_btop"
    },
    sticky                  = false,
    autoclose               = false,
    floating                = true,
    geometry                = {
      x = 350,
      y = 50,
      height = 800,
      width = 1200
    },
    reapply                 = true,
    dont_focus_before_close = false,
    rubato                  = {
      -- x = anim_x,
      y = anim_y,
    }
  }

  scratch_pass = bling.module.scratchpad {
    command                 = "keepassxc",
    rule                    = {
      instance = "keepassxc"
    },
    sticky                  = false,
    autoclose               = true,
    floating                = true,
    geometry                = {
      x = 350,
      y = 50,
      height = 800,
      width = 1200
    },
    reapply                 = true,
    dont_focus_before_close = false,
    rubato                  = {
      -- x = anim_x,
      y = anim_y,
    }
  }

  scratch_zeal = bling.module.scratchpad {
    command                 = "zeal",
    rule                    = {
      instance = "zeal"
    },
    sticky                  = false,
    autoclose               = false,
    floating                = true,
    geometry                = {
      x = 350,
      y = 50,
      height = 800,
      width = 1200
    },
    reapply                 = true,
    dont_focus_before_close = false,
    rubato                  = {
      -- x = anim_x,
      y = anim_y,
    }
  }
end
