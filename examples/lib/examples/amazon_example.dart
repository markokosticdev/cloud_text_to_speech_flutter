import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

void main() async {
  try {
    TtsAmazon.init(
        params: InitParamsAmazon(
            keyId: 'KEY-ID', accessKey: 'ACCESS-KEY', region: 'us-east-1'),
        withLogs: true);

    // Get voices
    final voicesResponse = await TtsAmazon.getVoices();
    final voices = voicesResponse.voices;

    //Print all voices
    print(voices);

    //Pick an English Voice
    final voice = voices
        .where((element) => element.locale.code.startsWith("en-"))
        .toList(growable: false)
        .first;

    //Generate Audio for a text
    final text = "Amazon Text-to-Speech API is awesome";

    TtsParamsAmazon ttsParams = TtsParamsAmazon(
        voice: voice,
        audioFormat: AudioOutputFormatAmazon.mp3,
        text: text,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponse = await TtsAmazon.convertTts(ttsParams);

    //Get the audio bytes.
    final audioBytes = ttsResponse.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytes.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");
  } catch (e) {
    print("Something went wrong: $e");
  }
}
