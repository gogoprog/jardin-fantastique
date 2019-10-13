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
        super(1024, 600, ".root");
    }

    override function preload():Void {
        super.preload();
        Factory.preload(whiplash.Lib.phaserScene);
    }

    override function create():Void {
        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;
        AudioManager.init(whiplash.Lib.phaserScene);
        whiplash.Lib.phaserScene.cameras.main.setBounds(-1000, 0, 2000, 10000);
        // game.physics.startSystem(phaser.Physics.ARCADE);
        // game.time.desiredFps = 60;
        // game.physics.arcade.gravity.y = 800;

        var e = Factory.createLevel();
        engine.addEntity(e);
        var e = Factory.createPlayer();
        engine.addEntity(e);
        var e = Factory.createEnemy();
        e.get(Transform).position.x = 300;
        engine.addEntity(e);

        engine.addSystem(new ControlSystem(), 1);
        engine.addSystem(new FlowerSystem(), 1);

        untyped $global.resizeCanvas();
    }

    static function main():Void {
        new Game();
    }
}
