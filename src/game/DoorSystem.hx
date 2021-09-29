package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class DoorNode extends Node<DoorNode> {
    public var transform:Transform;
    public var door:Door;
}

class DoorSystem extends ListIteratingSystem<DoorNode> {
    private var engine:Engine;

    public function new() {
        super(DoorNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:DoorNode, dt:Float):Void {
    }

    private function onNodeAdded(node:DoorNode) {
    }

    private function onNodeRemoved(node:DoorNode) {
    }
}


