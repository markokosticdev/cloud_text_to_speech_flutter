import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

void main() async {
  try {
    TtsMicrosoft.init(
        params: InitParamsMicrosoft(
            subscriptionKey: "SUBSCRIPTION-KEY", region: "eastus"),
        withLogs: true);

    // Get voices
    final voicesResponse = await TtsMicrosoft.getVoices();
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
        '<break time="2s" bre="34"/>Microsoft <some time="3s"/> Text-to-Speech API is awesome';

    TtsParamsMicrosoft ttsParams = TtsParamsMicrosoft(
        voice: voice,
        audioFormat: AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
        text: text,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponse = await TtsMicrosoft.convertTts(ttsParams);

    //Get the audio bytes.
    final audioBytes = ttsResponse.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytes.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");
  } catch (e) {
    print("Something went wrong: $e");
  }
}
