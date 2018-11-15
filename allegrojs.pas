unit allegrojs;

{
  ALLEGRO.JS.PAS v0.1 by Lainz
  LGPL V3

  v0.1
  - Added minimum stuff needed to run the demo game
}

{$mode objfpc}
{$modeswitch externalclass}

interface

uses
  JS, Classes, SysUtils;

type
  TLoadingBarCallback = procedure (progress: double);

{ CONFIGURATION ROUTINES }
procedure install_allegro(); external name 'install_allegro';
procedure allegro_init(); external name 'allegro_init';
procedure allegro_init_all(id: string; w: Float64; h: Float64; menu: boolean = false); external name 'allegro_init_all';

{ DEBUG FUNCTIONS }
procedure enable_debug(id: string); external name 'enable_debug';

{ BITMAP OBJECTS }
function load_bmp(filename: string): TJSObject; external name 'load_bmp';

{ SOUND ROUTINES }
function load_sample(filename: string): TJSObject; external name 'load_sample';
procedure play_sample(sample: TJSObject; vol: Float64 = 1; freq: Float64 = 1; loop: boolean = False); external name 'play_sample';

{ TIMER ROUTINES }
function BPS_TO_TIMER(bps: Float64): Float64; external name 'BPS_TO_TIMER';
procedure loop(proc: TProcedure; speed: Float64); external name 'loop';
procedure ready(proc: TProcedure; bar: TLoadingBarCallback); external name 'ready';

{ BLITTING AND SPRITES }
procedure draw_sprite(target: TJSObject; sprite: TJSObject; x, y: Float64); external name 'draw_sprite';
procedure simple_blit(source: TJSObject; dest: TJSObject; x, y: Float64); external name 'simple_blit';

{ TEXT OUTPUT }
procedure textout(bitmap: TJSObject; f: TJSObject; s: string; x, w, size: Float64; colour: Float64; outline: Float64 = 0; width: Float64 = 0); external name 'textout';

{ DRAWING PRIMITIVES }
function makecol(r, g, b: Float64; a: Float64 = 255): Float64; external name 'makecol';

{ HELPER MATH FUNCTIONS }
function rand(): integer; external name 'rand';
function distance(x1, y1, x2, y2: Float64): Float64; external name 'distance';

