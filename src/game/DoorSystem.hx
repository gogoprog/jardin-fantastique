package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class DoorNode extends Node<DoorNode> {
    public var transform:Transform;
    public var door:Door;
    public var sprite:Sprite;
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

        if(Game.instance.tryOpenDoor) {
            if(node.sprite.texture.key == "porte") {
                node.sprite.setTexture("porte2");
            } else {
                node.sprite.setTexture("porte");
            }

            whiplash.AudioManager.playSound("door");
            Game.instance.tryOpenDoor = false;
        }
    }

    private function onNodeAdded(node:DoorNode) {
    }

    private function onNodeRemoved(node:DoorNode) {
    }
}


