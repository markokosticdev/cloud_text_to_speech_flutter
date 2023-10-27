import 'package:cloud_text_to_speech/src/amazon/common/init.dart';
import 'package:cloud_text_to_speech/src/common/utils/log.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_handler.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/amazon/common/config.dart';
import 'package:cloud_text_to_speech/src/amazon/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/amazon/tts/tts_repository.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_handler.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_responses.dart';

///Helper class for Amazon TTS requests
class TtsAmazon {
  static final AudioHandlerAmazon _audioHandler = AudioHandlerAmazon();
  static final VoicesHandlerAmazon _voicesHandler = VoicesHandlerAmazon();
  static late final RepositoryAmazon repo;
  static bool _initDone = false;

  TtsAmazon._();

  /// MUST be called first before any other call is made.
  ///
  /// **params** : Amazon Init Params
  ///
  /// **withLogs** : (optional) enable logs. *true* by default
  ///
  static void init({required InitParamsAmazon params, bool withLogs = true}) =>
      _init(params.keyId, params.accessKey, params.region, withLogs);

  ///Get voices
  ///
  ///Returns [VoicesSuccessAmazon]
  ///
  /// [VoicesSuccessAmazon] request succeeded
  ///
  /// On failure throws one of the following:
  /// [VoicesFailedBadRequestAmazon], [VoicesFailedBadRequestAmazon], [VoicesFailedUnauthorizedAmazon],
  /// [VoicesFailedTooManyRequestsAmazon], [VoicesFailedBadGateWayAmazon], [VoicesFailedUnknownErrorAmazon]
  ///
  static Future<VoicesSuccessAmazon> getVoices() async {
    return repo.getVoices();
  }

  ///Converts text to speech and return audio file as [Uint8List].
  ///
  /// [ttsParams] request parameters
  ///
  /// Returns [AudioResponseAmazon]
  ///
  /// [AudioSuccessAmazon] request succeeded
  ///
  /// On failure returns one of the following:
  /// [AudioFailedBadRequestAmazon], [AudioFailedUnauthorizedAmazon], [AudioFailedUnsupportedAmazon], [AudioFailedTooManyRequestAmazon],
  /// [AudioFailedBadGatewayAmazon], [AudioFailedBadGatewayAmazon], [AudioFailedUnknownErrorAmazon]
  ///
  static Future<AudioSuccessAmazon> convertTts(
      TtsParamsAmazon ttsParams) async {
    return repo.convertTts(ttsParams);
  }

  static void _init(String keyId, String accessKey, String region,
      [bool withLogs = true]) {
    if (!_initDone) {
      ConfigAmazon.init(keyId: keyId, accessKey: accessKey, region: region);
      _initRepository();
      _initLogs(withLogs);
      _initDone = true;
      Log.d("TtsAmazon initialised");
    } else {
      Log.d("TtsAmazon initialised already!");
    }
  }

  static void _initRepository() {
    repo = RepositoryAmazon(
        voicesHandler: _voicesHandler, audioHandler: _audioHandler);
  }

  static void _initLogs(bool withLogs) =>
      withLogs ? Log.enable() : Log.disable();

  static bool get initDone => _initDone;
}
