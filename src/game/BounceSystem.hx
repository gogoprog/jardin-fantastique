package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class BounceNode extends Node<BounceNode> {
    public var transform:Transform;
    public var bounce:Bounce;
}

class BounceSystem extends ListIteratingSystem<BounceNode> {
    private var engine:Engine;

    public function new() {
        super(BounceNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:BounceNode, dt:Float):Void {
        var bounce = node.bounce;
        var scale = node.transform.scale;
        var speed:Float = 10;

        bounce.time += dt;

        var s = 0.8 + Math.sin(bounce.time * speed) * 0.1;

        scale.setTo(s, s);
    }

    private function onNodeAdded(node:BounceNode) {
    }

    private function onNodeRemoved(node:BounceNode) {
    }
}


