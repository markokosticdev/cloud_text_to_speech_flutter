import 'package:cloud_text_to_speech/src/google/audio/audio_request_param.dart';
import 'package:cloud_text_to_speech/src/google/voices/voice_model.dart';

class TtsParamsGoogle extends AudioRequestParamsGoogle {
  /// Rate is the speed at which the voice will speak.
  ///
  /// * `rate` default to default.

  TtsParamsGoogle({
    required VoiceGoogle voice,
    required String audioFormat,
    required String text,
    String? rate,
    String? pitch,
  }) : super(
          voice: voice,
          audioFormat: audioFormat,
          text: text,
          rate: rate ?? 'default',
          pitch: pitch ?? 'default',
        );
}
