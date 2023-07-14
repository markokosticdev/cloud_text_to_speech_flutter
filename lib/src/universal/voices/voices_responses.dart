import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';

class VoicesResponseUniversal extends BaseResponse {
  VoicesResponseUniversal({required int code, required String reason})
      : super(code: code, reason: reason);
}

class VoicesSuccessUniversal extends VoicesResponseUniversal {
  VoicesSuccessUniversal({required this.voices, required code, required reason})
      : super(code: code, reason: reason);
  final List<VoiceUniversal> voices;
}
