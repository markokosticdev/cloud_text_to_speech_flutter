import 'package:cloud_text_to_speech/src/common/utils/log.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_handler.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/google/common/config.dart';
import 'package:cloud_text_to_speech/src/google/common/init.dart';
import 'package:cloud_text_to_speech/src/google/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/google/tts/tts_repository.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_handler.dart';

///Helper class for Google TTS requests
class TtsGoogle {
  static final AudioHandlerGoogle _audioHandler = AudioHandlerGoogle();
  static final VoicesHandlerGoogle _voicesHandler = VoicesHandlerGoogle();
  static late final RepositoryGoogle repo;
  static bool _initDone = false;

  TtsGoogle._();

  /// MUST be called first before any other call is made.
  ///
  /// **params** : Google Init Params
  ///
  /// **withLogs** : (optional) enable logs. *true* by default
  ///
  static void init({required InitParamsGoogle params, bool withLogs = true}) =>
      _init(params.apiKey, withLogs);

  ///Get voices
  ///
  ///Returns [VoicesSuccessGoogle]
  ///
  /// [VoicesSuccessGoogle] request succeeded
  ///
  /// On failure throws one of the following:
  /// [VoicesFailedBadRequestGoogle], [VoicesFailedBadRequestGoogle], [VoicesFailedUnauthorizedGoogle],
  /// [VoicesFailedTooManyRequestsGoogle], [VoicesFailedBadGateWayGoogle], [VoicesFailedUnknownErrorGoogle]
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
  /// [AudioFailedBadGatewayGoogle], [AudioFailedBadGatewayGoogle], [AudioFailedUnknownErrorGoogle]
  ///
  static Future<AudioSuccessGoogle> convertTts(
      TtsParamsGoogle ttsParams) async {
    return repo.convertTts(ttsParams);
  }

  static void _init(String apiKey, [bool withLogs = true]) {
    if (!_initDone) {
      ConfigGoogle.init(apiKey: apiKey);
      _initRepository();
      _initLogs(withLogs);
      _initDone = true;
      Log.d("TtsGoogle initialised");
    } else {
      Log.d("TtsGoogle initialised already!");
    }
  }

  static void _initRepository() {
    repo = RepositoryGoogle(
        voicesHandler: _voicesHandler, audioHandler: _audioHandler);
  }

  static void _initLogs(bool withLogs) =>
      withLogs ? Log.enable() : Log.disable();

  static bool get initDone => _initDone;
}
