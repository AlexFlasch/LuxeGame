import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.phys.Material;

import luxe.GameConfig;
import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Visual;
import luxe.options.VisualOptions;
import luxe.physics.nape.DebugDraw;

import phoenix.Transform;

class Main extends luxe.Game {
    
    public var player:Player;
    public var border:Body;
    
    public var drawer:DebugDraw;

    override function config(config:GameConfig) {
        
        config.window.title = 'Prototype';
        config.window.width = 960;
        config.window.height = 640;
        config.window.fullscreen = false;
        
        config.render.antialiasing = 4;

        return config;
        
    } // config

    override function ready() {
        
        player = new Player();
       
        setupWorld();
        
    } // ready

    override function onkeyup(e:KeyEvent) {
        
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
        
    } // onkeyup

    override function update(dt:Float) {
        
        Luxe.draw.text({
            color: new Color().rgb(0x26A65B),
            pos: new Vector(15, 15),
            point_size: 24,
            text: 'player.isGrounded: ' + player.isGrounded
        });
        
    } // update
    
    function setupWorld() {
        
        drawer = new DebugDraw();
        Luxe.physics.nape.debugdraw = drawer;
        
        var w = Luxe.screen.w;
        var h = Luxe.screen.h;
        
        border = new Body(BodyType.STATIC);
        
        var bottomBorder = new Polygon(Polygon.rect(0, 0, 2, -1));
        bottomBorder.material = Material.sand();
        
        border.shapes.add(bottomBorder);
        border.shapes.add(new Polygon(Polygon.rect(0, h, w, 1)));
        border.shapes.add(new Polygon(Polygon.rect(0, 0, -1, h)));
        border.shapes.add(new Polygon(Polygon.rect(w, 0, 1, h)));
        border.space = Luxe.physics.nape.space;
        
        World.bodies.set('border', border);
        
        drawer.add(border);
        
    } // setupWorld

} //Main
