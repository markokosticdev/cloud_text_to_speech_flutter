import 'package:cloud_text_to_speech/src/common/http/base_response.dart';

class ExceptionAmazon implements Exception {
  ExceptionAmazon({required this.response});

  final BaseResponse response;

  @override
  String toString() {
    return "[TtsExceptionAmazon] ${response.code}: ${response.reason}";
  }
}
