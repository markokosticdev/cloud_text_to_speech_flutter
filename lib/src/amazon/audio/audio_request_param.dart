import 'package:cloud_text_to_speech/src/amazon/voices/voice_model.dart';

class AudioRequestParamsAmazon {
  final VoiceAmazon voice;
  final String text;
  final String audioFormat;
  final String rate;
  final String pitch;

  AudioRequestParamsAmazon({
    required this.voice,
    required this.text,
    required this.audioFormat,
    required this.rate,
    required this.pitch,
  });
}
