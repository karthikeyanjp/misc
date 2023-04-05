// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

//@version=5
indicator("KP - moving averages", shorttitle = "MAs", overlay = true)
src = close
ema5 = ta.ema(src, 5)
ema8 = ta.ema(src, 8)
ema21 = ta.ema(src, 21)
ema55 = ta.ema(src, 55)
ema200 = ta.ema(src, 200)
fillColor = ema5 > ema8 ? color.new(color.green, 50) : color.new(color.red, 50)
ema5_plot = plot(ema5, color = na, linewidth = 0, style = plot.style_line)
ema8_plot = plot(ema8, color = na, linewidth = 0, style = plot.style_line)
ema21_plot = plot(ema21, color=color.new(color.purple, 70), linewidth = 3)
price_plot = plot(close > ema5 ? math.min(open, close) : math.max(open, close), color = na, linewidth = 0)
ema55_plot = plot(ema55, color=color.orange, linewidth = 4)ƒ
// ema200_plot = plot(ema200, color=color.black, linewidth = 4)
fill(ema5_plot, ema8_plot, color = fillColor)
fill(price_plot, ema5_plot, color =  color.new(color.yellow, 60))
