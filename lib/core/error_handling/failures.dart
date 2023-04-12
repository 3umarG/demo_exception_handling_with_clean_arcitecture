import 'package:demo_exception_handling_with_clean_arcitecture/core/error_handling/error_object.dart';

abstract class Failure {
  final ErrorObject errorObject;

  Failure(this.errorObject);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorObject);
}

class DataParsingFailure extends Failure {
  DataParsingFailure(super.errorObject);
}

class NoConnectionFailure extends Failure {
  NoConnectionFailure(super.errorObject);
}
