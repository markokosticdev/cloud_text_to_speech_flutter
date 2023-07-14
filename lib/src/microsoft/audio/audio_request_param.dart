import 'package:cloud_text_to_speech/src/microsoft/voices/voice_model.dart';

class AudioRequestParamsMicrosoft {
  final VoiceMicrosoft voice;
  final String text;
  final String audioFormat;
  final String rate;
  final String pitch;

  AudioRequestParamsMicrosoft({
    required this.voice,
    required this.text,
    required this.audioFormat,
    required this.rate,
    required this.pitch,
  });
}
