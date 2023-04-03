// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp
indicator("Topping Tail Candlestick", overlay=true)
//@version=5
// Define variables
var float bodySize = 0.0
var float upperShadowSize = 0.0
var float lowerShadowSize = 0.0

// Calculate candlestick sizes
tailPerc = 0.8
bodySize := math.abs(close - open)
upperShadowSize := high - math.max(open, close)
lowerShadowSize := math.min(open, close) - low
toppingTail = upperShadowSize > 0.6 *  bodySize and lowerShadowSize < bodySize
upTrendReversal = ta.rising(high[1], 3) and high >= ta.highest(high[1], 10) and close < open and  toppingTail 
plotchar(upTrendReversal, "Topping tail", "▼", location.abovebar, color.red, size = size.tiny)

upReversal = ta.rising(high[1], 3) and close < open and close < hl2[1] and open < close[1] and bodySize > lowerShadowSize
plotchar(upReversal, "Uptrend Reversal", "▼", location.abovebar, color.fuchsia, size = size.tiny)

bottomingTail = lowerShadowSize > 0.6 *  bodySize and upperShadowSize < bodySize
downTrendReversal = ta.falling(low[1], 3) and low <= ta.lowest(low[1], 10) and close > open  and  bottomingTail 
plotchar(downTrendReversal, "Topping tail", "▲", location.belowbar, color.green, size = size.tiny)

downReversal = ta.falling(low[1], 3) and close > open and close > hl2[1] and open < close[1] and bodySize > upperShadowSize
plotchar(downReversal, "Down Reversal", "▲", location.belowbar, color.blue, size = size.tiny)
