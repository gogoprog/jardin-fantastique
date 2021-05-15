package game;

import js.Lib;
import js.jquery.*;
import js.Browser.document;
import js.Browser.window;
import phaser.Game;
import phaser.Phaser;
import ash.core.Entity;
import ash.core.Engine;
import ash.core.Node;
import whiplash.*;
import whiplash.math.*;
import whiplash.phaser.*;
import whiplash.common.components.Active;

class Game extends Application {
    static public var instance:Game;

    public function new() {
        var config = {
            render:{
                transparent:false
            },
            scale : {
                mode: phaser.scale.scalemodes.NONE
            },
            backgroundColor:"#2f471f"
        };
        super(Config.screenWidth, Config.screenHeight, ".root", config);
    }

    override function preload():Void {
        super.preload();
        Factory.preload(whiplash.Lib.phaserScene);
    }

    override function create():Void {
        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;
        AudioManager.init(whiplash.Lib.phaserScene);
        Factory.init(whiplash.Lib.phaserScene);

        whiplash.platformer.Lib.init(this);

        var menuState = createState("menu");
        menuState.addInstance(new game.MenuSystem());

        var ingameState = createState("ingame");
        ingameState.addInstance(new game.LevelLoaderSystem());
        ingameState.addInstance(new game.BounceSystem());

        {
            createUiState("empty", ".empty");
            createUiState("intro", ".intro");
            createUiState("intro2", ".intro2");
            createUiState("menu", ".menu");
            createUiState("hud", ".hud");

            changeUiState("empty");
        }

        changeState("menu");
    }

    override function initPages() {
        pages = js.uipages.Lib.createGroup(new JQuery(".pages"), "fade", "fade");
        new JQuery(".loading span").text('Cliquez pour continuer');
        new JQuery(".loading").one("click", function() {
            intro();
        });
    }

    private function intro() {
        whiplash.AudioManager.playSound("magic");
        new JQuery(".loading").hide('fade');
        delay(function() {
            changeUiState("intro");
            delay(function() {
                changeUiState("empty");
                delay(function() {
                    whiplash.AudioManager.playSound("tinkle");
                    changeUiState("intro2");
                    delay(function() {
                        changeUiState("empty");
                        delay(function() {
                            whiplash.AudioManager.playSound("magic2");
                            changeUiState("menu");
                        }, 2);
                    }, 3);
                }, 2);
            }, 3);
        }, 2.5);
    }

    static function main():Void {
        instance = new Game();
    }
}
