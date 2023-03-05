// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

//@version=5
indicator("KP - Red Dog Reversal", shorttitle = "RDR", overlay = true)

// Catch countertrend moves in overbought and oversold stocks (Both day & swing trading)
//
// Rules:
//  Buy Setup
// - Stock is trading down 2+ days in a row
// - Stock trades below prior day low and then reverses above prior day low
// - Buy when stock trades above prior day low with stop loss at current day low

//inputs
color upColor           = input.color(defval = color.blue, title = 'Up Color')
color downColor         = input.color(defval = color.fuchsia, title = 'Down Color')
color closeLineColor    = input.color(defval = color.gray, title = 'Prior day close line color')
bool  showPriorLevels   = input.bool(defval = true, title = "Show prior day setups")

dayMinus1Open     = request.security(syminfo.tickerid, '1D', open[1])
dayMinus2Open     = request.security(syminfo.tickerid, '1D', open[2])
dayMinus1High     = request.security(syminfo.tickerid, '1D', high[1])
dayMinus2High     = request.security(syminfo.tickerid, '1D', high[2])
dayMinus1Low      = request.security(syminfo.tickerid, '1D', low[1])
dayMinus2Low      = request.security(syminfo.tickerid, '1D', low[2])
dayMinus1Close    = request.security(syminfo.tickerid, "1D", close[1])
dayMinus2Close    = request.security(syminfo.tickerid, '1D', close[2])

// function

isToday         = year(timenow) == year(time) and month(timenow) == month(time) and dayofmonth(timenow) == dayofmonth(time)


// RDR Buy Setup

showIndicator = showPriorLevels or isToday
rdrUp   = false
rdrDown = false

if timeframe.isintraday
    rdrUp   := dayMinus1Close < dayMinus2Close and dayMinus1Low < dayMinus2Low and dayMinus1Open < dayMinus2Open and low < dayMinus1Low and close > dayMinus1Close and close > open
    rdrDown := dayMinus1Close > dayMinus2Close and dayMinus1High > dayMinus2High and dayMinus1Open > dayMinus2Open and high > dayMinus1High and close < dayMinus1Close and close < open
else
    rdrUp   := close[1] < close[2] and low[1] < low[2]  and open[1] < open[2] and low < low[1] and close > close[1] and close > open
    rdrDown := close[1] > close[2] and high[1] > high[2] and open[1] > open[2] and  high > high[1] and close < close[1] and close < open

barcolor(showIndicator and rdrUp ? upColor : na, title = "RDR Buy Setup")
plotchar(showIndicator and rdrUp, "RDR Up", "▲", location.belowbar, upColor, size = size.auto)
if (rdrUp or rdrDown) and showIndicator
    line.new(x1=bar_index - 3, y1 = dayMinus1Close, x2 = bar_index + 10, y2 = dayMinus1Close, color = closeLineColor, width = 2)

barcolor(showIndicator and rdrDown ? downColor : na, title = "RDR Sell Setup")
plotchar(showIndicator and rdrDown, "RDR Down", "▼", location.abovebar, downColor, size = size.auto)