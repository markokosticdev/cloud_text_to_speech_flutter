import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

void main() async {
  try {
    TtsUniversal.init(
        provider: 'microsoft',
        google: InitParamsGoogle(apiKey: 'API-KEY'),
        microsoft: InitParamsMicrosoft(
            subscriptionKey: 'SUBSCRIPTION-KEY', region: 'eastus'),
        withLogs: true);

    // Get available voices
    final voicesResponseUniversal = await TtsUniversal.getVoices();
    final voicesUniversal = voicesResponseUniversal.voices;

    //Print all available voices
    print("$voicesUniversal");

    //Pick an English Voice
    final voiceUniversal = voicesResponseUniversal.voices
        .where((element) => element.locale.startsWith("en-"))
        .toList(growable: false)
        .first;

    //Generate Audio for a text
    final textUniversal = "Google and Microsoft Text-to-Speech API are awesome";

    TtsParamsUniversal paramsUniversal = TtsParamsUniversal(
        voice: voiceUniversal,
        audioFormatGoogle: AudioOutputFormatGoogle.linear16,
        audioFormatMicrosoft:
            AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
        text: textUniversal,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponseUniversal = await TtsUniversal.convertTts(paramsUniversal);

    //Get the audio bytes.
    final audioBytesUniversal = ttsResponseUniversal.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytesUniversal.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");

    TtsUniversal.setProvider(provider: 'google');

    final voicesResponseUniversal2 = await TtsUniversal.getVoices();
    final voicesUniversal2 = voicesResponseUniversal2.voices;

    //Print all available voices
    print("$voicesUniversal2");

    //Pick an English Voice
    final voiceUniversal2 = voicesResponseUniversal2.voices
        .where((element) => element.locale.startsWith("en-"))
        .toList(growable: false)
        .first;

    //Generate Audio for a text
    final textUniversal2 =
        "Google and Microsoft Text-to-Speech API are awesome";

    TtsParamsUniversal paramsUniversal2 = TtsParamsUniversal(
        voice: voiceUniversal2,
        audioFormatGoogle: AudioOutputFormatGoogle.linear16,
        audioFormatMicrosoft:
            AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
        text: textUniversal2,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponseUniversal2 =
        await TtsUniversal.convertTts(paramsUniversal2);

    //Get the audio bytes.
    final audioBytesUniversal2 = ttsResponseUniversal2.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytesUniversal2.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");
  } catch (e) {
    print("Something went wrong: $e");
  }
}
