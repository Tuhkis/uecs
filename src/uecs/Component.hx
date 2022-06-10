package uecs;

class Component {
								var owner : Entity;
								public var name : String = "DEFAULTNAME";
								public function new(owner) {
																this.owner = owner;
								}
								public function ready() {}
								public function tick(deltaTime : Float = 0) {}
}
