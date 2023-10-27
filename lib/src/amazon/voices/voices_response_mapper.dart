import 'dart:convert';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/common/http/base_response_mapper.dart';
import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voice_model.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_responses.dart';
import 'package:http/http.dart' as http;

class VoicesResponseMapperAmazon extends BaseResponseMapper {
  @override
  BaseResponse map(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          String utfDecodedResponse = utf8.decode(response.bodyBytes);

          final json =
              jsonDecode(utfDecodedResponse)['Voices'] as List<dynamic>;
          var voices = json
              .map((e) => VoiceAmazon.fromJson(e as Map<String, dynamic>))
              .toList(growable: false);

          voices = Helpers.removeVoiceDuplicates(voices);

          Helpers.sortVoices(voices);

          return VoicesSuccessAmazon(voices: voices);
        }
      case 400:
        return VoicesFailedBadRequestAmazon(
            reasonPhrase: response.reasonPhrase);
      case 401:
        return VoicesFailedUnauthorizedAmazon();
      case 429:
        return VoicesFailedTooManyRequestsAmazon();
      case 502:
        return VoicesFailedBadGateWayAmazon();
      default:
        return VoicesFailedUnknownErrorAmazon(
            code: response.statusCode,
            reason: response.reasonPhrase ?? response.body);
    }
  }
}
