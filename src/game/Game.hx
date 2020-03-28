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
        super(Config.screenWidth, Config.screenHeight, ".root", phaser.scale.scalemodes.NONE);
    }

    override function preload():Void {
        super.preload();
        Factory.preload(whiplash.Lib.phaserScene);
    }

    override function create():Void {
        Factory.init(whiplash.Lib.phaserScene);
        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;
        AudioManager.init(whiplash.Lib.phaserScene);

        whiplash.platformer.Lib.init(this);

        var e = Factory.createParallax("bg1", 0);
        engine.addEntity(e);

        var e = Factory.createLevel(0, true);
        engine.addEntity(e);
        var e = Factory.createLevel(1, false);
        engine.addEntity(e);
        var player = Factory.createPlayer();
        engine.addEntity(player);

        // var cameraTarget = Factory.createSprite("none");
        // cameraTarget.get(Transform).position.setTo(300, 300);
        // engine.addEntity(cameraTarget);

        // engine.addSystem(new ControlSystem(), 1);
        // engine.addSystem(new FlowerSystem(), 1);

        var e = Factory.createCamera();
        engine.addEntity(e);
    }

    static function main():Void {
        new Game();
    }
}
