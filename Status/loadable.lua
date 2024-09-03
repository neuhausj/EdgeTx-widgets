---------------------------------------------------------------------------
-- The dynamically loadable part of the demonstration Lua widget.        --
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
-- MERCHANTABILITY or FITNESS FOR borderON PARTICULAR PURPOSE. See the   --
-- GNU General Public License for more details.                          --
---------------------------------------------------------------------------

-- This code chunk is loaded on demand by the LibGUI widget's main script
-- when the create(...) function is run. Hence, the body of this file is
-- executed by the widget's create(...) function.

-- zone and options were passed as arguments to chunk(...)
local zone, options = ...
local blinkTime = 0
local blink
-- The widget table will be returned to the main script
local widget = { }

-- This function is called from the refresh(...) function in the main script
function widget.refresh(event, touchState)
  if options.Source ~= nil and options.Threshold ~= nil then
    local currentValue = getValue(options.Source)/10.24 -- convert in %
    lcd.drawCircle(zone.w/2, zone.h/2, math.min(zone.w,zone.h)/2, BLACK)
    -- When threshold is reached, either blink or set color depending on widget setting
    if (currentValue > options.Threshold and options.Blink==0) or (currentValue > options.Threshold and options.Blink==1 and blink) then
      lcd.drawFilledCircle(zone.w/2, zone.h/2, math.min(zone.w,zone.h)/2-2, options.Color_On)
    else
      lcd.drawFilledCircle(zone.w/2, zone.h/2, math.min(zone.w,zone.h)/2-2, options.Color_Off)
    end
  else
    lcd.drawTextLines(0, 0, zone.w, zone.h, "Check settings!", COLOR_THEME_WARNING)
  end
  -- only for debug > print(string.format("%s",currentValue))
  -- Generate blinking signal each 800ms
  if getTime() - blinkTime > 80 then
    blink = not blink
    blinkTime = getTime()
  end
end

-- This function is called from the update(...) function in the main script, when an option is changed
function widget.update(opt)
  options = opt
  widget.refresh()
end

-- Return to the create(...) function in the main script
return widget
