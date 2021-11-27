package game;

import ash.core.Engine;
import whiplash.phaser.Transform;
import whiplash.math.Vector2;
import game.Game;

class LevelLoaderSystem extends ash.core.System {
    var engine:Engine;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        this.engine = engine;
        super.addToEngine(engine);
        engine.removeAllEntities();
        {
            var e = Factory.createParallax("bg1", 0.1, 0.5, 0x333311);
            e.get(whiplash.platformer.Parallax).offset.y = 300;
            engine.addEntity(e);
            var e = Factory.createParallax("bg1", 0.5);
            e.get(whiplash.platformer.Parallax).offset.y = 456;
            engine.addEntity(e);
        }
        {
            createZone();
            Game.instance.addZone(0);
        }
        {
            var player = Factory.createPlayer();
            engine.addEntity(player);
            var e = Factory.createCamera();
            engine.addEntity(e);
        }
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt) {
    }

    private function addPart(level, zone:Zone, offset:Vector2) {
        var tilemap = Factory.createTilemap(level);
        var e = Factory.createLevel(tilemap, 0, true, 10);
        e.get(Transform).position += offset;
        e.add(new LevelPart());
        zone.entities.push(e);
        var e = Factory.createLevel(tilemap, 1, false, 10);
        e.get(Transform).position += offset;
        e.add(new LevelPart());
        zone.entities.push(e);
        var e = Factory.createObjectHandler(tilemap);
        e.get(Transform).position += offset;
        e.add(new LevelPart());
        zone.entities.push(e);
        offset.x += tilemap.width * 64;
    }

    private function createZone() {
        var zone = new Zone();
        var nparts = 3;
        var offset = new Vector2(0, 360);

        addPart('door00', zone, offset);

        for(i in 0 ...10) {
            var r = Std.random(nparts);
            addPart('part0${r}', zone, offset);
        }

        addPart('door00', zone, offset);

        Game.instance.zones.push(zone);
    }
}

