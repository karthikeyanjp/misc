// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

//@version=5
indicator("KP - SPX Levels", shorttitle = "SPX Levels", overlay = true)
spx_hl2 = request.security('SPX', timeframe.period, hl2)
spx = request.security('SPX', timeframe.period, close)
spx_high = request.security('SPX', timeframe.period, high)
spx_low = request.security('SPX', timeframe.period, low)
spx_open = request.security('SPX', timeframe.period, open)
spx_increment = 50

cross(lw, hgh, lvl) =>
    lw < lvl and hgh > lvl

spx_levels = math.round(spx_hl2[1] / spx_increment) * spx_increment - 3
spx_levels_up = spx_levels + spx_increment
spx_levels_down = spx_levels - spx_increment 

spxCross = cross(spx_low, spx_high, spx_levels) or cross(spx_low, spx_high, spx_levels_up) or cross(spx_low, spx_high, spx_levels_down)
spxCrossOver = spxCross and spx > spx_open
spxCrossUnder = spxCross and spx < spx_open
// plotchar(spxCrossOver ? high : na, title="SPX Cross Above 4000", char='↑', location=location.belowbar, color=color.green, size=size.tiny)
// plotchar(spxCrossUnder ? low : na, title="SPX Cross Below 4000", char='↓', location=location.abovebar, color=color.red, size=size.tiny)
var line crossUpLine = na
var line crossDownLine = na

isToday         = year(timenow) == year(time) and month(timenow) == month(time) and dayofmonth(timenow) == dayofmonth(time)

if spxCrossOver
    crossUpLine   := line.new(bar_index,  high,     bar_index,    high,       color=color.maroon,    style = line.style_dashed)
if spxCrossUnder
    crossDownLine   := line.new(bar_index,  low,     bar_index,    low,       color=color.maroon,    style = line.style_dashed)

line.set_x2(crossUpLine,  bar_index)
line.set_x2(crossDownLine,  bar_index)
if barstate.islast
    line.set_extend(crossUpLine,  extend =  extend.right)
    line.set_extend(crossDownLine,  extend =  extend.right)
