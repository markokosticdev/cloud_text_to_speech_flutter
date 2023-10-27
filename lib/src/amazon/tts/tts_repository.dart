import 'dart:async';

import 'package:cloud_text_to_speech/src/amazon/audio/audio_handler.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/amazon/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/amazon/common/config.dart';
import 'package:cloud_text_to_speech/src/amazon/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_handler.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_responses.dart';

///Implements repository pattern to access Amazon resources
class RepositoryAmazon {
  RepositoryAmazon({required this.voicesHandler, required this.audioHandler});

  final VoicesHandlerAmazon voicesHandler;
  final AudioHandlerAmazon audioHandler;

  ///Get voices
  ///
  ///Returns [VoicesResponseAmazon]
  ///
  /// [VoicesSuccessAmazon] request succeeded
  ///
  /// On failure returns one of the following:
  /// [VoicesFailedBadRequestAmazon], [VoicesFailedBadRequestAmazon], [VoicesFailedUnauthorizedAmazon],
  /// [VoicesFailedTooManyRequestsAmazon], [VoicesFailedBadGateWayAmazon], [VoicesFailedUnknownErrorAmazon]
  Future<VoicesSuccessAmazon> getVoices() async {
    return await voicesHandler.getVoices();
  }

  ///Converts text to speech and return audio file as [Uint8List].
  ///
  /// [ttsParams] request parameters
  ///
  /// Returns [AudioSuccessAmazon]
  ///
  /// [AudioSuccessAmazon] request succeeded
  ///
  /// On failure returns one of the following:
  /// [AudioFailedBadRequestAmazon], [AudioFailedUnauthorizedAmazon], [AudioFailedUnsupportedAmazon], [AudioFailedTooManyRequestAmazon],
  /// [AudioFailedBadGatewayAmazon], [AudioFailedBadGatewayAmazon], [AudioFailedUnknownErrorAmazon] or [PollyExceptionAmazon]
  Future<AudioSuccessAmazon> convertTts(TtsParamsAmazon ttsParams) async {
    return await audioHandler.getAudio(ttsParams);
  }
}
