// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

//@version=5
indicator("Price Levels", shorttitle = 'Price levels',  overlay = true)

// inputs

bool        showPriorLevels = input.bool(defval = true, title = "Show prior day's price levels")


color       colorLow        = input.color(defval = color.red, title = "price lows color")
color       colorHigh       = input.color(defval = color.green, title = "price highs color")

// variables
var line        premarketHighLine       = na
var line        premarketLowLine        = na
var line        priorDayHighLine        = na
var line        priorDayLowLine         = na
var line        priorMthHighLine        = na
var line        priorMthLowLine         = na

var pmHigh      = float(na)
var pmLow       = float(na)
var priorHigh   = float(na)
var priorLow    = float(na)
var priorMHigh  = float(na)
var priorMLow   = float(na)

// function

isToday         = year(timenow) == year(time) and month(timenow) == month(time) and dayofmonth(timenow) == dayofmonth(time)


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

priorHigh    := request.security(syminfo.tickerid, 'D', syminfo.session == session.regular ? high[1] : high,    lookahead = barmerge.lookahead_on)
priorLow     := request.security(syminfo.tickerid, 'D', syminfo.session == session.regular ? low[1] : low,      lookahead = barmerge.lookahead_on)
priorMHigh   := request.security(syminfo.tickerid, 'M', high[1],    lookahead = barmerge.lookahead_on)
priorMLow    := request.security(syminfo.tickerid, 'M', low[1],     lookahead = barmerge.lookahead_on)

if dayofweek != dayofweek[1] and (showPriorLevels or isToday)
    premarketHighLine   := line.new(bar_index,  pmHigh,     bar_index,    pmHigh,       color=colorHigh,    style = line.style_dashed)
    premarketLowLine    := line.new(bar_index,  pmLow,      bar_index,    pmLow,        color=colorLow,     style = line.style_dashed)
    priorDayHighLine    := line.new(bar_index,  priorHigh,  bar_index,    priorHigh,    color=colorHigh,    style=line.style_solid)
    priorDayLowLine     := line.new(bar_index,  priorLow,   bar_index,    priorLow,     color=colorLow,     style=line.style_solid)
    priorMthHighLine    := line.new(bar_index,  priorMHigh, bar_index,    priorMHigh,   color=colorHigh,    style=line.style_dotted)
    priorMthLowLine     := line.new(bar_index,  priorMLow,  bar_index,    priorMLow,    color=colorLow,     style=line.style_dotted)

line.set_x2(premarketHighLine,  bar_index)
line.set_x2(premarketLowLine,   bar_index)
line.set_x2(priorDayHighLine,   bar_index)
line.set_x2(priorDayLowLine,    bar_index)
line.set_x2(priorMthHighLine,   bar_index)
line.set_x2(priorMthLowLine,    bar_index)

if barstate.islast
    line.set_extend(premarketHighLine,  extend =  extend.right)
    line.set_extend(premarketLowLine,   extend =  extend.right)
    line.set_extend(priorDayHighLine,   extend =  extend.right)
    line.set_extend(priorDayLowLine,    extend =  extend.right)
    line.set_extend(priorMthHighLine,   extend =  extend.right)
    line.set_extend(priorMthLowLine,    extend =  extend.right)