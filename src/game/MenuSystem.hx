package game;

import js.jquery.JQuery;
import ash.core.Engine;
import whiplash.phaser.*;

class MenuSystem extends whiplash.UiSystem {
    private var engine:Engine;

    public function new() {
        super();
        set(".menu .play", "click", function() {
            Game.instance.changeState("ingame");
            Game.instance.changeUiState("hud");
        });
    }

    public override function addToEngine(engine:Engine) {
        this.engine = engine;
        super.addToEngine(engine);
        engine.removeAllEntities();
        var e = Factory.createParallax("bg1", 0.2, 0.8, 0x222211);
        e.get(whiplash.platformer.Parallax).offset.y = 300;
        engine.addEntity(e);
        var e = Factory.createParallax("bg1", 0.3, 1.1, 0x333311);
        e.get(whiplash.platformer.Parallax).offset.y = 300;
        engine.addEntity(e);
        var e = Factory.createParallax("bg1", 0.5, 1.8);
        e.get(whiplash.platformer.Parallax).offset.y = 256;
        engine.addEntity(e);
        var e = Factory.createCamera();
        engine.addEntity(e);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        var e = engine.getEntityByName("camera");
        e.get(Transform).position.x += 100 * dt;
    }
}

