import 'package:cloud_text_to_speech/src/common/utils/log.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_handler.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/microsoft/common/config.dart';
import 'package:cloud_text_to_speech/src/microsoft/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/microsoft/tts/tts_respository.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_handler.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_responses.dart';

///Helper class for Microsoft TTS requests
class TtsMicrosoft {
  static final AudioHandlerMicrosoft _audioHandler = AudioHandlerMicrosoft();
  static final VoicesHandlerMicrosoft _voicesHandler = VoicesHandlerMicrosoft();
  static late final RepositoryMicrosoft repo;

  /// MUST be called first before any other call is made.
  ///
  /// **region** : Microsoft Azure endpoint region
  ///
  /// **subscriptionKey** : Microsoft Azure subscription key
  ///
  /// **withLogs** : (optional) enable logs. *true* by default
  ///
  static void init(
          {required String subscriptionKey,
          required String region,
          bool withLogs = true}) =>
      _init(subscriptionKey, region, withLogs);

  ///Get voices
  ///
  ///Returns [VoicesSuccessMicrosoft]
  ///
  /// [VoicesSuccessMicrosoft] request succeeded
  ///
  /// On failure throws one of the following:
  /// [VoicesFailedBadRequestMicrosoft], [VoicesFailedBadRequestMicrosoft], [VoicesFailedUnauthorizedMicrosoft],
  /// [VoicesFailedTooManyRequestsMicrosoft], [VoicesFailedBadGateWayMicrosoft], [VoicesFailedUnkownErrorMicrosoft]
  ///
  static Future<VoicesSuccessMicrosoft> getVoices() async {
    return repo.getVoices();
  }

  ///Converts text to speech and return audio file as [Uint8List].
  ///
  /// [ttsParams] request parameters
  ///
  /// Returns [AudioResponseMicrosoft]
  ///
  /// [AudioSuccessMicrosoft] request succeeded
  ///
  /// On failure returns one of the following:
  /// [AudioFailedBadRequestMicrosoft], [AudioFailedUnauthorizedMicrosoft], [AudioFailedUnsupportedMicrosoft], [AudioFailedTooManyRequestMicrosoft],
  /// [AudioFailedBadGatewayMicrosoft], [AudioFailedBadGatewayMicrosoft], [AudioFailedUnkownErrorMicrosoft]
  ///
  static Future<AudioSuccessMicrosoft> convertTts(
      TtsParamsMicrosoft ttsParams) async {
    return repo.convertTts(ttsParams);
  }

  static void _init(String subscriptionKey, String region,
      [bool withLogs = true]) {
    ConfigMicrosoft.init(subscriptionKey: subscriptionKey, region: region);
    _initRepository();
    _initLogs(withLogs);
    Log.d("Package initialised");
  }

  static void _initRepository() {
    repo = RepositoryMicrosoft(
        voicesHandler: _voicesHandler, audioHandler: _audioHandler);
  }

  static void _initLogs(bool withLogs) =>
      withLogs ? Log.enable() : Log.disable();
}
