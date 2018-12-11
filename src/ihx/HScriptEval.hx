package ihx;

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
  private var parser = new Parser();

  public function new() {
    parser.allowTypes = true;
    parser.allowMetadata = true;
  }

  public function evaluate(progStr:String):Dynamic {
    var ret = null;
    try {
      var ast = parser.parseString(progStr);
      ret = interp.execute(ast);
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