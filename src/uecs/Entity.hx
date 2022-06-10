package uecs;

class Entity {
								public var components : Array<Component> = [];

								public function new() {}

								public function tick(deltaTime : Float = 0) {
																for (c in components) {
																								if (c.name != 'renderer')
																								c.tick(deltaTime);
																}
								}
								public function render() {
																for (c in components) {
																								if (c.name == 'renderer')
																								c.tick();
																}
								}
								public function ready() {
																for (c in components) {
																								c.ready();
																}
								}
								public function addComponent(component : Component) {
																components.push(component);
								}
								public function getComponent(name : String) {
																var ret : Component = null;
																for (c in components) {
																								if (c.name == name)
																																ret = c;
																}
																return ret;
								}

								public function test() {
																trace('It just works - Toddvich Howardski');
								}
}
