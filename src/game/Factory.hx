package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public function preload(scene:phaser.Scene) {
        scene.load.spritesheet('guy', '../data/spritesheets/guy.png', { frameWidth: 400, frameHeight: 300, startFrame:0, endFrame:2 });
    }

    static public function init(scene:phaser.Scene) {
    }

    static public function createSky() {
        var e = new Entity();
        e.add(new Sprite("sky"));
        e.add(new Transform());
        return e;
    }

    static public function createLevel(layer, collision:Bool) {
        var tilemap:phaser.tilemaps.Tilemap;
        tilemap = whiplash.Lib.phaserScene.add.tilemap('level');
        tilemap.addTilesetImage('../textures/grass.png', 'grass');
        tilemap.addTilesetImage('../textures/ground.png', 'ground');
        var e = new Entity();
        e.add(new TilemapLayer(tilemap, layer, tilemap.tilesets));
        e.add(new Transform());
        e.get(Transform).position.y = 360;

        if(collision) {
            e.add(new whiplash.platformer.WorldCollision());
        }
        return e;
    }

    static public function createPlayer() {
        var e = new Entity();
        e.name = "player";
        var sprite = new Sprite("hero_idle");
        e.add(sprite);
        e.add(new Transform());
        e.get(Transform).position.y = 100;
        e.get(Transform).position.x = 300;
        e.get(Transform).scale.setTo(0.3, 0.4);
        e.add(new whiplash.platformer.Input());
        e.add(new whiplash.platformer.Character());
        e.get(whiplash.platformer.Character).size.setTo(100, 360);
        e.get(whiplash.platformer.Character).offset.setTo(115, 80);

        e.add(new whiplash.platformer.CameraTarget());

        return e;
    }

    static public function createSprite(which) {
        var e = new Entity();
        e.add(new Sprite("none"));
        e.add(new Transform());
        return e;
    }

    static public function createCamera() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Camera(0, 0, Config.screenWidth, Config.screenHeight));
        e.add(new whiplash.platformer.Camera());
        return e;
    }
}
