package game;

import ash.core.Engine;

class LevelLoaderSystem extends ash.core.System {
    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        engine.removeAllEntities();
        var e = Factory.createParallax("bg1", 0.1, 0.5, 0x446611);
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

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
    }
}

