import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

void main() async {
  try {
    TtsGoogle.init(params: InitParamsGoogle(apiKey: "API-KEY"), withLogs: true);

    // Get voices
    final voicesResponse = await TtsGoogle.getVoices();
    final voices = voicesResponse.voices;

    //Print all voices
    print(voices);

    //Pick an English Voice
    final voice = voices
        .where((element) => element.locale.code.startsWith("en-"))
        .toList(growable: false)
        .first;

    //Generate Audio for a text
    final text =
        '<break time="2s" bre="34"/>Google <top>and</top> Microsoft <some time="3s"/> Text-to-Speech API are awesome';

    TtsParamsGoogle ttsParams = TtsParamsGoogle(
        voice: voice,
        audioFormat: AudioOutputFormatGoogle.mp3,
        text: text,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponse = await TtsGoogle.convertTts(ttsParams);

    //Get the audio bytes.
    final audioBytes = ttsResponse.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytes.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");
  } catch (e) {
    print("Something went wrong: $e");
  }
}
