import luxe.Entity;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Visual;
import luxe.options.VisualOptions;
import luxe.Input;
import luxe.components.physics.nape.BoxCollider;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.phys.Material;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;

class Player extends Sprite{
	
	public var isGrounded:Bool;
	
	private var arrow:Visual;
	private var lastMousePos:Vector;
	private var playerSize:Vector;
	private var arrowSize:Vector;
	
	private var groundListener:InteractionListener;
	private var groundCollisionType:CbType;
	private var playerCollisionType:CbType;
	
	public function new() {
		
		super({
            name: 'player',
            pos: Luxe.screen.mid,
            color: new Color().rgb(0x3498DB)
        });
		
		playerSize = new Vector(32, 32);
		this.size = playerSize;
		
	} // constructor
	
	override function init() {
		
		var playerMaterial = Material.wood();
		playerMaterial.rollingFriction = 1;
		playerMaterial.staticFriction = 100;
		
		var playerCollider = new BoxCollider({
			name: 'collider',
			body_type: BodyType.DYNAMIC,
			material: playerMaterial,
			x: this.pos.x,
			y: this.pos.y,
			w: this.size.x,
			h: this.size.y
		});
		
		setupInput();
		
		isGrounded = false;
		
		groundCollisionType = new CbType();
		playerCollisionType = new CbType();
		
		playerCollider.body.cbTypes.add(playerCollisionType);
		
		World.bodies.set('player', playerCollider.body);
		
		groundListener = new InteractionListener(CbEvent.BEGIN, InteractionType.ANY, groundCollisionType, playerCollisionType, playerToGround);
		this.add(playerCollider);
		
		World.bodies.get('border').cbTypes.add(playerCollisionType);
		World.bodies.get('player').cbTypes.add(groundCollisionType);
		
		arrowSize = new Vector(playerSize.x / 4, playerSize.y / 4);
		var arrowOptions:VisualOptions = {
            size: new Vector(8, 8),
            color: new Color().rgb(0x3498DB),
            geometry: Luxe.draw.ngon({
                r: playerSize.x / 4,
                sides: 3,
                color: new Color().rgb(0x3498DB),
                solid: true
			}),
            no_geometry: false
        };
        
        arrow = new Visual(arrowOptions);
		arrow.transform.parent = this.transform;
		arrow.pos = new Vector(this.size.x / 2, this.size.y / 2);
		arrow.origin = new Vector(0, 64);
		
		lastMousePos = new Vector(0, 0);
		
	} // init
	
	override function onmousemove(e:MouseEvent) {
        
        lastMousePos = e.pos;
        
    } // onmousemove
    
    override function update(dt:Float) {
		
        arrow.rotation_z = Math.atan2(lastMousePos.y - this.pos.y, lastMousePos.x - this.pos.x) * 180 / Math.PI + 90;
		
		if(Luxe.input.inputdown('left')) {
            this.get('collider').body.applyImpulse(new Vec2(-90, 0));
        }
        if(Luxe.input.inputdown('right')) {
            this.get('collider').body.applyImpulse(new Vec2(90, 0));
        }
        if(Luxe.input.inputdown('up')) {
            if(this.isGrounded) {
                this.get('collider').body.applyImpulse(new Vec2(0, 900));    
            }
        }
        if(Luxe.input.inputdown('down')) {
            if(!this.isGrounded) {
                this.get('collider').body.applyImpulse(new Vec2(0, -90));
            }
        }
        
    } // update
	
	private function setupInput() {
        
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('right', Key.key_d);
        Luxe.input.bind_key('up', Key.space);
        Luxe.input.bind_key('down', Key.key_s);
        
    } // setupInput
	
	private function playerToGround(collision:InteractionCallback) {
		
		trace('connecting with ground');
		isGrounded = true;
		
	} // playerToGround
	
} // Player