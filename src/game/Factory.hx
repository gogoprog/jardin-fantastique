package game;

import ash.core.Entity;
import whiplash.phaser.*;
import whiplash.math.*;
import whiplash.platformer.Character;

class Factory {
    static public function preload(scene:phaser.Scene) {
    }

    static public function init(scene:phaser.Scene) {
        scene.anims.create({
            key: 'hero_idle',
            frames: [
            untyped { key: 'hero_idle' },
            untyped { key: 'hero_idle2' },
            ],
            frameRate: 5,
            repeat: -1
        });
        scene.anims.create({
            key: 'hero_punch',
            frames: [
            untyped { key: 'hero_punch' },
            ],
            frameRate: 5,
            repeat: 0
        });
        scene.anims.create({
            key: 'hero_walk',
            frames: [
            untyped { key: 'hero_walk' },
            untyped { key: 'hero_walk2' },
            untyped { key: 'hero_walk3' },
            untyped { key: 'hero_walk4' },
            ],
            frameRate: 10,
            repeat: -1
        });
    }

    static public function createSky() {
        var e = new Entity();
        e.add(new Sprite("sky"));
        e.add(new Transform());
        return e;
    }

    static public function createTilemap(level) {
        var tilemap = whiplash.Lib.phaserScene.add.tilemap(level);
        tilemap.addTilesetImage('../textures/grass.png', 'grass');
        tilemap.addTilesetImage('../textures/ground.png', 'ground');
        tilemap.addTilesetImage('../textures/plainground.png', 'plainground');
        tilemap.addTilesetImage('tiles', 'tiles');
        return tilemap;
    }

    static public function createLevel(tilemap:phaser.tilemaps.Tilemap, layer, collision:Bool, depth:Int) {
        var e = new Entity();
        e.add(new TilemapLayer(tilemap, layer, tilemap.tilesets));
        e.get(TilemapLayer).setDepth(depth);
        e.add(new Transform());

        if(collision) {
            e.add(new whiplash.platformer.WorldCollision());
        }

        return e;
    }

    static public function createObjectHandler(tilemap) {
        var e = new Entity();
        e.add(new Transform());
        e.add(new whiplash.platformer.WorldObjectHandler(tilemap.objects, 1024));
        return e;
    }

    static public function createPlayer() {
        var e = new Entity();
        e.name = "player";
        var sprite = new Sprite("hero_idle");
        sprite.setDepth(9);
        e.add(sprite);
        e.add(new Transform());
        e.get(Transform).position.y = 100;
        e.get(Transform).position.x = 300;
        e.get(Transform).scale.setTo(0.3, 0.3);
        e.add(new whiplash.platformer.Input());
        e.get(whiplash.platformer.Input).keyActionMap.set("Shift", "punch");
        e.get(whiplash.platformer.Input).keyActionMap.set("Enter", "open");
        var character = new whiplash.platformer.Character();
        e.add(character);
        character.jumpSpeed = -600;
        character.maximumSpeed = 350;
        character.onAction = function(action, entity) {
            trace("Action:");
            trace(action);
        };
        var box = new whiplash.platformer.Box();
        box.size.setTo(100, 378);
        box.offset.setTo(115, 80);
        e.add(box);
        e.add(new whiplash.platformer.CameraTarget());
        var anims = e.get(whiplash.platformer.Character).animations;
        anims[Idle] = "hero_idle";
        anims[Walk] = "hero_walk";
        anims[Action("punch")] = "hero_punch";
        anims[Action("open")] = "hero_punch";
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
        e.name = "camera";
        e.add(new Transform());
        e.add(new Camera(0, 0, Config.screenWidth, Config.screenHeight));
        e.add(new whiplash.platformer.Camera());
        e.get(Camera).setBackgroundColor("#2f471f");
        e.get(whiplash.platformer.Camera).maxY = 464;
        return e;
    }

    static public function createParallax(texture, factor, scale = 1.0, tint = 0x668822) {
        var e = new Entity();
        e.add(new TileSprite(Std.int(1280 / scale), 512, texture));
        e.add(new whiplash.platformer.Parallax(factor));
        e.add(new Transform());
        e.get(Transform).position.x = -2;
        e.get(TileSprite).tint = tint;
        e.get(Transform).scale.setTo(scale, scale);
        return e;
    }
}
