import 'package:cloud_text_to_speech/src/microsoft/audio/audio_request_param.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voice_model.dart';

class TtsParamsMicrosoft extends AudioRequestParamsMicrosoft {
  /// Rate is the speed at which the voice will speak.
  ///
  /// * `rate` default to default.

  TtsParamsMicrosoft({
    required VoiceMicrosoft voice,
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
