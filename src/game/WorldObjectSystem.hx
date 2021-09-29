package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.platformer.WorldObject;

class WorldObjectNode extends Node<WorldObjectNode> {
    public var transform:Transform;
    public var worldObject:WorldObject;
}

class WorldObjectSystem extends ListIteratingSystem<WorldObjectNode> {
    private var engine:Engine;

    public function new() {
        super(WorldObjectNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:WorldObjectNode, dt:Float):Void {
    }

    private function onNodeAdded(node:WorldObjectNode) {
        var object = node.worldObject.object;
        var props = node.worldObject.props;
        var e = node.entity;

        switch(props.entity) {
            case 'key':
                e.add(new Sprite("keyh"));
                e.add(new Bounce());
                e.add(new whiplash.platformer.Item("key", function(e) { trace("keypick"); }));
                var box = new whiplash.platformer.Box();
                box.size.setTo(32, 32);
                box.offset.setTo(0, 0);
                e.add(box);

            case "coffre":
                e.add(new Sprite("coffre"));
                e.get(Sprite).setDepth(8);

            case "door":
                e.add(new Sprite("porte"));
                e.add(new Door());
                e.get(Sprite).setDepth(8);
        }

        if(e.get(Sprite) != null) {
            e.get(Transform).position.y -= e.get(Sprite).displayHeight / 2;
            e.get(Transform).position.x += e.get(Sprite).displayWidth / 2;
        }
    }

    private function onNodeRemoved(node:WorldObjectNode) {
    }
}


