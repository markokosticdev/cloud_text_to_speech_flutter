import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/microsoft/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_responses.dart';
import 'package:cloud_text_to_speech/src/universal/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/universal/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voices_responses.dart';

///Helper class for Universal TTS requests
class TtsUniversal {
  static late String provider;

  static void setProvider({required String provider}) {
    TtsUniversal.provider = provider;
  }

  /// MUST be called first before any other call is made.
  ///
  static void init(
          {required String provider,
          required InitParamsGoogle google,
          required InitParamsMicrosoft microsoft,
          bool withLogs = true}) =>
      _init(provider, google, microsoft, withLogs);

  ///Get voices
  ///
  ///Returns [VoicesSuccessUniversal]
  ///
  /// [VoicesSuccessUniversal] request succeeded
  ///
  /// On failure throws one of the following:
  /// [VoicesFailedBadRequestGoogle], [VoicesFailedBadRequestGoogle], [VoicesFailedUnauthorizedGoogle],
  /// [VoicesFailedTooManyRequestsGoogle], [VoicesFailedBadGateWayGoogle], [VoicesFailedUnkownErrorGoogle]
  /// [VoicesFailedBadRequestMicrosoft], [VoicesFailedBadRequestMicrosoft], [VoicesFailedUnauthorizedMicrosoft],
  /// [VoicesFailedTooManyRequestsMicrosoft], [VoicesFailedBadGateWayMicrosoft], [VoicesFailedUnkownErrorMicrosoft]
  ///
  static Future<VoicesSuccessUniversal> getVoices() async {
    switch (provider) {
      case 'microsoft':
        VoicesSuccessMicrosoft voices = await TtsMicrosoft.getVoices();
        return VoicesSuccessUniversal(
            voices: voices.voices, code: voices.code, reason: voices.reason);
      case 'google':
      default:
        VoicesSuccessGoogle voices = await TtsGoogle.getVoices();
        return VoicesSuccessUniversal(
            voices: voices.voices, code: voices.code, reason: voices.reason);
    }
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
  /// [AudioFailedBadRequestGoogle], [AudioFailedUnauthorizedGoogle], [AudioFailedUnsupportedGoogle], [AudioFailedTooManyRequestGoogle],
  /// [AudioFailedBadGatewayGoogle], [AudioFailedBadGatewayGoogle], [AudioFailedUnkownErrorGoogle]
  /// [AudioFailedBadRequestMicrosoft], [AudioFailedUnauthorizedMicrosoft], [AudioFailedUnsupportedMicrosoft], [AudioFailedTooManyRequestMicrosoft],
  /// [AudioFailedBadGatewayMicrosoft], [AudioFailedBadGatewayMicrosoft], [AudioFailedUnkownErrorMicrosoft]
  ///
  static Future<AudioSuccessUniversal> convertTts(
      TtsParamsUniversal ttsParams) async {
    switch (provider) {
      case 'microsoft':
        TtsParamsMicrosoft ttsParamsMicrosoft = TtsParamsMicrosoft(
            voice: ttsParams.voice as VoiceMicrosoft,
            audioFormat: ttsParams.audioFormatMicrosoft,
            text: ttsParams.text,
            rate: ttsParams.rate,
            pitch: ttsParams.pitch);
        AudioSuccessMicrosoft audio =
            await TtsMicrosoft.convertTts(ttsParamsMicrosoft);
        return AudioSuccessUniversal(
            audio: audio.audio, code: audio.code, reason: audio.reason);
      case 'google':
      default:
        TtsParamsGoogle ttsParamsGoogle = TtsParamsGoogle(
            voice: ttsParams.voice as VoiceGoogle,
            audioFormat: ttsParams.audioFormatGoogle,
            text: ttsParams.text,
            rate: ttsParams.rate,
            pitch: ttsParams.pitch);
        AudioSuccessGoogle audio = await TtsGoogle.convertTts(ttsParamsGoogle);
        return AudioSuccessUniversal(
            audio: audio.audio, code: audio.code, reason: audio.reason);
    }
  }

  static void _init(
      String provider, InitParamsGoogle google, InitParamsMicrosoft microsoft,
      [bool withLogs = true]) {
    TtsUniversal.provider = provider;
    TtsGoogle.init(apiKey: google.apiKey);
    TtsMicrosoft.init(
        subscriptionKey: microsoft.subscriptionKey, region: microsoft.region);
  }
}
