import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/common/http/base_response_mapper.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_responses.dart';
import 'package:http/http.dart' as http;

class AudioResponseMapperGoogle extends BaseResponseMapper {
  @override
  BaseResponse map(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> json = jsonDecode(response.body);
        final Uint8List bodyBytes = base64.decode(json['audioContent']);
        return AudioSuccessGoogle(audio: bodyBytes);
      case 400:
        return AudioFailedBadRequestGoogle(reasonPhrase: response.reasonPhrase);
      case 401:
        return AudioFailedUnauthorizedGoogle();
      case 415:
        return AudioFailedUnsupportedGoogle();
      case 429:
        return AudioFailedTooManyRequestGoogle();
      case 502:
        return AudioFailedBadGatewayGoogle();
      default:
        return AudioFailedUnkownErrorGoogle(
            code: response.statusCode,
            reason: response.reasonPhrase ?? response.body);
    }
  }
}
