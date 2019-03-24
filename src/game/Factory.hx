package game;

import ash.core.Entity;
import whiplash.phaser.*;

class Factory {
    static public var tileMap:phaser.Tilemap;

    static public function preload(game:phaser.Game) {
        game.load.image("grass", "../data/textures/grass.png");
        // game.load.image("sky", "../data/textures/blue-sky.png");
        // game.load.tilemap("level", cast "../data/tilemaps/level.json", cast null, cast phaser.Tilemap.TILED_JSON);
        // game.load.atlas('mario-sprites', '../data/textures/mario-sprites.png', '../data/textures/mario-sprites.json');
        game.load.spritesheet('guy', '../data/textures/guy.png', 400, 300, 2, 0, 0);
        // game.load.bitmapFont('font', '../data/fonts/font.png', '../data/fonts/font.fnt');
    }

    static public function init(game:phaser.Game) {
        // tileMap = game.add.tilemap('level');
        // tileMap.addTilesetImage('super-mario', 'super-mario');
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
        whiplash.Lib.phaserGame.camera.follow(sprite);
        return e;
    }

    static public function createBitmapText(text) {
        var bt = new BitmapText("font", text.toUpperCase(), 12);
        bt.anchor.set(-0.2, -0.2);
        bt.smoothed = false;
        return bt;
    }
    static public function createLetterBlock(letter) {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("level-sheet", 43));
        e.add(new Block());
        e.add(createBitmapText(letter));
        var sprite = e.get(Sprite);
        whiplash.Lib.phaserGame.physics.enable(sprite, phaser.Physics.ARCADE);
        untyped sprite.body.setSize(Config.blockSize, Config.blockSize);
        untyped sprite.body.immovable = true;
        untyped sprite.body.moves = false;
        return e;
    }

    static public function createQuestionBlock(letter) {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("level-sheet", 13));
        var sprite = e.get(Sprite);
        sprite.animations.add("idle", [13.0, 40.0, 41.0, 42.0]);
        sprite.animations.add("block", [43.0]);
        sprite.animations.play('idle', 5, true);
        e.add(new QuestionBlock(createBitmapText(letter)));
        var sprite = e.get(Sprite);
        whiplash.Lib.phaserGame.physics.enable(sprite, phaser.Physics.ARCADE);
        untyped sprite.body.setSize(Config.blockSize, Config.blockSize);
        untyped sprite.body.immovable = true;
        untyped sprite.body.moves = false;
        return e;
    }

    static public function createBlocks(input:String) {
        var result = new Array<Entity>();
        var lines = input.split("\n");
        var i = lines.length - 1;
        while(i >= 0) {
            var p = lines.length - i - 1;
            var x = Config.firstCol * Config.blockSize;
            var y = (Config.height - Config.firstRow) * Config.blockSize - p * Config.lineSpacing * Config.blockSize;
            var advance = 0;
            var isHidden = false;
            for(c in 0...lines[i].length) {
                var char = lines[i].charAt(c);
                switch(char) {
                    case '[':
                        isHidden = true;
                    case ']':
                        isHidden = false;
                    case ' ':
                        advance++;
                    default:
                        var e:Entity;
                        e = isHidden ? createQuestionBlock(char) : createLetterBlock(char);
                        e.get(Transform).position.set(x + advance * Config.blockSize, y);
                        result.push(e);
                        advance++;
                }
            }
            --i;
        }
        return result;
    }
}
