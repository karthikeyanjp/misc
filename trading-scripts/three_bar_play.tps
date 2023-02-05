// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

//@version=5
indicator("Three Bar Play (TBP)", overlay=true)
greenIgnitingBar = close > open and ta.mom(close, 1) > 50 * syminfo.mintick
greenPullBackBar = close >= hl2[1] and low >= hl2[1] and ta.roc(math.max(close, open), 1) < 0.01 
greenHighBar = close > open and close > math.max(close[1], open[1]) and math.abs(close - math.min(close[1], open[1])) > 20 * syminfo.mintick and math.abs(high - close) < 30 * syminfo.mintick and math.abs(low - open) < 30 * syminfo.mintick
greenThreeBarPattern =  greenIgnitingBar[2] and greenPullBackBar[1] and greenHighBar
if (greenThreeBarPattern)
    box.new(bar_index[3], high, bar_index + 1, math.min(low, low[2]), border_color = color.new(color.blue, 20), bgcolor = na, border_width=2)

redIgnitingBar = close < open and math.abs(ta.mom(close, 1)) > 40 * syminfo.mintick
redPullBackBar = close <= hl2[1] and high <= hl2[1] and math.abs(ta.roc(math.min(close, open), 1)) < 0.01 
redHighBar = close < open and close < math.min(close[1], open[1]) and math.abs(close - math.min(close[1], open[1])) > 20 * syminfo.mintick and math.abs(high - open) < 30 * syminfo.mintick and math.abs(low - close) < 30 * syminfo.mintick
redThreeBarPattern =  redIgnitingBar[2] and redPullBackBar[1] and redHighBar
if (redThreeBarPattern)
    box.new(bar_index[3], high[2], bar_index + 1, math.min(low, low[2]), border_color = color.new(color.fuchsia, 10), bgcolor = na, border_width=2)
