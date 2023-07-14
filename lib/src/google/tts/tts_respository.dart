import 'dart:async';

import 'package:cloud_text_to_speech/src/google/audio/audio_handler.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/google/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/google/common/config.dart';
import 'package:cloud_text_to_speech/src/google/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_handler.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_responses.dart';

///Implements repository pattern to access Google resources
class RepositoryGoogle {
  RepositoryGoogle({required this.voicesHandler, required this.audioHandler});

  final VoicesHandlerGoogle voicesHandler;
  final AudioHandlerGoogle audioHandler;

  ///Get voices
  ///
  ///Returns [VoicesResponseGoogle]
  ///
  /// [VoicesSuccessGoogle] request succeeded
  ///
  /// On failure returns one of the following:
  /// [VoicesFailedBadRequestGoogle], [VoicesFailedBadRequestGoogle], [VoicesFailedUnauthorizedGoogle],
  /// [VoicesFailedTooManyRequestsGoogle], [VoicesFailedBadGateWayGoogle], [VoicesFailedUnkownErrorGoogle]
  Future<VoicesSuccessGoogle> getVoices() async {
    return await voicesHandler.getVoices(
        ApiKeyAuthenticationHeaderGoogle(apiKey: ConfigGoogle.apiKey));
  }

  ///Converts text to speech and return audio file as [Uint8List].
  ///
  /// [ttsParams] request parameters
  ///
  /// Returns [AudioSuccessGoogle]
  ///
  /// [AudioSuccessGoogle] request succeeded
  ///
  /// On failure returns one of the following:
  /// [AudioFailedBadRequestGoogle], [AudioFailedUnauthorizedGoogle], [AudioFailedUnsupportedGoogle], [AudioFailedTooManyRequestGoogle],
  /// [AudioFailedBadGatewayGoogle], [AudioFailedBadGatewayGoogle], [AudioFailedUnkownErrorGoogle] or [AzureExceptionGoogle]
  Future<AudioSuccessGoogle> convertTts(TtsParamsGoogle ttsParams) async {
    return await audioHandler.getAudio(ttsParams,
        ApiKeyAuthenticationHeaderGoogle(apiKey: ConfigGoogle.apiKey));
  }
}
