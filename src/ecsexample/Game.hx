package ecsexample;

import hxgf.App; // This example uses HXGF for rendering! It is not a dependency for this though!
import hxgf.Color;
import hxgf.Input;

import uecs.Entity; // Import Entity and Script classes
import uecs.Script;

class Game extends App {
								var player : Entity = new Entity(); // Create entity named player
								public function new() {
																super(500, 400); // Create a display of dimensions (500, 400)

																// Add a script component to player. Arguments are (owner, ready, tick). Owner is a reference to the player in this case. Ready is the script executed when entitys' ready() method is called. Tick is called every frame
																// This is a "transform" component (which i'd generally implement extending Component with normal haxe though, but this is just the example. Also scripts should be loaded as separate files, but JS ): )
																player.addComponent(new Script(player, "
																																								this.name = 'transform';

																																								this.setVar('x', 10);
																																								this.setVar('y', 25);
																																								",
																																								"
																																								"));
																// This is a component that moves the player(/owner (Assuming you set a different owner.)).
																var movementComponent : Script = new Script(player, "
																																								this.setVar('transform', owner.getComponent('transform'));
																																								this.setVar('speed', 100);
																																								", "
																																								var x = transform.getVar('x'); var y = transform.getVar('y'); // Get reference to player pos.

																																								if (Input.isPressed('d')) {x += speed * deltaTime;}
																																								if (Input.isPressed('a')) {x -= speed * deltaTime;}
																																								if (Input.isPressed('s')) {y += speed * deltaTime;}
																																								if (Input.isPressed('w')) {y -= speed * deltaTime;}

																																								transform.setVar('x', x); transform.setVar('y', y); // Set player pos to new pos
																																								"
																																								);
																movementComponent.setVar('Input', Input);
																player.addComponent(movementComponent);
																// This is a rendering component
																var renderingComponent : Script;
																renderingComponent = new Script(player, "
																																this.name = 'renderer'; // Components named 'renderer' are not called from the entitys tick() method, but actually the render() method.
																																this.setVar('transform', owner.getComponent('transform'));
																																", "
																																								g.setColor(new Color(25, 25, 25));
																																								g.fillRect(transform.getVar('x'), transform.getVar('y'), 64, 64);
																																");
																renderingComponent.setVar('g', g); renderingComponent.setVar('Color', Color); // Add graphics context and hxgf.Color to renderingComponent.
																player.addComponent(renderingComponent);
																ready(); // Call ready
								}
								private function ready() {
																player.ready(); // Call players ready method
								}
								public override function tick() {
																player.tick(deltaTime); // Is called every frame. Calls players tick method. (which executes components tick of course)
								}
								public override function render() {
																g.setColor(new Color(100, 100, 200));
																g.fillScreen();
																player.render();
								}
}
