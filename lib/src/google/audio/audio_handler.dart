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
    final client = http.Client();
    final audioClient = AudioClientGoogle(
      client: client,
      authHeader: authHeader,
    );
    final mapper = AudioResponseMapperGoogle();

    try {
      final ssml =
          SsmlGoogle(text: params.text, rate: params.rate, pitch: params.pitch);

      final Map<String, dynamic> body = {
        'input': {'ssml': ssml.sanitizedSsml},
        'voice': {
          'name': params.voice.code,
          'languageCode': params.voice.locale.code
        },
        'audioConfig': {'audioEncoding': params.audioFormat},
      };

      final String bodyJson = jsonEncode(body);

      final response = await audioClient.post(Uri.parse(EndpointsGoogle.tts),
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
