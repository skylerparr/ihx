package ihx;

enum CompletionType {
  REFLECT;
  SCOPE;
}

typedef TabCompletion = {
  str: String,
  sub: String,
  suffix: String,
  type: CompletionType,
}
