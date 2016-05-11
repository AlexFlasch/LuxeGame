
import luxe.GameConfig;
import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Visual;
import luxe.options.VisualOptions;
import phoenix.Transform;


class Main extends luxe.Game {
    
    public var player:Player;
    public var speed:Float;

    override function config(config:GameConfig) {
        
        config.window.title = 'Prototype';
        config.window.width = 960;
        config.window.height = 640;
        config.window.fullscreen = false;
        
        speed = 1000.0;

        return config;
        
    } // config

    override function ready() {
        
        player = new Player();
       
        setupInput(); 
        
    } // ready
    
    override function onkeydown(e:KeyEvent) {
        
        
        
    } // onkeydown

    override function onkeyup(e:KeyEvent) {
        
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
        
    } // onkeyup
    
    override function onmousemove(e:MouseEvent) {
        
        
        
    } // onmousemove

    override function update(dt:Float) {
        
        if(Luxe.input.inputdown('left')) {
            player.pos.x -= speed * dt;
        }
        if(Luxe.input.inputdown('right')) {
            player.pos.x += speed * dt;
        }
        if(Luxe.input.inputdown('up')) {
            player.pos.y -= speed * dt;
        }
        if(Luxe.input.inputdown('down')) {
            player.pos.y += speed * dt;
        }
        
    } // update
    
    function setupInput() {
        
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('right', Key.key_d);
        Luxe.input.bind_key('up', Key.key_w);
        Luxe.input.bind_key('down', Key.key_s);
        
    } // setupInput

} //Main
