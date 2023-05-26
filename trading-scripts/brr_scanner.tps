// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © karthikeyanjp

//@version=5
indicator("KP - BRR Scanner", shorttitle = "BRR Scanner", overlay = true)

screener() => 
    ema200      = ta.ema(close, 200)
    fastEMA     = ta.ema(close, 13)
    slowEMA     = ta.ema(close, 48)
    [close > ema200 and close >= fastEMA and fastEMA > slowEMA , close < ema200 and close <= fastEMA and fastEMA < slowEMA, close, ta.barssince(ta.cross(fastEMA, slowEMA)) < 5]
s1 = 'NVDA'
s2 = 'AMZN'
s3 = 'MSFT'
s4 = 'AAPL'
s5 = 'TSLA'
s6 = 'META'
s7 = 'SPY'
s8 = 'SPX'
s9 = 'QQQ'

[s1_b, s1_s, s1_p, s1_c] = request.security(s1, timeframe.period, screener())
[s2_b, s2_s, s2_p, s2_c] = request.security(s2, timeframe.period, screener())
[s3_b, s3_s, s3_p, s3_c] = request.security(s3, timeframe.period, screener())
[s4_b, s4_s, s4_p, s4_c] = request.security(s4, timeframe.period, screener())
[s5_b, s5_s, s5_p, s5_c] = request.security(s5, timeframe.period, screener())
[s6_b, s6_s, s6_p, s6_c] = request.security(s6, timeframe.period, screener())
[s7_b, s7_s, s7_p, s7_c] = request.security(s7, timeframe.period, screener())
[s8_b, s8_s, s8_p, s8_c] = request.security(s8, timeframe.period, screener())
[s9_b, s9_s, s9_p, s9_c] = request.security(s9, timeframe.period, screener())


var s_tbl = table.new(position.bottom_right, 4, 10, bgcolor = color.new(color.gray, 30), frame_width = 2, frame_color = color.black, border_color = color.white, border_width = 2)
myAtr = ta.atr(10)

title_color = color.new(color.lime, 0)
text_color = color.white
table.cell(s_tbl, 0, 0, 'Symbol', text_color = color.black, bgcolor = title_color)
table.cell(s_tbl, 1, 0, 'Setup', text_color = color.black, bgcolor = title_color)
table.cell(s_tbl, 2, 0, 'Price', text_color = color.black, bgcolor = title_color)
table.cell(s_tbl, 3, 0, 'Cross', text_color = color.black, bgcolor = title_color)
table.cell(s_tbl, 0, 1, s1, text_color = text_color)
table.cell(s_tbl, 0, 2, s2, text_color = text_color)
table.cell(s_tbl, 0, 3, s3, text_color = text_color)
table.cell(s_tbl, 0, 4, s4, text_color = text_color)
table.cell(s_tbl, 0, 5, s5, text_color = text_color)
table.cell(s_tbl, 0, 6, s6, text_color = text_color)
table.cell(s_tbl, 0, 7, s7, text_color = text_color)
table.cell(s_tbl, 0, 8, s8, text_color = text_color)
table.cell(s_tbl, 0, 9, s9, text_color = text_color)
table.cell(s_tbl, 3, 1, s1_c ? 'cross' : '-', text_color = text_color, bgcolor = s1_c ? color.purple : na)
table.cell(s_tbl, 3, 2, s2_c ? 'cross' : '-', text_color = text_color, bgcolor = s2_c ? color.purple : na)
table.cell(s_tbl, 3, 3, s3_c ? 'cross' : '-', text_color = text_color, bgcolor = s3_c ? color.purple : na)
table.cell(s_tbl, 3, 4, s4_c ? 'cross' : '-', text_color = text_color, bgcolor = s4_c ? color.purple : na)
table.cell(s_tbl, 3, 5, s5_c ? 'cross' : '-', text_color = text_color, bgcolor = s5_c ? color.purple : na)
table.cell(s_tbl, 3, 6, s6_c ? 'cross' : '-', text_color = text_color, bgcolor = s6_c ? color.purple : na)
table.cell(s_tbl, 3, 7, s7_c ? 'cross' : '-', text_color = text_color, bgcolor = s7_c ? color.purple : na)
table.cell(s_tbl, 3, 8, s8_c ? 'cross' : '-', text_color = text_color, bgcolor = s8_c ? color.purple : na)
table.cell(s_tbl, 3, 9, s9_c ? 'cross' : '-', text_color = text_color, bgcolor = s9_c ? color.purple : na)
table.cell(s_tbl, 2, 1, str.tostring(s1_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 2, str.tostring(s2_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 3, str.tostring(s3_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 4, str.tostring(s4_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 5, str.tostring(s5_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 6, str.tostring(s6_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 7, str.tostring(s7_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 8, str.tostring(s8_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 2, 9, str.tostring(s9_p, format.mintick), text_color = text_color)
table.cell(s_tbl, 1, 1, s1_b ? 'BUY' : s1_s ?  'SELL' : '-', text_color = text_color, bgcolor = s1_b ? color.green : s1_s ? color.red : na)
table.cell(s_tbl, 1, 2, s2_b ? 'BUY' : s2_s ?  'SELL' : '-', text_color = text_color, bgcolor = s2_b ? color.green : s2_s ? color.red : na)
table.cell(s_tbl, 1, 3, s3_b ? 'BUY' : s3_s ?  'SELL' : '-', text_color = text_color, bgcolor = s3_b ? color.green : s3_s ? color.red : na)
table.cell(s_tbl, 1, 4, s4_b ? 'BUY' : s4_s ?  'SELL' : '-', text_color = text_color, bgcolor = s4_b ? color.green : s4_s ? color.red : na)
table.cell(s_tbl, 1, 5, s5_b ? 'BUY' : s5_s ?  'SELL' : '-', text_color = text_color, bgcolor = s5_b ? color.green : s5_s ? color.red : na)
table.cell(s_tbl, 1, 6, s6_b ? 'BUY' : s6_s ?  'SELL' : '-', text_color = text_color, bgcolor = s6_b ? color.green : s6_s ? color.red : na)
table.cell(s_tbl, 1, 7, s7_b ? 'BUY' : s7_s ?  'SELL' : '-', text_color = text_color, bgcolor = s7_b ? color.green : s7_s ? color.red : na)
table.cell(s_tbl, 1, 8, s8_b ? 'BUY' : s8_s ?  'SELL' : '-', text_color = text_color, bgcolor = s8_b ? color.green : s8_s ? color.red : na)
table.cell(s_tbl, 1, 9, s9_b ? 'BUY' : s9_s ?  'SELL' : '-', text_color = text_color, bgcolor = s9_b ? color.green : s9_s ? color.red : na)

plot(0, color = na)
