import 'dart:convert';

import 'package:cloud_text_to_speech/src/google/audio/audio_client.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_request_param.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_response_mapper.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/google/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/google/common/constants.dart';
import 'package:cloud_text_to_speech/src/google/ssml/ssml.dart';
import 'package:http/http.dart' as http;

class AudioHandlerGoogle {
  Future<AudioSuccessGoogle> getAudio(AudioRequestParamsGoogle params,
      AuthenticationHeaderGoogle authHeader) async {
    final mapper = AudioResponseMapperGoogle();
    final audioClient = AudioClientGoogle(
      client: http.Client(),
      authHeader: authHeader,
    );

    try {
      final ssml =
          SsmlGoogle(text: params.text, rate: params.rate, pitch: params.pitch);

      final Map<String, dynamic> body = {
        'input': {'ssml': ssml.sanitizedSsml.replaceAll('"', '\\"')},
        'voice': {
          'name': params.voice.code,
          'languageCode': params.voice.locale
        },
        'audioConfig': {'audioEncoding': params.audioFormat},
      };

      final String bodyJson = jsonEncode(body);

      print(body['input']['ssml']);
      final response = await audioClient.post(Uri.parse(EndpointsGoogle.audio),
          body: bodyJson);
      final audioResponse = mapper.map(response);
      if (audioResponse is AudioSuccessGoogle) {
        return audioResponse;
      } else {
        throw audioResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
