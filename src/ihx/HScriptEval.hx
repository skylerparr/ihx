package ihx;

import hscript.plus.ParserPlus;
import ihx.CmdProcessor.CmdError.InvalidStatement;
import ihx.CmdProcessor.CmdError.IncompleteStatement;
import hscript.Interp;
import hscript.Parser;
class HScriptEval implements Eval {

  public var debug:Bool;

  public var classpath(default, null):Set<String>;
  public var libs(default, null):Set<String>;
  public var defines(default, null):Set<String>;
  public var tmpSuffix(default, null):String;

  public static var interp = new Interp();
  public static var parser = new ParserPlus();

  public static var instance: Eval;

  public function new() {
    instance = this;
    parser.allowTypes = true;
    parser.allowMetadata = true;
  }

  public function evaluate(progStr:String):Dynamic {
    var ret = null;
    try {
      var ast = parser.parseString(progStr);
      ret = interp.execute(ast);
      if(ret != null) {
        interp.variables.set("_", ret);
      }
    } catch(e: Dynamic) {
      if(StringTools.endsWith(e, '"<eof>"')) {
        throw IncompleteStatement;
      } else {
        throw InvalidStatement(e);
      }
    }
    return ret;
  }

  public function getArgs():Array<String> {
    return [];
  }
}