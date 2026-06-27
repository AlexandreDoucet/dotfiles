-- Converted from your old Hyprland hyprlang config to Hyprland 0.55+ Lua config.
-- Save as: ~/.config/hypr/hyprland.lua
--
-- Notes:
-- - Hyprland 0.55+ loads hyprland.lua when present.
-- - The old dwindle:pseudotile option was removed in Hyprland 0.55, so it is not included.

----------------
-- MONITORS
----------------

--local monitorL = "desc:Dell Inc. DELL ST2220L 4DDG114U09DS"
local monitorM = "desc:Microstep MSI MAG321CQR KA3H079302793"
local monitorR = "desc:Hewlett Packard HP 27er 3CM74006TD"

-- Fallback for unspecified monitors, if needed:
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

--hl.monitor({
--  output = monitorL,
--  mode = "preferred",
--  position = "-1920x0",
--  scale = "auto",
--})

hl.monitor({
  output = monitorM,
  mode = "2560x1440@144",
  position = "0x-360",
  scale = "auto",
})

hl.monitor({
  output = monitorR,
  mode = "preferred",
  position = "2560x0",
  scale = "auto",
})



-- Workspace-to-monitor mapping
for _, workspace in ipairs({ 1, 3, 5, 7 }) do
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = monitorM,
  })
end

for _, workspace in ipairs({ 2, 4, 6, 8 }) do
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = monitorR,
  })
end

-- Default startup workspaces
hl.workspace_rule({
  workspace = "1",
  monitor = monitorM,
  default = true,
})

hl.workspace_rule({
  workspace = "2",
  monitor = monitorR,
  default = true,
})

----------------
-- PROGRAMS
----------------

local terminal = "ghostty"
-- local terminal = "ghostty"

local fileManager = "dolphin"
local menu = "rofi -auto-select -show drun -show-icons"
local userHome = "/home/adoucet/"

----------------
-- AUTOSTART
----------------

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl dispatch focusmonitor " .. monitorR)
  hl.exec_cmd("hyprctl dispatch workspace 2")

  hl.exec_cmd("hyprctl dispatch focusmonitor " .. monitorM)
  hl.exec_cmd("hyprctl dispatch workspace 1")

  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")

  hl.exec_cmd("waybar")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("mpt-detect")


  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  hl.exec_cmd("systemctl --user start hyprpolkitagent")

  hl.exec_cmd(userHome .. ".config/dotfiles/scripts/hyprpaper.sh")
  hl.exec_cmd(userHome .. ".config/dotfiles/scripts/mount_rclone.sh")

  hl.exec_cmd("update_audio.sh")
  hl.exec_cmd("transmission-qt -m")

  hl.exec_cmd(terminal)
end)

----------------
-- ENVIRONMENT
----------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

----------------
-- LOOK AND FEEL
----------------

hl.config({
  general = {
    gaps_in = 3,
    gaps_out = 5,

    border_size = 3,

    col = {
      active_border = {
        colors = {
          "rgba(33ccffee)",
          "rgba(00ff99ee)",
        },
        angle = -180,
      },
      inactive_border = "rgba(595959aa)",
    },

    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 10,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  -- dwindle:pseudotile was removed in Hyprland 0.55.
  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },

  input = {
    kb_layout = "us,ca",
    kb_variant = ",multix",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,
    sensitivity = 0,

    numlock_by_default = true,

    touchpad = {
      natural_scroll = false,
    },
  },

  xwayland = {
    enabled = true,
  },
})

----------------
-- ANIMATIONS
----------------

hl.curve("easeOutQuint", {
  type = "bezier",
  points = { { 0.23, 1 }, { 0.32, 1 } },
})

hl.curve("easeInOutCubic", {
  type = "bezier",
  points = { { 0.65, 0.05 }, { 0.36, 1 } },
})

hl.curve("linear", {
  type = "bezier",
  points = { { 0, 0 }, { 1, 1 } },
})

hl.curve("almostLinear", {
  type = "bezier",
  points = { { 0.5, 0.5 }, { 0.75, 1.0 } },
})

hl.curve("quick", {
  type = "bezier",
  points = { { 0.15, 0 }, { 0.1, 1 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

----------------
-- DEVICES
----------------

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

----------------
-- KEYBINDINGS
----------------

local mainMod = "SUPER"

-- Clipboard manager
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("hyprpaper.sh"))

-- Basic app/window binds
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- Duplicate from your old config
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(fileManager))

-- Screenshots
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))

-- Custom script
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("noita_backup"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Swap windows with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))


local function workspace_group_switch(backwards)
  local active = hl.get_active_workspace()
  local monitors = hl.get_monitors()
  local monitor_count = #monitors

  if active ~= nil then
    local active_id = active.id

    -- Convert current workspace to the first workspace in its monitor group.
    active_id = active_id - ((active_id - 1) % monitor_count)

    if backwards == true then
      active_id = active_id - monitor_count
    else
      active_id = active_id + monitor_count
    end

    -- Wrap around.
    -- Assuming workspaces 1 through 9.
    if active_id > 9 then
      active_id = 1
    end

    if active_id < 1 then
      -- Last group start for 1..9.
      --active_id = 9 - ((9 - 1) % monitor_count)
      active_id = 1
    end

    --hl.notification.create({
    --  text = tostring(active_id),
    --  timeout = 3000,
    --  icon = "ok"
    --})
    -- Focus all workspaces in the group.
    local reverse = monitor_count - 1
    for i = 0, monitor_count - 1 do
      j = reverse - i
      hl.dispatch(hl.dsp.focus({ workspace = active_id + j }))
    end
  end
end

hl.bind(mainMod .. " + CTRL + right", function()
  workspace_group_switch(false)
end)

hl.bind(mainMod .. " + CTRL + left", function()
  workspace_group_switch(true)
end) -- SwapWorkspaceCombo


-- Switch workspaces with mainMod + [1-9]
for i = 1, 9 do
  --hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + " .. i, function()
    hl.dispatch(hl.dsp.focus({ workspace = i }))
  end)
end

-- Move active window to workspace with mainMod + SHIFT + [1-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace: magic
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Special workspace: keepassxc
hl.bind(mainMod .. " + K", hl.dsp.workspace.toggle_special("keepassxc"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ workspace = "special:keepassxc" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 5%+"), {
  locked = true,
  repeating = true,
})

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 5%-"), {
  locked = true,
  repeating = true,
})

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), {
  locked = true,
  repeating = true,
})

-- Preserved from your old config. If this was meant to mute the microphone,
-- change @DEFAULT_SINK@ to @DEFAULT_SOURCE@.
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), {
  locked = true,
  repeating = true,
})

hl.bind("SUPER + F1", hl.dsp.exec_cmd("~/.config/dotfiles/scripts/update_audio"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), {
  locked = true,
  repeating = true,
})

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), {
  locked = true,
  repeating = true,
})

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Keyboard layout switching
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout logitech-usb-receiver next"))

----------------
-- WINDOW RULES
----------------
