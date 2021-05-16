package game;

import js.jquery.JQuery;
import ash.core.Engine;
import whiplash.phaser.*;

class FadeSystem extends whiplash.UiSystem {
    static public var instance:FadeSystem;
    private var engine:Engine;
    private var callback:Void->Void;

    public function new() {
        super();
        instance = this;
    }

    public override function addToEngine(engine:Engine) {
        this.engine = engine;
        super.addToEngine(engine);
        Game.instance.changeUiState("black");
        Game.instance.delay(function() {callback(); }, 2);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
    }

    public function setCallback(callback) {
        this.callback = callback;
    }
}

