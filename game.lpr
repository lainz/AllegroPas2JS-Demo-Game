program game;

{
  ALLEGRO.JS.PAS demo game v0.1 by Lainz
  Based on the original demo of ALLEGRO.JS
  LGPL V3

  v0.2
  - Changed 'loop' with 'requestAnimationFrame', it runs better
  v0.1
  - Demo working, added a ground checking area, to prevent player go to sky, or
  outside the game area
}

{$mode objfpc}
{$modeswitch externalclass}

uses
  JS, Classes, SysUtils, Web, allegrojs;

type

  TRect = record
    x, y, width, height: double;
  end;

  { TResource }

  TResource = class(TJSObject)
  private
    FData: TJSObject; external name 'data';
    Fheight: integer; external name 'height';
    Fsource: string; external name 'source';
    Fwidth: integer; external name 'width';
    public
      property width: integer read Fwidth;
      property height: integer read Fheight;
      property source: string read Fsource;
      property data: TJSObject read FData write FData;
  end;

  TResourceArray = array of TResource;

  { TSprite }

  TSprite = class(TJSObject)
  private
    Findex: integer; external name 'index';
    Fx: integer; external name 'x';
    Fy: integer; external name 'y';
    public
      property x: integer read Fx;
      property y: integer read Fy;
      property index: integer read Findex write Findex;
  end;

  TSpriteArray = array of TSprite;

  { TLevel }

  TLevel = class (TJSObject)
  private
    FResources: TResourceArray; external name 'resources';
    Fsprites: TSpriteArray; external name 'sprites';
  public
    property sprites: TSpriteArray read Fsprites;
    property resources: TResourceArray read FResources;
  end;

function request(filename: string): TJSPromise; external name 'request';

var
 //bitmap objects
 man, man_jump, bg, bgm: TJSObject;

 // munching sound effect
 munch: TJSObject;

 // player position
 player_x, player_y, player_spd, player_spdy: Float64;
 last_left: boolean;
 last_right: boolean;
 last_collision_time: integer;

 // score
 score: Float64;

 level1: TLevel;
 level1p: TJSPromise;

 function rect(x, y, w, h: Double): TRect;
 begin
   Result.x := x;
   Result.y := y;
   Result.width := w;
   Result.height := h;
 end;

 function collision(rect1, rect2: TRect): boolean;
 begin
   result := (rect1.x < rect2.x + rect2.width) and
   (rect1.x + rect1.width > rect2.x) and
   (rect1.y < rect2.y + rect2.height) and
   (rect1.height + rect1.y > rect2.y);
 end;

 // update game logic
 procedure update();
 var
  i: integer;
  new_y: integer;
 begin
   player_spd -= 0.05;
   last_collision_time += 1;

   if player_spd > 4 then
     player_spd := 4;
   if player_spd < 0 then
     player_spd := 0;

   player_y += 4;
   // check for keypresses and move the player accordingly
   if boolean(key[KEY_W]) or boolean(key[KEY_UP]) then
   begin
     if last_collision_time < 20 then
       player_y -= 12;
   end;
   if boolean(key[KEY_D]) or boolean(key[KEY_RIGHT])then
   begin
     if last_left then
       player_spd -= 1;
     player_spd += 0.1;
     player_x += player_spd;
     last_right := true;
     last_left := false;
   end
   else if boolean(key[KEY_A]) or boolean(key[KEY_LEFT])then
   begin
     if last_right then
       player_spd -= 1;
     player_spd += 0.1;
     player_x -= player_spd;
     last_left := true;
     last_right := false;
   end
   else
   begin
     if (player_spd > 0) then
     begin
       if last_left then
         player_x -= player_spd;
       if last_right then
         player_x += player_spd;
     end;
   end;

   for i:=0 to Length(level1.sprites)-1 do
   begin
     if collision(Rect(player_x, player_y, 32, 32), Rect(level1.sprites[i].x * 32, level1.sprites[i].y * 32, 32, 32)) then
     begin
       last_collision_time := 0;

       player_y := (level1.sprites[i].y*32)-32;
       level1.sprites[i].Index := 1;
     end;
   end;

   if player_x < 0 then
     player_x := 0;
   if player_y < 0 then
     player_y := 0;
   if player_x + 32 > SCREEN_W then
     player_x := SCREEN_W-32;
   if player_y + 32 > SCREEN_H then
     player_y := SCREEN_H-32;
 end;

// rendering function
 procedure draw();
 var
   i: integer;
 begin
   // draw background
   simple_blit(bg, canvas, 0, 0);

   // print out current score
   textout(canvas,font,'Score: ' + FloatToStr(score),10,30,24,makecol(255,255,255),makecol(0,0,0),1);

   score := 0;
   for i:=0 to Length(level1.sprites)-1 do
   begin
     simple_blit(level1.resources[level1.sprites[i].index].data, canvas, level1.sprites[i].x * 32, level1.sprites[i].y * 32);
     if level1.sprites[i].index = 1 then
       score += 1;
   end;

   // draw player
   if last_collision_time > 0 then
     simple_blit(man_jump, canvas, player_x, player_y)
   else
     simple_blit(man, canvas, player_x, player_y);
 end;

 procedure main_game(aTime: TJSDOMHighResTimeStamp);
 begin
   update();
   draw();
   Window.requestAnimationFrame(@main_game);
 end;

 procedure main_loop();
 begin
   Window.requestAnimationFrame(@main_game);
 end;

procedure loadResources(level: TLevel);
var
  i: integer;
begin
  for i:=0 to length(level.resources)-1 do
  begin
    level.resources[i].data := load_bmp(level.resources[i].source);
  end;
end;

 function OnLoadLevel(data: JSValue): JSValue;
 begin
   level1 := TLevel(data);
   loadResources(level1);
   console.log(level1);

   play_sample(bgm, 1, 1, True);
 end;

begin
  player_x := 100;
  player_y := 100;

  enable_debug('debug');
  allegro_init_all('canvas_id', 640, 480);
  man := load_bmp('data/man.png');
  man_jump := load_bmp('data/jump.png');
  bg := load_bmp('data/bg.png');
  munch := load_sample('data/munch.mp3');
  bgm := load_sample('data/bgm.wav');

  level1p := request('data/level1.json');

  level1p._then(@OnLoadLevel);

  ready(@main_loop, nil);
end.
