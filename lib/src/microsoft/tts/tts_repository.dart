import 'dart:async';

import 'package:cloud_text_to_speech/src/microsoft/audio/audio_handler.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/microsoft/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/microsoft/common/config.dart';
import 'package:cloud_text_to_speech/src/microsoft/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_handler.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_responses.dart';

///Implements repository pattern to access Microsoft resources
class RepositoryMicrosoft {
  RepositoryMicrosoft(
      {required this.voicesHandler, required this.audioHandler});

  final VoicesHandlerMicrosoft voicesHandler;
  final AudioHandlerMicrosoft audioHandler;

  ///Get voices
  ///
  ///Returns [VoicesResponseMicrosoft]
  ///
  /// [VoicesSuccessMicrosoft] request succeeded
  ///
  /// On failure returns one of the following:
  /// [VoicesFailedBadRequestMicrosoft], [VoicesFailedBadRequestMicrosoft], [VoicesFailedUnauthorizedMicrosoft],
  /// [VoicesFailedTooManyRequestsMicrosoft], [VoicesFailedBadGateWayMicrosoft], [VoicesFailedUnknownErrorMicrosoft]
  Future<VoicesSuccessMicrosoft> getVoices() async {
    return await voicesHandler.getVoices(
        SubscriptionKeyAuthenticationHeaderMicrosoft(
            subscriptionKey: ConfigMicrosoft.subscriptionKey));
  }

  ///Converts text to speech and return audio file as [Uint8List].
  ///
  /// [ttsParams] request parameters
  ///
  /// Returns [AudioSuccessMicrosoft]
  ///
  /// [AudioSuccessMicrosoft] request succeeded
  ///
  /// On failure returns one of the following:
  /// [AudioFailedBadRequestMicrosoft], [AudioFailedUnauthorizedMicrosoft], [AudioFailedUnsupportedMicrosoft], [AudioFailedTooManyRequestMicrosoft],
  /// [AudioFailedBadGatewayMicrosoft], [AudioFailedBadGatewayMicrosoft], [AudioFailedUnknownErrorMicrosoft] or [AzureExceptionMicrosoft]
  Future<AudioSuccessMicrosoft> convertTts(TtsParamsMicrosoft ttsParams) async {
    return await audioHandler.getAudio(
        ttsParams,
        SubscriptionKeyAuthenticationHeaderMicrosoft(
            subscriptionKey: ConfigMicrosoft.subscriptionKey));
  }
}
