package game;

import ash.core.*;
import whiplash.phaser.*;

class BlockNode extends Node<BlockNode> {
    public var sprite:Sprite;
    public var block:Block;
}

class ControlSystem extends ash.core.System {
    private var playerEntity:Entity;
    private var playerSprite:Sprite;
    private var phaserGame:phaser.Game;
    private var blockSprites:Array<Sprite> = [];
    private var mouseEnabled:Bool = true;
    private var canJump:Bool = false;
    private var wasNotPressed:Bool = false;
    private var jumping:Bool = false;
    private var jumpTime:Float = 0;
    private var lastMx:Float = 100;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        playerEntity = engine.getEntityByName("player");
        playerSprite = playerEntity.get(Sprite);
        phaserGame = whiplash.Lib.phaserGame;
        var list = engine.getNodeList(BlockNode);

        for(node in list) {
            blockSprites.push(node.sprite);
            untyped node.sprite.entity = node.entity;
        }

        untyped playerSprite.body.onWorldBounds = untyped __js__("new Phaser.Signal()");
        untyped playerSprite.body.onWorldBounds.add(hitWorldBounds, this);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        phaserGame.physics.arcade.collide(playerSprite, blockSprites, onCollide);

        if(whiplash.Input.keys[" "]) {
            untyped playerSprite.body.velocity.y = -500;
        }

        if(whiplash.Input.keys["ArrowRight"]) {
            untyped playerSprite.body.velocity.x = 200;
        }

        if(whiplash.Input.keys["ArrowLeft"]) {
            untyped playerSprite.body.velocity.x = -200;
        }

        untyped playerSprite.body.velocity.x /= 1.1;
        var vx = untyped playerSprite.body.velocity.x;

        if(vx > 5 || vx < -5) {
            playerEntity.get(Transform).scale.x = vx/Math.abs(vx);
            playerSprite.animations.play('walk', 5, true);
        } else {
            playerSprite.animations.play('idle', 5, true);
        }
    }

    private function onCollide(a, b) {
        if(a == playerSprite) {
            if(untyped a.body.touching.down && untyped b.body.touching.up) {
                resetJump();
            }

            if(untyped a.body.touching.up && untyped b.body.touching.down) {
                var e:Entity = untyped b.entity;

                if(e.get(Shake) == null) {
                    e.add(new Shake());
                    AudioManager.playSound("bump");
                }
            }
        }
    }
    private function hitWorldBounds(player) {
        if(player.body.position.y >= 192) {
            resetJump();
        }
    }
    public function resetJump() {
        jumpTime = 0;
        canJump = true;
        jumping = false;
    }
}


