import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

void main() async {
  try {
    TtsMicrosoft.init(
        subscriptionKey: "SUBSCRIPTION-KEY", region: "eastus", withLogs: true);

    // Get available voices
    final voicesResponseMicrosoft = await TtsMicrosoft.getVoices();
    final voicesMicrosoft = voicesResponseMicrosoft.voices;

    //Print all available voices
    print("$voicesMicrosoft");

    //Pick an English Voice
    final voiceMicrosoft = voicesResponseMicrosoft.voices
        .where((element) => element.locale.startsWith("en-"))
        .toList(growable: false)
        .first;

    //Generate Audio for a text
    final textMicrosoft = "Microsoft Text-to-Speech API is awesome";

    TtsParamsMicrosoft paramsMicrosoft = TtsParamsMicrosoft(
        voice: voiceMicrosoft,
        audioFormat: AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
        text: textMicrosoft,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponseMicrosoft = await TtsMicrosoft.convertTts(paramsMicrosoft);

    //Get the audio bytes.
    final audioBytesMicrosoft = ttsResponseMicrosoft.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytesMicrosoft.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");
  } catch (e) {
    print("Something went wrong: $e");
  }
}
