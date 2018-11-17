var app;

function init_pixi(width, height, antialias, transparent, resolution) {
    let type = "WebGL"
    if (!PIXI.utils.isWebGLSupported()) {
        type = "canvas"
    }

    PIXI.utils.sayHello(type)

    //Create a Pixi Application
    app = new PIXI.Application({ width: width, height: height, antialias: antialias, transparent: transparent, resolution: resolution });

    //Add the canvas that Pixi automatically created for you to the HTML document
    document.body.appendChild(app.view);
}

function load_image(image, onload) {
    PIXI.loader.add(image).load(onload);
}

function create_sprite(image) {
    return new PIXI.Sprite(PIXI.loader.resources[image].texture)
}

function add_sprite(sprite) {
    app.stage.addChild(sprite);
}

function remove_sprite(sprite) {
    app.stage.removeChild(sprite);
}

function hide_sprite(sprite) {
    sprite.visible = false;
}

function move_sprite(sprite, x, y) {
    sprite.position.set(x, y)
}