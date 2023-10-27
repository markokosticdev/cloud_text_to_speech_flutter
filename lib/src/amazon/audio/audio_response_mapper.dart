import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/common/http/base_response_mapper.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_responses.dart';
import 'package:http/http.dart' as http;

class AudioResponseMapperAmazon extends BaseResponseMapper {
  @override
  BaseResponse map(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return AudioSuccessAmazon(audio: response.bodyBytes);
      case 400:
        return AudioFailedBadRequestAmazon(reasonPhrase: response.reasonPhrase);
      case 401:
        return AudioFailedUnauthorizedAmazon();
      case 415:
        return AudioFailedUnsupportedAmazon();
      case 429:
        return AudioFailedTooManyRequestAmazon();
      case 502:
        return AudioFailedBadGatewayAmazon();
      default:
        return AudioFailedUnknownErrorAmazon(
            code: response.statusCode,
            reason: response.reasonPhrase ?? response.body);
    }
  }
}
