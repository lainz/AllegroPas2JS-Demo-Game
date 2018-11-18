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

var
 //bitmap objects
 man, apple, bg: TJSObject;

 // munching sound effect
 munch: TJSObject;

 // apple position
 apple_x, apple_y: Float64;

 // player position
 player_x, player_y: Float64;

 // score
 score: Float64;

 // update game logic
 procedure update();
 begin
   // check for keypresses and move the player accordingly
   if key[KEY_UP] then
     player_y -= 4;
   if key[KEY_DOWN] then
     player_y += 4;
   if key[KEY_LEFT] then
     player_x -= 4;
   if key[KEY_RIGHT] then
     player_x += 4;

   // keep inside grass area
   if player_y < 100 then
     player_y := 100;
   if player_x < 0 then
     player_x := 0;
   if player_y > SCREEN_H then
     player_y := SCREEN_H;
   if player_x > SCREEN_W then
     player_x := SCREEN_W;

   // if player is touching the apple...
   if distance(player_x, player_y, apple_x, apple_y) < 20 then
   begin
     // play munching sound
     play_sample(munch);

     // move apple to a new spot, making it look like it's
     // a brand new apple
     apple_x := rand() mod (SCREEN_W-32);
     apple_y := rand() mod (SCREEN_H-32);

     // keep inside grass area
     if apple_y < 100 then
       apple_y := 100;

     // increase score
     score += 1;

     writeln('Apple eaten!');
   end;
 end;

// rendering function
 procedure draw();
 begin
   // draw background
   simple_blit(bg, canvas, 0, 0);

   // draw player
   draw_sprite(canvas, man, player_x, player_y);

   // draw the apple
   draw_sprite(canvas, apple, apple_x, apple_y);

   // print out current score
   textout(canvas,font,'Score: ' + FloatToStr(score),10,30,24,makecol(255,255,255),makecol(0,0,0),1);
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

begin
  apple_x := 200;
  apple_y := 200;
  player_x := 100;
  player_y := 100;

  enable_debug('debug');
  allegro_init_all('canvas_id', 640, 480);
  man := load_bmp('data/man.png');
  apple := load_bmp('data/apple.png');
  bg := load_bmp('data/grass.jpg');
  munch := load_sample('data/munch.mp3');

  ready(@main_loop, nil);
end.
