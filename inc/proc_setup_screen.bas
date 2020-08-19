rem -------------------
rem -- Sets up the main screen
rem --
rem -- @param byte draw_title!
rem -- Sets whether the 
rem -- title screen (1) or end title (2)
rem -- is to be drawn
rem -------------------

proc setup_screen(draw_title!)
  
  rem -- turn off screen
  poke \VIC_CONTROL1, peek!(\VIC_CONTROL1) & %11101111
  
  memset \COLOR, 200, 5
  
  poke 55385, 2 : poke 55386, 2
  memset 55423, 4, 2
  
  poke 55338, 2
  poke 55339, 7
  poke 55340, 7
  
  memcpy @dashboard!, \SCREEN, 200
  on draw_title! gosub draw_bg, draw_title, draw_end_title
 
  memset 1984, 40, 160
  memset 55936, 360, 14
 
  for n = \SCROLL_AREA_TOP to \SCROLL_AREA_BOTTOM
    poke n, 90
  next n

  loc = \CITY_MAP_DEFAULT_PTR_LEFT + 1
  for col! = 0 to 39
    for i! = 16 to 23
      poke 1024 + i! * 40 + col!, peek!(loc)
      inc loc
    next i!
  next col!
  
  if draw_title! = 1 then poke 1830, 32 : poke 1796, 32 : poke 1878, 32 : poke 1879, 32
  
  textat 7, 3, \hiscore
  
  rem -- turn on screen
  poke \VIC_CONTROL1, peek!(\VIC_CONTROL1) | %00010000
  
  return
  
  draw_bg:
    memcpy @background_graphics!, \SCREEN + 200, 440
    memset \COLOR + 200, 440, 9
    memset $d9ed, 15, 2
    return
  draw_title:
    memcpy @background_title!, \SCREEN + 200, 440
    memcpy @background_title_color!, \COLOR + 200, 440
    return
  draw_end_title:
    memcpy @background_end!, \SCREEN + 200, 440
    memcpy @background_end_color!, \COLOR + 200, 440
    return
  
  data dashboard![] = ~
    32,199,  6, 21,  5, 12, 32, 32, 32, 32, 32, 32, 18,  1,  4,  1, 18, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,  6, 12,  5,  5, 20, 32, 32, 32,206, 32, ~
    32,199, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 184,190,190,190,190,190,190,190,190,190,190,190,190,190,190,185, 32, 32,182,176, 32, 32, 32, 32, 32, 32,206, 32, ~
    32,199, 19,  3, 15, 32, 32,  8,  9, 32, 32, 32, 188, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,189, 32, 32,183,177,163,164,150,151,166,167,206, 32, ~
    32,199, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 187,191,191,191,191,191,191,192,193,191,191,191,191,191,191,186, 32, 32, 32, 48, 48, 32, 32, 48, 48, 32,206, 32, ~
    32,205,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,207, 32

  data background_graphics![] = ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,210, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,227,228,229,231, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,210, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,243,244,245,246, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,152,153,154,158, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,238,239,254,255, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,210, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,210, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,211, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 211,32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32,210, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
    
  data background_title![] = ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,210, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 27, 29, 31, 34, 35, 37, 32, 39, 41, 43, 45, 27, 58, 39, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 28, 30, 33, 34, 36, 38, 32, 40, 42, 44, 46, 47, 59, 40, 32, 32, 32, 32, 32, 32, 32, 32,227,228,229,231, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,243,244,245,246, 32, ~
    32, 32, 32, 32, 32, 32, 32,  3, 15,  4,  5, 60, 19,  6, 24, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,152,153,154,158, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,  3, 19,  1,  2,  1, 32,  6,  5, 11,  5, 20,  5, 32,236, 14,  5,  9, 12, 19,237, 32, 32,238,239,254,255, 32, ~
    32, 32, 32, 32, 32, 32, 32,  7, 18,  1, 16,  8,  9,  3, 19, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,217, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,  4,  1, 14,  9,  5, 12, 32,  6,  5, 11,  5, 20,  5, 32,236, 15, 18,  9, 15, 14,237, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,211, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 16, 18,  5, 19, 19, 32,  6,  9, 18,  5, 32,  2, 21, 20, 20, 15, 14, 32, 20, 15, 32, 19, 20,  1, 18, 20, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32,210, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32  

  data background_title_color![] = ~
    14, 14, 14, 14, 14, 14, 14, 14,  5,  5, 13, 13, 14, 14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 13, 13, 13, 14, 14, 14,  9,  9, 14, 14, 14, 14, ~
    14, 14, 14, 14, 14, 14, 14, 14,  5,  5,  5,  5, 14,  5,  5,  5,  5,  5,  5, 14,  5,  5,  5,  5,  5,  5,  5, 14,  5,  5,  5,  9,  9, 14, 14, 14, 14, 14, 14, 14, ~
    14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,  2,  2,  2,  2,  2,  2,  5,  2,  2,  2,  2,  2,  2,  2, 14, 14, 14, 14, 14, 14, 14, 14,  9,  9,  9,  9, 14, ~
    14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,  9,  9,  9,  9, 14, ~
    14, 14, 14, 14, 14, 14, 14,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 14, 14,  9,  9,  9,  9, 14, ~
    14, 14, 14, 14, 14, 14, 14,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 14, 14,  9,  9,  9, 14, 14, ~
    14, 14, 14, 14, 14, 14, 14,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 14, 14, 14, 14, 14, 14, 14, ~
    14, 14, 14, 14, 14, 14, 14,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 14, 14,  2, 10,  2,  2, 10, ~
    14, 14, 14, 14, 14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,  9, 14, 14, ~
    14, 14, 14, 14, 14, 14, 14,  2,  2,  2,  2,  2, 14,  2,  2,  2,  2, 14,  2,  2,  2,  2,  2,  2, 14,  2,  2, 14,  2,  2,  2,  2,  2, 14, 14, 14, 14, 14, 14, 14, ~
    14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14

  data background_end![] = ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,210, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,  3, 15, 14,  7, 18,  1, 20, 21, 12,  1, 20,  9, 15, 14, 19, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32,211, 32, 32, 32, 32, 32,222,  0,226,221,176, 32, 25, 15, 21, 32,  8,  1, 22,  5, 32, 18,  5, 16, 21, 12, 19,  5,  4, 32, 32, 32, 32, 32,227,228,229,231, 32, ~
    32, 32, 32, 32, 32, 32, 32,218,134,159,180, 32, 32,  1, 12, 12, 32, 23,  1, 22,  5, 19, 32, 15,  6, 32, 20,  8,  5, 32, 32, 32, 32, 32, 32,243,244,245,246, 32, ~
    32, 32, 32, 32, 32, 32, 32,215, 32,217, 32,219, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,152,153,154,158, 32, ~
    32, 32, 32, 32, 32, 32, 32,216,232,233,234,235, 32, 27, 29, 31, 34, 35, 37, 32, 39, 41, 43, 45, 27, 58, 39, 32, 32, 32, 32, 32, 32, 32, 32,238,239,254,255, 32, ~
    32, 32, 32, 32, 32, 32, 32,247,248,249,250,251, 32, 28, 30, 33, 34, 36, 38, 32, 40, 42, 44, 46, 47, 59, 40, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32, 32, 32, 32,211, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,211, 32, 32, ~
    32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 211,32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, ~
    32, 32, 32,210, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
     
  data background_end_color![] = ~
    14, 14, 14, 14, 14, 14, 14, 14,  5,  5,  9, 13, 14, 14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 13, 13, 13, 14, 14, 14,  9,  9, 14, 14, 14, 14, ~
    14, 14, 14,  9, 14, 14, 14,  9,  9,  9,  9,  9, 14,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  5,  5,  5,  9,  9,  5,  5, 14, 14, 14, 14, 14, ~
    14,  9, 14, 14,  9, 14, 14,  9,  9,  9,  9,  9, 14,  2,  2,  2,  5,  2,  2,  2,  2,  5,  2,  2,  2,  2,  2,  2,  2,  2,  5, 14,  5, 14, 14,  9,  9,  9,  9, 14, ~
    14, 14, 14, 14, 14, 14, 14,  9,  9,  9,  9,  9, 14,  2,  2,  2,  5,  2,  2,  2,  2,  2,  5,  2,  2,  5,  2,  2,  2,  5,  5,  5, 14, 14, 14,  9,  9,  9,  9, 14, ~
    14, 14, 14, 14, 14, 14, 14,  9,  9,  9,  9,  9,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5, 14, 14,  9,  9,  9,  9, 14, ~
    14, 14, 14, 14, 14, 14, 14,  9,  9,  9,  9,  9,  5,  2,  2,  2,  2,  2,  2, 14,  2,  2,  2,  2,  2,  2,  2,  5,  5,  5,  5,  5,  5, 14, 14,  9,  9,  9, 14, 14, ~
    14, 14, 14, 14, 14, 14, 14,  9,  9,  9,  9,  9,  9,  2,  2,  2,  2,  2,  2,  5,  2,  2,  2,  2,  2,  2,  2,  5,  5,  5,  9,  5,  5,  5, 14, 14, 14, 14, 14, 14, ~
    14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,  9,  9,  9,  9,  9,  9,  9,  9,  9,  9, 14, 14, 14, 14,  9,  9, 14,  9,  9, 14, 14,  2, 10,  2,  2, 10, ~
     2, 14, 14, 14, 14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,  9, 14, 14, ~
    14, 14, 14, 14, 14, 14,  2,  2,  2,  2,  2, 14,  2,  2,  2,  2, 14,  2,  2,  2,  2,  2,  2, 14,  2,  2, 14,  2,  2,  2,  2,  2,  2,  2,  2,  5, 14, 14, 14, 14, ~
    14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,  9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14
     
endproc