var
  canvas: TJSObject; external name 'canvas';
  SCREEN_W: integer; external name 'SCREEN_W';
  SCREEN_H: integer; external name 'SCREEN_H';
  font: TJSObject; external name 'font';
  key: TJSArray; external name 'key';
  KEY_A: integer; external name 'KEY_A';
  KEY_B: integer; external name 'KEY_B';
  KEY_C: integer; external name 'KEY_C';
  KEY_D: integer; external name 'KEY_D';
  KEY_E: integer; external name 'KEY_E';
  KEY_F: integer; external name 'KEY_F';
  KEY_G: integer; external name 'KEY_G';
  KEY_H: integer; external name 'KEY_H';
  KEY_I: integer; external name 'KEY_I';
  KEY_J: integer; external name 'KEY_J';
  KEY_K: integer; external name 'KEY_K';
  KEY_L: integer; external name 'KEY_L';
  KEY_M: integer; external name 'KEY_M';
  KEY_N: integer; external name 'KEY_N';
  KEY_O: integer; external name 'KEY_O';
  KEY_P: integer; external name 'KEY_P';
  KEY_Q: integer; external name 'KEY_Q';
  KEY_R: integer; external name 'KEY_R';
  KEY_S: integer; external name 'KEY_S';
  KEY_T: integer; external name 'KEY_T';
  KEY_U: integer; external name 'KEY_U';
  KEY_V: integer; external name 'KEY_V';
  KEY_W: integer; external name 'KEY_W';
  KEY_X: integer; external name 'KEY_X';
  KEY_Y: integer; external name 'KEY_Y';
  KEY_Z: integer; external name 'KEY_Z';
  KEY_0: integer; external name 'KEY_0';
  KEY_1: integer; external name 'KEY_1';
  KEY_2: integer; external name 'KEY_2';
  KEY_3: integer; external name 'KEY_3';
  KEY_4: integer; external name 'KEY_4';
  KEY_5: integer; external name 'KEY_5';
  KEY_6: integer; external name 'KEY_6';
  KEY_7: integer; external name 'KEY_7';
  KEY_8: integer; external name 'KEY_8';
  KEY_9: integer; external name 'KEY_9';
  KEY_0_PAD: integer; external name 'KEY_0_PAD';
  KEY_1_PAD: integer; external name 'KEY_1_PAD';
  KEY_2_PAD: integer; external name 'KEY_2_PAD';
  KEY_3_PAD: integer; external name 'KEY_3_PAD';
  KEY_4_PAD: integer; external name 'KEY_4_PAD';
  KEY_5_PAD: integer; external name 'KEY_5_PAD';
  KEY_6_PAD: integer; external name 'KEY_6_PAD';
  KEY_7_PAD: integer; external name 'KEY_7_PAD';
  KEY_8_PAD: integer; external name 'KEY_8_PAD';
  KEY_9_PAD: integer; external name 'KEY_9_PAD';
  KEY_F1: integer; external name 'KEY_F1';
  KEY_F2: integer; external name 'KEY_F2';
  KEY_F3: integer; external name 'KEY_F3';
  KEY_F4: integer; external name 'KEY_F4';
  KEY_F5: integer; external name 'KEY_F5';
  KEY_F6: integer; external name 'KEY_F6';
  KEY_F7: integer; external name 'KEY_F7';
  KEY_F8: integer; external name 'KEY_F8';
  KEY_F9: integer; external name 'KEY_F9';
  KEY_F10: integer; external name 'KEY_F10';
  KEY_F11: integer; external name 'KEY_F11';
  KEY_F12: integer; external name 'KEY_F12';
  KEY_ESC: integer; external name 'KEY_ESC';
  KEY_TILDE: integer; external name 'KEY_TILDE';
  KEY_MINUS: integer; external name 'KEY_MINUS';
  KEY_EQUALS: integer; external name 'KEY_EQUALS';
  KEY_BACKSPACE: integer; external name 'KEY_BACKSPACE';
  KEY_TAB: integer; external name 'KEY_TAB';
  KEY_OPENBRACE: integer; external name 'KEY_OPENBRACE';
  KEY_CLOSEBRACE: integer; external name 'KEY_CLOSEBRACE';
  KEY_ENTER: integer; external name 'KEY_ENTER';
  KEY_COLON: integer; external name 'KEY_COLON';
  KEY_QUOTE: integer; external name 'KEY_QUOTE';
  KEY_BACKSLASH: integer; external name 'KEY_BACKSLASH';
  KEY_COMMA: integer; external name 'KEY_COMMA';
  KEY_STOP: integer; external name 'KEY_STOP';
  KEY_SLASH: integer; external name 'KEY_SLASH';
  KEY_SPACE: integer; external name 'KEY_SPACE';
  KEY_INSERT: integer; external name 'KEY_INSERT';
  KEY_DEL: integer; external name 'KEY_DEL';
  KEY_HOME: integer; external name 'KEY_HOME';
  KEY_END: integer; external name 'KEY_END';
  KEY_PGUP: integer; external name 'KEY_PGUP';
  KEY_PGDN: integer; external name 'KEY_PGDN';
  KEY_LEFT: integer; external name 'KEY_LEFT';
  KEY_RIGHT: integer; external name 'KEY_RIGHT';
  KEY_UP: integer; external name 'KEY_UP';
  KEY_DOWN: integer; external name 'KEY_DOWN';
  KEY_SLASH_PAD: integer; external name 'KEY_SLASH_PAD';
  KEY_ASTERISK: integer; external name 'KEY_ASTERISK';
  KEY_MINUS_PAD: integer; external name 'KEY_MINUS_PAD';
  KEY_PLUS_PAD: integer; external name 'KEY_PLUS_PAD';
  KEY_DEL_PAD: integer; external name 'KEY_DEL_PAD';
  KEY_ENTER_PAD: integer; external name 'ENTER_PAD';
  KEY_PRTSCR: integer; external name 'KEY_PRTSCR';
  KEY_PAUSE: integer; external name 'KEY_PAUSE';
  KEY_LSHIFT: integer; external name 'KEY_LSHIFT';
  KEY_RSHIFT: integer; external name 'KEY_RSHIFT';
  KEY_LCONTROL: integer; external name 'KEY_LCONTROL';
  KEY_RCONTROL: integer; external name 'KEY_RCONTROL';
  KEY_ALT: integer; external name 'KEY_ALT';
  KEY_ALTGR: integer; external name 'KEY_ALTGR';
  KEY_LWIN: integer; external name 'KEY_LWIN';
  KEY_RWIN: integer; external name 'KEY_RWIN';
  KEY_MENU: integer; external name 'KEY_MENU';
  KEY_SCRLOCK: integer; external name 'KEY_SCRLOCK';
  KEY_NUMLOCK: integer; external name 'KEY_NUMLOCK';
  KEY_CAPSLOCK: integer; external name 'KEY_CAPSLOCK';
  KEY_EQUALS_PAD: integer; external name 'KEY_EQUALS_PAD';
  KEY_BACKQUOTE: integer; external name 'KEY_BACKQUOTE';
  KEY_SEMICOLON: integer; external name 'KEY_SEMICOLON';
  KEY_COMMAND: integer; external name 'KEY_COMMAND';

implementation

end.

