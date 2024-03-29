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

class Zone {
    public function new() {};
    public var entities:Array<Entity> = [];
}

class Game extends Application {
    static public var instance:Game;

    public var zones:Array<Zone> = [];

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

        var fadeState = createState("fade");
        fadeState.addInstance(new game.FadeSystem());

        var ingameState = createState("ingame");

        ingameState.addInstance(new game.LevelLoaderSystem());
        ingameState.addInstance(new game.BounceSystem());
        ingameState.addInstance(new game.WorldObjectSystem());
        ingameState.addInstance(new game.DoorSystem());

        {
            createUiState("empty", ".empty");
            createUiState("intro", ".intro");
            createUiState("intro2", ".intro2");
            createUiState("menu", ".menu");
            createUiState("hud", ".hud");
            createUiState("black", ".black");

            changeUiState("empty");
        }

        changeState("menu");
    }

    override function initPages() {
        pages = js.uipages.Lib.createGroup(
                    new JQuery(".pages"),
        {effect:"fade", duration:1500},
        {effect:"fade", duration:1500}
                );
        new JQuery(".loading span").text('Cliquez pour continuer');
        new JQuery(".loading").one("click", function() {
            /* intro(); */
            fadeToGame(); // DEBUG
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
                    whiplash.AudioManager.playSound("magic4");
                    changeUiState("intro2");
                    delay(function() {
                        changeUiState("empty");
                        delay(function() {
                            whiplash.AudioManager.playSound("magic3");
                            changeUiState("menu");
                        }, 2);
                    }, 3);
                }, 2);
            }, 3);
        }, 2.5);
    }

    public function fadeToGame() {
        new JQuery(".loading").hide();
        whiplash.AudioManager.playMusic("music", 0.6);
        whiplash.AudioManager.playSound("magic-play");
        FadeSystem.instance.setCallback(function() {
            Game.instance.changeState("ingame");
            Game.instance.changeUiState("hud");
        });
        changeState("fade");
    }

    public function addZone(index:Int) {
        for(e in zones[index].entities) {
            engine.addEntity(e);
        }
    }

    static function main():Void {
        instance = new Game();
    }
}
