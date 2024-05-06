import 'package:cloud_text_to_speech/src/common/http/base_response.dart';

class ExceptionGoogle implements Exception {
  ExceptionGoogle({required this.response});

  final BaseResponse response;

  @override
  String toString() {
    return "[TtsExceptionGoogle] ${response.code}: ${response.reason}";
  }
}
