import 'package:cloud_text_to_speech/src/google/voices/voice_model.dart';

class AudioRequestParamsGoogle {
  final VoiceGoogle voice;
  final String text;
  final String audioFormat;
  final String rate;
  final String pitch;

  AudioRequestParamsGoogle({
    required this.voice,
    required this.text,
    required this.audioFormat,
    required this.rate,
    required this.pitch,
  });
}
