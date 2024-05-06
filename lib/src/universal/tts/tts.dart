import 'package:cloud_text_to_speech/src/amazon/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/amazon/common/init.dart';
import 'package:cloud_text_to_speech/src/amazon/tts/tts.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices.dart';
import 'package:cloud_text_to_speech/src/common/tts/tts_providers.dart';
import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:cloud_text_to_speech/src/common/utils/log.dart';
import 'package:cloud_text_to_speech/src/google/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/google/common/init.dart';
import 'package:cloud_text_to_speech/src/google/tts/tts.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/microsoft/common/init.dart';
import 'package:cloud_text_to_speech/src/microsoft/tts/tts.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices.dart';
import 'package:cloud_text_to_speech/src/universal/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/universal/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/universal/tts/tts_params_mapper.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voices.dart';

///Helper class for Universal TTS requests
class TtsUniversal {
  static late String _provider;
  static bool _initDone = false;

  static void setProvider(String provider) {
    TtsUniversal._provider = provider.toLowerCase();
  }

  /// MUST be called first before any other call is made.
  ///
  static void init(
          {required String provider,
          InitParamsGoogle? googleParams,
          InitParamsMicrosoft? microsoftParams,
          InitParamsAmazon? amazonParams,
          bool withLogs = true}) =>
      _init(provider, googleParams, microsoftParams, amazonParams, withLogs);

  ///Get voices
  ///
  ///Returns [VoicesSuccessUniversal]
  ///
  /// [VoicesSuccessUniversal] request succeeded
  ///
  /// On failure throws one of the following:
  /// [VoicesFailedBadRequestGoogle], [VoicesFailedBadRequestGoogle], [VoicesFailedUnauthorizedGoogle],
  /// [VoicesFailedTooManyRequestsGoogle], [VoicesFailedBadGateWayGoogle], [VoicesFailedUnknownErrorGoogle],
  /// [VoicesFailedBadRequestMicrosoft], [VoicesFailedBadRequestMicrosoft], [VoicesFailedUnauthorizedMicrosoft],
  /// [VoicesFailedTooManyRequestsMicrosoft], [VoicesFailedBadGateWayMicrosoft], [VoicesFailedUnknownErrorMicrosoft],
  /// [VoicesFailedBadRequestAmazon], [VoicesFailedBadRequestAmazon], [VoicesFailedUnauthorizedAmazon],
  /// [VoicesFailedTooManyRequestsAmazon], [VoicesFailedBadGateWayAmazon], [VoicesFailedUnknownErrorAmazon]
  ///
  static Future<VoicesSuccessUniversal> getVoices() async {
    return await handleProvider<Future<VoicesSuccessUniversal>>(
      google: () => _getVoices(TtsProviders.google),
      microsoft: () => _getVoices(TtsProviders.microsoft),
      amazon: () => _getVoices(TtsProviders.amazon),
      combine: () async {
        List<Future<VoicesSuccessUniversal>> allVoicesFutures = [
          if (isProviderInitDone(TtsProviders.google))
            _getVoices(TtsProviders.google),
          if (isProviderInitDone(TtsProviders.microsoft))
            _getVoices(TtsProviders.microsoft),
          if (isProviderInitDone(TtsProviders.amazon))
            _getVoices(TtsProviders.amazon),
        ];

        List<VoicesSuccessUniversal> allVoices =
            await Future.wait(allVoicesFutures);

        VoicesSuccessUniversal aggregatedVoices = VoicesSuccessUniversal(
            voices: [], code: 200, reason: 'Aggregated voices');

        List<VoiceUniversal> voices = [];

        for (VoicesSuccessUniversal item in allVoices) {
          voices.addAll(item.voices);
        }

        Helpers.sortVoices(voices);

        aggregatedVoices.voices.addAll(voices);

        return aggregatedVoices;
      },
    );
  }

  static Future<VoicesSuccessUniversal> _getVoices(String provider) async {
    return await handleProvider<Future<VoicesSuccessUniversal>>(
        google: () async {
          VoicesSuccessGoogle voices = await TtsGoogle.getVoices();
          return VoicesSuccessUniversal(
              voices: voices.voices, code: voices.code, reason: voices.reason);
        },
        microsoft: () async {
          VoicesSuccessMicrosoft voices = await TtsMicrosoft.getVoices();
          return VoicesSuccessUniversal(
              voices: voices.voices, code: voices.code, reason: voices.reason);
        },
        amazon: () async {
          VoicesSuccessAmazon voices = await TtsAmazon.getVoices();
          return VoicesSuccessUniversal(
              voices: voices.voices, code: voices.code, reason: voices.reason);
        },
        provider: provider);
  }

