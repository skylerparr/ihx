package ihx;

interface Eval {
  var debug:Bool;
  var classpath(default, null):Set<String>;
  var libs(default, null):Set<String>;
  var defines(default, null):Set<String>;
  var tmpSuffix(default, null):String;

  function evaluate(progStr: String): Dynamic;
  function getArgs(): Array<String>;
}