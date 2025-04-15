class Failure {
  final bool succes;
  final int code;
  final String message;

  Failure(this.succes, this.code, this.message);
}

class Failures {
  final bool succes;
  final int code;
  final Map<String, String>? message;

  Failures(this.succes, this.code, this.message);
}
