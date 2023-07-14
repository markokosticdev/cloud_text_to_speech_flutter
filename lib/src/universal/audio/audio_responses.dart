import 'dart:typed_data';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';

abstract class AudioResponseUniversal extends BaseResponse {
  AudioResponseUniversal({required int code, required String reason})
      : super(code: code, reason: reason);
}

class AudioSuccessUniversal extends AudioResponseUniversal {
  AudioSuccessUniversal({required this.audio, required code, required reason})
      : super(code: code, reason: reason);
  final Uint8List audio;
}
