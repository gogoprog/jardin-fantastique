package game;

import js.jquery.JQuery;
import ash.core.Engine;

class ControlSystem extends whiplash.UiSystem {
    public function new() {
        super();
        set(".spinButton", Game.pressEvent, function() {
            Game.instance.closeSettings();
            spin();
        });
        set(".quickSettingsButton", Game.pressEvent, toggleQuickSettings);
        set(".settingsButton", Game.pressEvent, showSettings);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        Game.instance.canSpin = true;
        new JQuery(".spinButton").css("opacity", 1);
        new JQuery(".spinButton").css("pointer-events", "auto");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
        new JQuery(".spinButton").css("opacity", 0.3);
    }

    public override function update(dt) {
        if(Game.instance.session.spaceBar && whiplash.Input.keys[" "]) {
            spin();
        }
    }

    public function showSettings() {
        new JQuery(".settings").css("visibility", "visible");
        new JQuery(".version").text(util.Version.get());
    }
}