  ///Converts text to speech and return audio file as [Uint8List].
  ///
  /// [ttsParams] request parameters
  ///
  /// Returns [AudioResponseMicrosoft]
  ///
  /// [AudioSuccessUniversal] request succeeded
  ///
  /// On failure returns one of the following:
  /// [AudioFailedBadRequestGoogle], [AudioFailedUnauthorizedGoogle], [AudioFailedUnsupportedGoogle], [AudioFailedTooManyRequestGoogle],
  /// [AudioFailedBadGatewayGoogle], [AudioFailedBadGatewayGoogle], [AudioFailedUnknownErrorGoogle],
  /// [AudioFailedBadRequestMicrosoft], [AudioFailedUnauthorizedMicrosoft], [AudioFailedUnsupportedMicrosoft], [AudioFailedTooManyRequestMicrosoft],
  /// [AudioFailedBadGatewayMicrosoft], [AudioFailedBadGatewayMicrosoft], [AudioFailedUnknownErrorMicrosoft],
  /// [AudioFailedBadRequestAmazon], [AudioFailedUnauthorizedAmazon], [AudioFailedUnsupportedAmazon], [AudioFailedTooManyRequestAmazon],
  /// [AudioFailedBadGatewayAmazon], [AudioFailedBadGatewayAmazon], [AudioFailedUnknownErrorAmazon]
  ///
  static Future<AudioSuccessUniversal> convertTts(
      TtsParamsUniversal params) async {
    return await handleProvider<Future<AudioSuccessUniversal>>(
        google: () async {
          AudioSuccessGoogle audio =
              await TtsGoogle.convertTts(TtsParamsMapper.toGoogle(params));
          return AudioSuccessUniversal(
              audio: audio.audio, code: audio.code, reason: audio.reason);
        },
        microsoft: () async {
          AudioSuccessMicrosoft audio = await TtsMicrosoft.convertTts(
              TtsParamsMapper.toMicrosoft(params));
          return AudioSuccessUniversal(
              audio: audio.audio, code: audio.code, reason: audio.reason);
        },
        amazon: () async {
          AudioSuccessAmazon audio =
              await TtsAmazon.convertTts(TtsParamsMapper.toAmazon(params));
          return AudioSuccessUniversal(
              audio: audio.audio, code: audio.code, reason: audio.reason);
        },
        provider: params.voice.provider);
  }

  static void _init(String provider, InitParamsGoogle? google,
      InitParamsMicrosoft? microsoft, InitParamsAmazon? amazon,
      [bool withLogs = true]) {
    _assertInitParams(provider, google, microsoft, amazon);
    _initLogs(withLogs);

    TtsUniversal._provider = provider.toLowerCase();
    Log.d("TtsUniversal provider set to: $provider");

    final initialisedProviders = [];

    if (!_initDone) {
      if (google != null) {
        TtsGoogle.init(params: google);
        initialisedProviders.add(TtsProviders.google);
      }

      if (microsoft != null) {
        TtsMicrosoft.init(params: microsoft);
        initialisedProviders.add(TtsProviders.microsoft);
      }

      if (amazon != null) {
        TtsAmazon.init(params: amazon);
        initialisedProviders.add(TtsProviders.amazon);
      }

      _initDone = true;
      Log.d("TtsUniversal initialised for: ${initialisedProviders.join(', ')}");
    } else {
      Log.d("TtsUniversal initialised already!");
    }
  }

  static void _assertInitParams(String provider, InitParamsGoogle? google,
      InitParamsMicrosoft? microsoft, InitParamsAmazon? amazon) {
    if (google == null && microsoft == null && amazon == null) {
      throw Exception(
          "Initialization parameters are missing for all providers.");
    }

    switch (provider) {
      case TtsProviders.google:
        assert(google != null, 'Google initialization parameters are missing.');
        break;
      case TtsProviders.microsoft:
        assert(microsoft != null,
            'Microsoft initialization parameters are missing.');
        break;
      case TtsProviders.amazon:
        assert(amazon != null, 'Amazon initialization parameters are missing.');
        break;
      case TtsProviders.combine:
        break;
      default:
        throw Exception("Unknown provider: $provider");
    }
  }

  static T handleProvider<T>({
    T Function()? google,
    T Function()? microsoft,
    T Function()? amazon,
    T Function()? combine,
    String? provider,
  }) {
    switch (provider ?? _provider) {
      case TtsProviders.google:
        assert(google != null, 'Google handle function is missing.');
        return google!();
      case TtsProviders.microsoft:
        assert(microsoft != null, 'Microsoft handle function is missing.');
        return microsoft!();
      case TtsProviders.amazon:
        assert(amazon != null, 'Amazon handle function is missing.');
        return amazon!();
      case TtsProviders.combine:
        assert(combine != null, 'Combine handle function is missing.');
        return combine!();
      default:
        throw Exception("Unknown provider: $_provider");
    }
  }

  static void _initLogs(bool withLogs) =>
      withLogs ? Log.enable() : Log.disable();

  static bool isProviderInitDone(String provider) {
    switch (provider) {
      case TtsProviders.google:
        return TtsGoogle.initDone;
      case TtsProviders.microsoft:
        return TtsMicrosoft.initDone;
      case TtsProviders.amazon:
        return TtsAmazon.initDone;
      default:
        throw Exception("Unknown provider: $provider");
    }
  }

  static bool get initDone => _initDone;
}
