---------------------------------------------------------------------------
-- Widget that displays the status of a variable when higher  than a     --
-- specified threshold.                                                  --
-- The threshold, colors, and blinking are customisable                  --
--                                                                       --
-- Author:  Jonathan Neuhaus                                             --
-- Date:    2024-09-02                                                   --
-- Version: 1.0.0                                                        --
--                                                                       --
-- Copyright (C) EdgeTX                                                  --
--                                                                       --
-- License GPLv2: http://www.gnu.org/licenses/gpl-2.0.html               --
--                                                                       --
-- This program is free software; you can redistribute it and/or modify  --
-- it under the terms of the GNU General Public License version 2 as     --
-- published by the Free Software Foundation.                            --
--                                                                       --
-- This program is distributed in the hope that it will be useful        --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of        --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         --
-- GNU General Public License for more details.                          --
---------------------------------------------------------------------------
local name = "Status"

local function create(zone, options)
  -- Loadable code chunk is called immediately and returns a widget table
  return loadScript("/WIDGETS/" .. name .. "/loadable.lua")(zone, options)
end

local function refresh(widget, event, touchState)
  widget.refresh(event, touchState)
end

local function background(widget)
end

local options = {
  { "Source", SOURCE, DEFAULT_SOURCE },
  { "Threshold", VALUE, 0 , -100, 100 },
  { "Color_Off", COLOR, COLOR_THEME_PRIMARY1 },
  { "Color_On", COLOR, COLOR_THEME_PRIMARY2 },
  { "Blink", BOOL, 0 },
}

local function update(widget, options)
  widget.options = options
  widget.update(options)
end

return {
  name = name,
  create = create,
  refresh = refresh,
  background = background,
  options = options,
  update = update
}