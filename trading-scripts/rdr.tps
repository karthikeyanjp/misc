// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

// Red Dog Reversal - Learnt from Scott Redler (t3live.com)

// Buy Condition
//  - Stock is down 2+ days in a row
//  - Stock goes below previous day low and then goes above previous day low (reclaim). 
//  - Buy when price reclaim happens
//  - Stop loss at current day low
//
// Similar condition for Sell

//@version=5
indicator("Red Dog Reversal - RDR", overlay = true)
colorReversalBar = input.bool(true, "Color the reversal bar?")
showBuySellIndicator = input.bool(true, "Show Buy/Sell indicator?")
buyColor = input.color(color.blue, "Buy color")
sellColor = input.color(color.fuchsia, "Sell color")
// rdrUp =  close[2] < open[2] and close[1] < open[1] and close[1] <= close[2] and open[2] >= open[1] and low < low[1] and close > 0.5 * (open[1] + close[1]) 
// rdrDown = close[2] > open[2] and close[1] > open[1] and close[1] >= close[2] and open[1] >= open[2] and high > high[1] and close < 0.5 * (open[1] + close[1]) 
rdrUp =  ta.falling(close, 2)[1] and ta.falling(low, 2) and close > open and close > 0.3 * (close[1] + open[1]) and math.abs(close - open) > 20 * syminfo.mintick
plotchar(showBuySellIndicator and rdrUp, "Go Long",  "▲", location.belowbar, buyColor, size = size.tiny)
rdrDown = ta.rising(close, 2)[1] and ta.rising(high, 2) and close < open and close < 0.7 * (close[1] + open[1]) and math.abs(close - open) > 20 * syminfo.mintick
plotchar(showBuySellIndicator and rdrDown, "Go Short", "▼", location.abovebar, sellColor,  size = size.tiny)
barcolor(colorReversalBar? rdrUp? buyColor : rdrDown ?  sellColor : na : na, title="test")
