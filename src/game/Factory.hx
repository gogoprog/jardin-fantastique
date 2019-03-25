package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static public var tileMap:phaser.Tilemap;

    static public function preload(game:phaser.Game) {
        game.load.image("grass", "../data/textures/grass.png");
        game.load.spritesheet('guy', '../data/textures/guy.png', 400, 300, 2, 0, 0);
    }

    static public function init(game:phaser.Game) {
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
        e.get(Transform).scale = new Point(1.1, 1);
        return e;
    }

    static public function createPlayer() {
        var e = new Entity();
        e.name = "player";
        var sprite = new Sprite("guy");
        e.add(sprite);
        sprite.anchor.set(0.5, 0.5);
        e.add(new Transform());
        e.get(Transform).position.y = 100;
        e.get(Transform).position.x = 100;
        sprite.animations.add("idle", untyped [0]);
        sprite.animations.add("walk", untyped [0, 1]);
        sprite.animations.add("jump", untyped [0, 1]);
        sprite.animations.play('walk', 5, true);
        var sprite = e.get(Sprite);
        whiplash.Lib.phaserGame.physics.enable(sprite, phaser.Physics.ARCADE);
        untyped sprite.body.collideWorldBounds = true;
        untyped sprite.body.setSize(8, 15);
        untyped sprite.body.offset.setTo(4, 0);
        return e;
    }

    static public function createFlower() {
        var e = new Entity();
        e.add(new Sprite("flower"));
        e.add(new Transform());
        e.add(new Flower());
        return e;
    }
}
