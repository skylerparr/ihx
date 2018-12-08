package ihx.program;

class HScriptProgram implements Program {

  private var statement: String;

  public function new() {
  }

  public function addStatement(stmt:String):Void {
    if( StringTools.startsWith(stmt, "import ")) {
      var pack: String = StringTools.replace(stmt, "import ", "");
      pack = StringTools.replace(pack, ";", "");
      var frags = pack.split(".");
      var className = frags[frags.length - 1];
      var clazz = Type.resolveClass(pack);
      if(clazz != null) {
        HScriptEval.interp.variables.set(className, clazz);
        statement = "true";
      } else {
        statement = '\'class ${pack} not found\'';
      }
    } else {
      statement = stmt;
    }
  }

  public function clearStatements():Void {
    statement = null;
  }

  public function acceptLastCmd(val:Bool):Void {
  }

  public function getVars():List<String> {
    var vars: Map<String,Dynamic> = HScriptEval.interp.variables;
    var retVal: List<String> = new List<String>();
    for(key in vars.keys()) {
      retVal.push(key);
    }
    return retVal;
  }

  public function getProgram(includeHelpers:Bool = true):String {
    return statement;
  }
}