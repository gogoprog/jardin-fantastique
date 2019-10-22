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

    static public function createLevel() {
        var e = new Entity();
        e.add(new Sprite("grass"));
        e.add(new Transform());
        e.get(Transform).position.y = 400;
        e.get(Transform).position.x = 0;
        e.get(Transform).scale = new Point(1, 1);
        e.get(Sprite).setOrigin(0);
        return e;
    }

    static public function createPlayer() {
        var e = new Entity();
        e.name = "player";
        var sprite = new Sprite("hero_win");
        e.add(sprite);
        sprite.setOrigin(0.5, 0.5);
        e.add(new Transform());
        e.get(Transform).position.y = 100;
        e.get(Transform).position.x = 100;
        // sprite.animations.add("idle", untyped [0]);
        // sprite.animations.add("walk", untyped [0, 1]);
        // sprite.animations.add("jump", untyped [0, 1]);
        // sprite.animations.play('walk', 5, true);
        var sprite = e.get(Sprite);
        whiplash.Lib.phaserScene.physics.add.existing(sprite);
        untyped sprite.body.collideWorldBounds = true;
        sprite.body.setSize(8, 15);
        sprite.body.setGravity(0, 300);
        sprite.body.setAllowGravity(true);
        return e;
    }

    static public function createEnemy() {
        var e = new Entity();
        var sprite = new Sprite("guy");
        e.add(sprite);
        sprite.setOrigin(0.5, 0.5);
        e.add(new Transform());
        e.get(Transform).position.y = 100;
        e.get(Transform).position.x = 300;
        // sprite.animations.add("idle", untyped [0]);
        // sprite.animations.add("walk", untyped [0, 1]);
        // sprite.animations.add("jump", untyped [0, 1]);
        // sprite.animations.play('walk', 5, true);
        var sprite = e.get(Sprite);
        whiplash.Lib.phaserScene.physics.add.existing(sprite);
        untyped sprite.body.collideWorldBounds = true;
        untyped sprite.body.setSize(8, 15);
        untyped sprite.body.offset.setTo(4, 0);
        untyped sprite.body.x = 500;
        return e;
    }

    static public function createFlower() {
        var e = new Entity();
        e.add(new Sprite("flower"));
        e.add(new Transform());
        e.add(new Flower());
        return e;
    }

    static public function createCamera() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Camera(0, 0, Config.screenWidth, Config.screenHeight));
        return e;
    }
}
