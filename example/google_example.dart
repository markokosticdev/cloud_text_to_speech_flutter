import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

void main() async {
  try {
    TtsGoogle.init(apiKey: "API-KEY", withLogs: true);

    // Get voices
    final voicesResponseGoogle = await TtsGoogle.getVoices();
    final voicesGoogle = voicesResponseGoogle.voices;

    //Print all voices
    print(voicesGoogle);

    //Pick an English Voice
    final voiceGoogle = voicesResponseGoogle.voices
        .where((element) => element.locale.startsWith("en-"))
        .toList(growable: false)
        .first;

    //Generate Audio for a text
    final textGoogle =
        '<break time="2s" bre="34"/>Google <top>and</top> Microsoft <some time="3s"/> Text-to-Speech API are awesome';

    TtsParamsGoogle paramsGoogle = TtsParamsGoogle(
        voice: voiceGoogle,
        audioFormat: AudioOutputFormatGoogle.linear16,
        text: textGoogle,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponseGoogle = await TtsGoogle.convertTts(paramsGoogle);

    //Get the audio bytes.
    final audioBytesGoogle = ttsResponseGoogle.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytesGoogle.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");
  } catch (e) {
    print("Something went wrong: $e");
  }
}
