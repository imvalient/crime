/// Exception class parent of all crime exceptions.
class CrimeException implements Exception {
  final String? message;
  final String? code;

  const CrimeException(this.message, this.code);

  @override
  String toString() => "[ERROR]: ($code) $message";
}

/// Exception thrown when the API Key is missing.
class MandatoryApiKeyException extends CrimeException {
  const MandatoryApiKeyException(String? message, String? code)
      : super(message, code);
}

/// Exception thrown when you're not alowed to send requests from your API Key.
class ForbiddenRequestException extends CrimeException {
  const ForbiddenRequestException(String? message, String? code)
      : super(message, code);
}

/// Exception thrown when you've reach a limit in your requests.
class LimitExceededRequestException extends CrimeException {
  const LimitExceededRequestException(String? message, String? code)
      : super(message, code);
}
