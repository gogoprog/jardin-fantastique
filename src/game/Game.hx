package game;

import js.Lib;
import js.jquery.*;
import js.Browser.document;
import js.Browser.window;
import phaser.Game;
import phaser.Phaser;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.Node;
import whiplash.*;
import whiplash.math.*;
import whiplash.phaser.*;
import whiplash.common.components.Active;

class Game extends Application {
    public function new() {
        var config = {
            render:{
                transparent:false
            },
            scale : {
                mode: phaser.scale.scalemodes.NONE
            },
            backgroundColor:"#2f471f"
        };
        super(Config.screenWidth, Config.screenHeight, ".root", config);
    }

    override function preload():Void {
        super.preload();
        Factory.preload(whiplash.Lib.phaserScene);
    }

    override function create():Void {
        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;
        AudioManager.init(whiplash.Lib.phaserScene);
        Factory.init(whiplash.Lib.phaserScene);

        whiplash.platformer.Lib.init(this);

        var e = Factory.createParallax("bg1", 0.1, 0.5);
        e.get(whiplash.platformer.Parallax).offset.y = 300;
        engine.addEntity(e);
        var e = Factory.createParallax("bg1", 0.5);
        e.get(whiplash.platformer.Parallax).offset.y = 256;
        engine.addEntity(e);

        var e = Factory.createObjectHandler();
        engine.addEntity(e);

        var e = Factory.createLevel(0, true, 10);
        engine.addEntity(e);
        var player = Factory.createPlayer();
        engine.addEntity(player);
        var e = Factory.createLevel(1, false, 10);
        engine.addEntity(e);

        var e = Factory.createCamera();
        engine.addEntity(e);
    }

    static function main():Void {
        new Game();
    }
}
