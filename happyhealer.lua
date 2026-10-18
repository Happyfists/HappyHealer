--[[
    Happy Healer - an easy, Cure Please style healer for Ashita v4 (CatsEyeXI).

    The healing engine is Sidekick 2.9.0 by Seekey (MIT, see LICENSE_SIDEKICK):
    https://github.com/seekey13/Sidekick
    Happy Healer puts a simpler window on top of it (hh_ui.lua) and automates WHM, RDM, BRD,
    COR, SCH and GEO.

    AFK Sleep is Sidekick's own and unchanged (lib/core/afk.lua): after 10 minutes with no party
    movement and no combat, automation sleeps until YOU move.

    Commands
      /hh            show / hide the Happy Healer window
      /hh start      start healing        /hh stop    stop
      /hh help       every command (Sidekick's full list)
]]

addon.name    = 'happyhealer';
addon.author  = 'Happyfists';
addon.version = '1.1';
addon.desc    = 'Easy Cure Please style healer, built on Sidekick by Seekey.';
addon.link    = 'https://github.com/Happyfists/Omni';

require('common');
local imgui    = require('imgui');
local settings = require('settings');
local ffi      = require('ffi');
local d3d      = require('d3d8');

local sk  = require('hh_engine');   -- Sidekick's engine (registers its own events)
local hui = require('hh_ui');       -- the Happy Healer window's contents

local win = settings.load(T{
    show    = true,       -- main window open
    popout  = true,       -- small Start / Pause button while the window is closed
    dark    = false,      -- false = light (Cure Please), true = dark
    hh_pop_x = 300, hh_pop_y = 300,
}, 'happyhealer_window');
settings.register('happyhealer_window', 'happyhealer_window_update', function (s)
    if (s ~= nil) then win = s; end
end);
local function save() pcall(function () settings.save('happyhealer_window'); end); end

-- The window's Hide button and /hh.
hui.on_hide = function () win.show = false; save(); end;
-- /hh toggles the window.
sk.hooks.toggle = function ()
    win.show = not win.show;
    save();
end;

-- Job pictures for the party rows.
local function load_icons()
    local ok, result = pcall(function ()
        local texture_ptr = ffi.new('IDirect3DTexture8*[1]');
        local path = string.format('%s/assets/jobicons.png', addon.path);
        local res = ffi.C.D3DXCreateTextureFromFileA(d3d.get_device(), path, texture_ptr);
        if (res ~= ffi.C.S_OK) then return nil; end
        local texture = ffi.new('IDirect3DTexture8*', texture_ptr[0]);
        d3d.gc_safe_release(texture);
        return texture;
    end);
    return ok and result or nil;
end

ashita.events.register('load', 'happyhealer_load', function ()
    hui.icons = load_icons();
end);

-- The main window: Happy Healer's page, sized to fit what it shows (no scroll bars).
local open = { true };
ashita.events.register('d3d_present', 'happyhealer_window', function ()
    hui.dark = win.dark == true;
    if (not win.show) then
        if (win.popout ~= false) then
            pcall(hui.render_popout, sk, {
                settings = win,
                save = save,
                open = function () win.show = true; save(); end,
            });
        end
        return;
    end
    local W = 800;
    imgui.SetNextWindowSize({ W, math.max(200, math.min(900, math.floor(hui.height or 420))) + 12 }, ImGuiCond_Always);
    imgui.SetNextWindowPos({ 200, 150 }, ImGuiCond_FirstUseEver);
    imgui.PushStyleVar(ImGuiStyleVar_WindowPadding, { 6, 6 });
    imgui.PushStyleVar(ImGuiStyleVar_WindowRounding, 6);
    local flags = bit.bor(ImGuiWindowFlags_NoTitleBar, ImGuiWindowFlags_NoResize, ImGuiWindowFlags_NoScrollbar,
        ImGuiWindowFlags_NoScrollWithMouse, ImGuiWindowFlags_NoCollapse);
    open[1] = true;
    if (imgui.Begin('Happy Healer##hh_main', open, flags)) then
        local ok, err = pcall(hui.render, sk);
        if (not ok) then imgui.TextColored({ 1, 0.45, 0.45, 1 }, tostring(err)); end
    end
    imgui.End();
    imgui.PopStyleVar(2);
end);
