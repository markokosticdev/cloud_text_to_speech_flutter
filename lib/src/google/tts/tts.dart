import 'package:cloud_text_to_speech/src/common/utils/log.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_handler.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/google/common/config.dart';
import 'package:cloud_text_to_speech/src/google/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/google/tts/tts_respository.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_handler.dart';

///Helper class for Google TTS requests
class TtsGoogle {
  static final AudioHandlerGoogle _audioHandler = AudioHandlerGoogle();
  static final VoicesHandlerGoogle _voicesHandler = VoicesHandlerGoogle();
  static late final RepositoryGoogle repo;

  /// MUST be called first before any other call is made.
  ///
  /// **apiKey** : Google Cloud api key
  ///
  /// **withLogs** : (optional) enable logs. *true* by default
  ///
  static void init({required String apiKey, bool withLogs = true}) =>
      _init(apiKey, withLogs);

  ///Get voices
  ///
  ///Returns [VoicesSuccessGoogle]
  ///
  /// [VoicesSuccessGoogle] request succeeded
  ///
  /// On failure throws one of the following:
  /// [VoicesFailedBadRequestGoogle], [VoicesFailedBadRequestGoogle], [VoicesFailedUnauthorizedGoogle],
  /// [VoicesFailedTooManyRequestsGoogle], [VoicesFailedBadGateWayGoogle], [VoicesFailedUnkownErrorGoogle]
  ///
  static Future<VoicesSuccessGoogle> getVoices() async {
    return repo.getVoices();
  }

  ///Converts text to speech and return audio file as [Uint8List].
  ///
  /// [ttsParams] request parameters
  ///
  /// Returns [AudioResponseGoogle]
  ///
  /// [AudioSuccessGoogle] request succeeded
  ///
  /// On failure returns one of the following:
  /// [AudioFailedBadRequestGoogle], [AudioFailedUnauthorizedGoogle], [AudioFailedUnsupportedGoogle], [AudioFailedTooManyRequestGoogle],
  /// [AudioFailedBadGatewayGoogle], [AudioFailedBadGatewayGoogle], [AudioFailedUnkownErrorGoogle]
  ///
  static Future<AudioSuccessGoogle> convertTts(
      TtsParamsGoogle ttsParams) async {
    return repo.convertTts(ttsParams);
  }

  static void _init(String apiKey, [bool withLogs = true]) {
    ConfigGoogle.init(apiKey: apiKey);
    _initRepository();
    _initLogs(withLogs);
    Log.d("Package initialised");
  }

  static void _initRepository() {
    repo = RepositoryGoogle(
        voicesHandler: _voicesHandler, audioHandler: _audioHandler);
  }

  static void _initLogs(bool withLogs) =>
      withLogs ? Log.enable() : Log.disable();
}
