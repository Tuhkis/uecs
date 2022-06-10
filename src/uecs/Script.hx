package uecs;

import hscript.Parser;
import hscript.Interp;

class Script extends Component {
								var interp : Interp;
								var readyProgram : Any;
								var tickProgram : Any;
								public function new(owner : Entity, readyCode : String = '', tickCode : String = '') {
																super(owner);

																var parser : Parser = new Parser();
																readyProgram = parser.parseString(readyCode);
																tickProgram = parser.parseString(tickCode);
																interp = new Interp();

																setVar('Math', Math); // Expose Math to scripts.
																// setVar('Entity', Entity);
																setVar('owner', owner);
																setVar('this', this);
								}
								public function setVar(name : String, value : Any) {
																interp.variables.set(name, value);
								}
								public function getVar(name : String) : Any {
																return interp.variables.get(name);
								}

								public override function ready() {
																interp.execute(readyProgram);
								}
								public override function tick(deltaTime : Float = 0) {
																setVar('deltaTime', deltaTime);
																interp.execute(tickProgram);
								}
}
