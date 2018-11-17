var apple, grass, man, munch, score = 0;

init_pixi(640,480,true,false,1);
load_image(["data/apple.png", "data/grass.jpg", "data/man.png"], setup)

function loop() {
    if (key[KEY_UP]) man.y-=4;
	if (key[KEY_DOWN]) man.y+=4;
	if (key[KEY_LEFT]) man.x-=4;
    if (key[KEY_RIGHT]) man.x+=4;

    // if player is touching the apple...
	if (distance(man.x,man.y,apple.x,apple.y)<20)
	{
		// play muching sound
		play_sample(munch);
		
		// move apple to a new spot, making it look like it's
		// a breand new apple
		apple.x = rand()%(640-32);
		apple.y = rand()%(480-32);
		
		// increase score
		score++;
		
		// log success to console
		log("Apple eaten!");
	}

    requestAnimationFrame(loop);
}

function setup() {
  apple = create_sprite("data/apple.png");
  grass = create_sprite("data/grass.jpg");
  man = create_sprite("data/man.png");
  munch = load_sample("data/munch.mp3");


  add_sprite(grass);
  add_sprite(man);
  move_sprite(man, 100, 100);
  add_sprite(apple);
  move_sprite(apple, 200, 200)

  requestAnimationFrame(loop);

  install_keyboard();
  install_sound();
}