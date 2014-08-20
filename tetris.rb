$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'active_support'
require 'ncursesw'
require 'tetris-core'

scr = Ncurses.initscr
Ncurses.cbreak
Ncurses.noecho
scr.keypad true
#Ncurses.start_color
#Ncurses.init_pair(1, Ncurses::COLOR_CYAN, Ncurses::COLOR_BLACK)

begin
  window = Ncurses.newwin 24, 24, 1, 1
  window.mvvline 0, 0,  '<'.ord, 21
  window.mvvline 0, 1,  '!'.ord, 21
  window.mvvline 0, 22, '!'.ord, 21
  window.mvvline 0, 23, '>'.ord, 21
  window.mvhline 20, 2, '='.ord, 20
  window.wrefresh

  sleep 60
ensure
  Ncurses.echo
  Ncurses.endwin
end
