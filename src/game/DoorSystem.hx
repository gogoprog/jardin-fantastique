package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class DoorNode extends Node<DoorNode> {
    public var transform:Transform;
    public var door:Door;
    public var sprite:Sprite;
}

class DoorSystem extends ListIteratingSystem<DoorNode> {
    private var engine:Engine;
    private var playerNodeList = new NodeList<PlayerNode>();

    public function new() {
        super(DoorNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        playerNodeList = engine.getNodeList(PlayerNode);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    override public function update(time:Float):Void {
        super.update(time);

        for(playerNode in playerNodeList) {
            var player = playerNode.player;

            if(player.tryOpenDoor) {
                player.tryOpenDoor = false;
            }
        }
    }

    private function updateNode(node:DoorNode, dt:Float):Void {
        for(playerNode in playerNodeList) {
            var player = playerNode.player;

            if(player.tryOpenDoor) {
                if(Vector2.getSquareDistance(node.transform.position, playerNode.transform.position) < 64*64) {
                    if(node.sprite.texture.key == "porte") {
                        node.sprite.setTexture("porte2");
                    } else {
                        node.sprite.setTexture("porte");
                    }

                    whiplash.AudioManager.playSound("door");
                    player.tryOpenDoor = false;
                }
            }
        }
    }

    private function onNodeAdded(node:DoorNode) {
    }

    private function onNodeRemoved(node:DoorNode) {
    }
}


