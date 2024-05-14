# Cloud Text-To-Speech

[![Pub Version](https://img.shields.io/pub/v/cloud_text_to_speech.svg?logo=dart)](https://pub.dev/packages/cloud_text_to_speech)
[![Pub Likes](https://img.shields.io/pub/likes/cloud_text_to_speech.svg?logo=dart)](https://pub.dev/packages/cloud_text_to_speech)
[![Pub Popularity](https://img.shields.io/pub/popularity/cloud_text_to_speech.svg?logo=dart)](https://pub.dev/packages/cloud_text_to_speech)
[![Pub Points](https://img.shields.io/pub/points/cloud_text_to_speech.svg?logo=dart)](https://pub.dev/packages/cloud_text_to_speech)
[![GitHub License](https://img.shields.io/github/license/markokosticdev/cloud_text_to_speech_flutter.svg?logo=github)](https://github.com/markokosticdev/cloud_text_to_speech_flutter?tab=BSD-2-Clause-1-ov-file)
[![GitHub Sponsor](https://img.shields.io/badge/GitHub%20Sponsor-donate-yellow.svg?logo=github)](https://github.com/sponsors/markokosticdev)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-donate-yellow.svg?logo=buy-me-a-coffee)](https://www.buymeacoffee.com/markokostich)

Single interface to Google, Microsoft, and Amazon Text-To-Speech.
Flutter implementation of:

- [Google Cloud Text-To-Speech API](https://cloud.google.com/text-to-speech)
- [Microsoft Azure Cognitive Text-To-Speech API](https://azure.microsoft.com/en-us/services/cognitive-services/text-to-speech)
- [Amazon Polly API](https://aws.amazon.com/polly)

## Features

- Universal implementation for accessing all providers with one interface.
- Separate implementation for every provider so we could access every functionality.
- Sanitize SSML input per provider so we send only supported SSML elements.
- Locale names in English and native language so we could display language selector.
- Fake name generation for Google voices that are generated randomly based on voice locale.
- Accessible configurable output format (per provider), rate, and pitch.

## Getting Started

There are essentially two ways to use Cloud Text-To-Speech:

- Universal: Using TtsUniversal to be able to configure the TTS provider dynamically and us it.
  - Single: Using `TtsProviders.google`, `TtsProviders.microsoft`, `TtsProviders.amazon` to use the single provider at a time.
  - Combine: Using `TtsProviders.combine` to combine all providers and get all voices at once.
- Provider: Using TtsGoogle, TtsMicrosoft, TtsAmazon to get the most from provider's API.

### Universal(Single)

To init configuration use:

```dart
//Do init once and run it before any other method
TtsUniversal.init(
  provider: TtsProviders.amazon,
  googleParams: InitParamsGoogle(apiKey: 'API-KEY'),
  microsoftParams: InitParamsMicrosoft(
  subscriptionKey: 'SUBSCRIPTION-KEY', region: 'eastus'),
  amazonParams: InitParamsAmazon(
  keyId: 'KEY-ID', accessKey: 'ACCESS-KEY', region: 'us-east-1'),
  withLogs: true
);
```

To change provider use:

```dart
TtsUniversal.setProvider(TtsProviders.microsoft);
```

To get the list of all voices use:

```dart
//Get voices
final voicesResponse = await TtsUniversal.getVoices();

final voices = voicesResponse.voices;

//Print all available voices
print(voices);

//Pick an English Voice
final voice = voices
    .where((element) => element.locale.code.startsWith("en-"))
    .toList(growable: false)
    .first;
```

To convert TTS and get audio use:

```dart
//Generate Audio for a text
const text = "Amazon, Microsoft and Google Text-to-Speech API are awesome";

final ttsParams = TtsParamsUniversal(
        voice: voice, 
        audioFormat: AudioOutputFormatUniversal.mp3_64k, 
        text: text, 
        rate: 'slow', //optional
        pitch: 'default' //optional
      );

final ttsResponse = await TtsUniversal.convertTts(ttsParams);

//Get the audio bytes.
final audioBytes = ttsResponse.audio.buffer.asByteData();
```

### Universal(Combine)

To init configuration use:

```dart
//Do init once and run it before any other method
TtsUniversal.init(
  provider: TtsProviders.combine,
  googleParams: InitParamsGoogle(apiKey: 'API-KEY'),
  microsoftParams: InitParamsMicrosoft(
  subscriptionKey: 'SUBSCRIPTION-KEY', region: 'eastus'),
  amazonParams: InitParamsAmazon(
  keyId: 'KEY-ID', accessKey: 'ACCESS-KEY', region: 'us-east-1'),
  withLogs: true
);
```

To change provider use:

```dart
TtsUniversal.setProvider(TtsProviders.combine);
```

To get the list of all voices use:

```dart
//Get voices
final voicesResponse = await TtsUniversal.getVoices();

final voices = voicesResponse.voices;

//Print all available voices
print(voices);

//Pick an English Voice
final voice = voices
    .where((element) => element.locale.code.startsWith("en-"))
    .toList(growable: false)
    .first;
```

To convert TTS and get audio use:

```dart
//Generate Audio for a text
const text = "Amazon, Microsoft and Google Text-to-Speech API are awesome";

final ttsParams = TtsParamsUniversal(
        voice: voice, 
        audioFormat: AudioOutputFormatUniversal.mp3_64k, 
        text: text, 
        rate: 'slow', //optional
        pitch: 'default' //optional
);

final ttsResponse = await TtsUniversal.convertTts(ttsParams);

//Get the audio bytes.
final audioBytes = ttsResponse.audio.buffer.asByteData();
```

### Google

To init configuration use:

```dart
//Do init once and run it before any other method
TtsGoogle.init(
  params: InitParamsGoogle(apiKey: "API-KEY"), 
  withLogs:true
);
```

To get the list of all voices use:

```dart
//Get voices
final voicesResponse = await TtsGoogle.getVoices();

final voices = voicesResponse.voices;

//Print all voices
print(voices);

//Pick an English Voice
final voice = voices
    .where((element) => element.locale.code.startsWith("en-"))
    .toList(growable: false)
    .first;
```

To convert TTS and get audio use:

```dart
//Generate Audio for a text
final text = '<speak>Google<break time="2s"> Speech Service Text-to-Speech API is awesome!</speak>';

TtsParamsGoogle ttsParams = TtsParamsGoogle(
        voice: voice, 
        audioFormat: AudioOutputFormatGoogle.mp3, 
        text: text, 
        rate: 'slow', //optional
        pitch: 'default' //optional
      );

final ttsResponse = await TtsGoogle.convertTts(ttsParams);

//Get the audio bytes.
final audioBytes = ttsResponse.audio.buffer.asByteData();
```

### Microsoft

To init configuration use:

```dart
//Do init once and run it before any other method
TtsMicrosoft.init(
  params: InitParamsMicrosoft(
  subscriptionKey: "SUBSCRIPTION-KEY", region: "eastus"),
  withLogs: true
);
```

To get the list of all voices use:

```dart
//Get voices
final voicesResponse = await TtsMicrosoft.getVoices();

final voices = voicesResponse.voices;

//Print all voices
print(voices);

//Pick an English Voice
final voice = voices
    .where((element) => element.locale.code.startsWith("en-"))
    .toList(growable: false)
    .first;
```

To convert TTS and get audio use:

```dart
//Generate Audio for a text
final text = '<speak>Microsoft<break time="2s"> Speech Service Text-to-Speech API is awesome!</speak>';

TtsParamsMicrosoft ttsParams = TtsParamsMicrosoft(
        voice: voice, 
        audioFormat: AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3, 
        text: text, 
        rate: 'slow', //optional
        pitch: 'default' //optional
      );

final ttsResponse = await TtsMicrosoft.convertTts(ttsParams);

//Get the audio bytes.
final audioBytes = ttsResponse.audio.buffer.asByteData();
```

### Amazon

To init configuration use:

```dart
//Do init once and run it before any other method
TtsAmazon.init(
  params: InitParamsAmazon(
    keyId: 'KEY-ID', 
    accessKey: 'ACCESS-KEY', 
    region: 'us-east-1'
  ),
  withLogs: true
);
```

To get the list of all voices use:

```dart
//Get voices
final voicesResponse = await TtsAmazon.getVoices();

final voices = voicesResponse.voices;

//Print all voices
print(voices);

//Pick an English Voice
final voice = voices
    .where((element) => element.locale.code.startsWith("en-"))
    .toList(growable: false)
    .first;
```

To convert TTS and get audio use:

```dart
//Generate Audio for a text
final text = '<speak>Amazon<break time="2s"> Speech Service Text-to-Speech API is awesome!</speak>';

TtsParamsAmazon ttsParams = TtsParamsAmazon(
        voice: voice, 
        audioFormat: AudioOutputFormatAmazon.audio48Khz192kBitrateMonoMp3, 
        text: text, 
        rate: 'slow', //optional
        pitch: 'default' //optional
);

final ttsResponse = await TtsAmazon.convertTts(ttsParams);

//Get the audio bytes.
final audioBytes = ttsResponse.audio.buffer.asByteData();
```

## Notes

There are things you should take care of:

- Securing of your API keys and credentials, they could be extracted from your mobile or web app.
- Sometimes Amazon Polly is not working in emulator, so you could get 403 error.
- For fixing SSML/XML before passing it to TTS Params, you could use
  the [xml](https://pub.dev/packages/xml) package's,
  methods `XmlDocument.parse(ssml).toXmlString()`.
- Audio has uniform format for all providers, it is Uint8List that you could use to play it or save
  it to file.
- Some player packages that are good fit are: [audioplayers](https://pub.dev/packages/audioplayers)
  and [assets_audio_player](https://pub.dev/packages/assets_audio_player).
