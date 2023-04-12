/// Exception for every Cause of Api Exception

class ServerException implements Exception {
  final String message;
  final int statusCode;

  ServerException({required this.message, required this.statusCode});
}

class DataParsingException implements Exception {
  final String message;
  final int statusCode;

  DataParsingException({required this.message, required this.statusCode});
}

class NoConnectionException implements Exception {
  final String message;
  final int statusCode;

  NoConnectionException({required this.message, required this.statusCode});
}
