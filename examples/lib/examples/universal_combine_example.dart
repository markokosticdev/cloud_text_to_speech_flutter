import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

void main() async {
  try {
    TtsUniversal.init(
        provider: TtsProviders.combine,
        googleParams: InitParamsGoogle(apiKey: 'API-KEY'),
        microsoftParams: InitParamsMicrosoft(
            subscriptionKey: 'SUBSCRIPTION-KEY', region: 'eastus'),
        amazonParams: InitParamsAmazon(
            keyId: 'KEY-ID', accessKey: 'ACCESS-KEY', region: 'us-east-1'),
        withLogs: true);

    final voicesResponse = await TtsUniversal.getVoices();
    final voices = voicesResponse.voices;

    //Print all available voices
    print(voices);

    //Pick an English Voice
    final voice = voices
        .where((element) => element.locale.code.startsWith("en-"))
        .toList(growable: false)
        .first;

    //Generate Audio for a text
    final text =
        '<break time="2s" bre="34"/>Combine Universal <some time="3s"/> Text-to-Speech API is awesome';

    final ttsParams = TtsParamsUniversal(
        voice: voice,
        audioFormat: AudioOutputFormatUniversal.mp3_64k,
        text: text,
        rate: 'slow',
        // optional
        pitch: 'default' // optional
        );

    final ttsResponse = await TtsUniversal.convertTts(ttsParams);

    //Get the audio bytes.
    final audioBytes = ttsResponse.audio.buffer
        .asByteData(); // you can save to a file for playback
    print(
        "Audio size: ${(audioBytes.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb");
  } catch (e) {
    print("Something went wrong: $e");
  }
}
