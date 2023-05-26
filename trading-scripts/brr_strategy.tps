// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

//@version=5
indicator("KP - BRR Strategy", shorttitle = "BRR strategy", overlay = true)

// inputs
// color   ema200_color    = input.color(defval = color.fuchsia, title = "200 EMA color")
color   crossOverColor  = input.color(defval = color.new(color.green, 50), title = "Fast EMA color")
color   crossUnderColor = input.color(defval = color.new(color.red, 50), title = "Slow EMA color")
bool    showPriorLevels = input.bool(defval = true, title = "Show prior day's price levels")

// variables
var line        premarketHighLine       = na
var line        premarketLowLine        = na
var line        priorDayHighLine        = na
var line        priorDayLowLine         = na

var pmHigh      = float(na)
var pmLow       = float(na)
var priorHigh   = float(na)
var priorLow    = float(na)

var colorHigh   = color.green
var colorLow    = color.red

// function

isToday         = year(timenow) == year(time) and month(timenow) == month(time) and dayofmonth(timenow) == dayofmonth(time)


// Logic

// Logic

if session.isfirstbar and session.ispremarket
    pmHigh  := high
    pmLow   := low
else
    pmHigh  := pmHigh[1]
    pmLow   := pmLow[1]

if high > pmHigh and session.ispremarket
    pmHigh  := high
    line.set_y1(premarketHighLine, pmHigh)
    line.set_y2(premarketHighLine, pmHigh)

if low < pmLow and session.ispremarket
    pmLow  := low
    line.set_y1(premarketLowLine, pmLow)
    line.set_y2(premarketLowLine, pmLow)

ema200      = ta.ema(close, 200)
ema8_5min   = request.security(syminfo.tickerid, "5", ta.ema(close, 8))
ema8_15min  = request.security(syminfo.tickerid, "15", ta.ema(close, 8))
fastEMA     = ta.ema(close, 13)
slowEMA     = ta.ema(close, 48)
emaCloudColor = fastEMA > slowEMA ? crossOverColor : crossUnderColor
priorHigh   := request.security(syminfo.tickerid, 'D', syminfo.session == session.regular ? high[1] : high,    lookahead = barmerge.lookahead_on)
priorLow    := request.security(syminfo.tickerid, 'D', syminfo.session == session.regular ? low[1] : low,      lookahead = barmerge.lookahead_on)

if dayofweek != dayofweek[1] and (showPriorLevels or isToday)
    premarketHighLine   := line.new(bar_index,  pmHigh,     bar_index,    pmHigh,       color=colorHigh,    style = line.style_solid)
    premarketLowLine    := line.new(bar_index,  pmLow,      bar_index,    pmLow,        color=colorLow,     style = line.style_solid)
    priorDayHighLine    := line.new(bar_index,  priorHigh,  bar_index,    priorHigh,    color=colorHigh,    style=line.style_solid)
    priorDayLowLine     := line.new(bar_index,  priorLow,   bar_index,    priorLow,     color=colorLow,     style=line.style_solid)

line.set_x2(premarketHighLine,  bar_index)
line.set_x2(premarketLowLine,   bar_index)
line.set_x2(priorDayHighLine,   bar_index)
line.set_x2(priorDayLowLine,    bar_index)

if barstate.islast
    line.set_extend(premarketHighLine,  extend =  extend.right)
    line.set_extend(premarketLowLine,   extend =  extend.right)
    line.set_extend(priorDayHighLine,   extend =  extend.right)
    line.set_extend(priorDayLowLine,    extend =  extend.right)

fastEMAPlot = plot(fastEMA, color = na, linewidth = 0, display = display.none)
slowEMAPlot = plot(slowEMA, color = na, linewidth = 0, display = display.none)
plot(ema200, title = "200 EMA", color = close > ema200 and close > ema8_5min and close > ema8_15min ? color.new(color.green, 20) :  close < ema200 and close < ema8_5min and close < ema8_15min ? color.new(color.red, 20): color.new(color.gray, 20), linewidth = 8)
plot(ema8_5min, title = "8/5 EMA", color = color.black, linewidth = 2)
plot(ema8_15min, title = "8/15 EMA", color = color.maroon, linewidth = 2)
fill(fastEMAPlot, slowEMAPlot, color = emaCloudColor, title = "EMA Cloud")

// Alerts
alertcondition(ta.crossover(fastEMA, slowEMA) and close > ema200, title = "Buy Opty", message = "{{ticker}} - 13/48 EMA crossover above 200 EMA")
alertcondition(ta.crossunder(fastEMA, slowEMA) and close < ema200, title = "Sell Opty", message = "{{ticker}} - 13/48 EMA crossunder below 200 EMA")

