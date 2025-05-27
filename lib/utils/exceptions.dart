class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});
}
