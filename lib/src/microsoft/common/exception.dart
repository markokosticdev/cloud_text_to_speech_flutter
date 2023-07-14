import 'package:cloud_text_to_speech/src/common/http/base_response.dart';

class ExceptionMicrosoft implements Exception {
  ExceptionMicrosoft({required this.response});
  final BaseResponse response;

  @override
  String toString() {
    return "[TtsExceptionMicrosoft] ${response.code}: ${response.reason}";
  }
}
