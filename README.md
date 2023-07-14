# Cloud Text-To-Speech
Single interface to Google, Microsoft, and Amazon Text-To-Speech.
Flutter implementation of: 
- [Google Cloud Text-To-Speech API](https://cloud.google.com/text-to-speech).
- [Microsoft Azure Cognitive Text-To-Speech API](https://azure.microsoft.com/en-us/services/cognitive-services/text-to-speech).
- Amazon Polly API (soon)


## Features
- Universal implementation for accessing all providers with one interface
- Separate implementation for every provider so we could access every functionality
- Sanitize SSML input per provider so we send only supported SSML elements
- Locale names in English and native language so we could display language selector
- Fake name generation for Google voices that are generated randomly based on voice locale
- Accessible configurable output format (per provider), rate, and pitch


## Getting Started

There are two ways to use Cloud Text-To-Speech:
- Universal: Using TtsUniversal to be able to configure the TTS provider dynamically and us it
- Provider: Using TtsGoogle, TtsMicrosoft, TtsAmazon(soon) to get the most from provider's API

### Universal

To init configuration use:
```dart
  //Do init once and run it before any other method
  TtsUniversal.init(
    provider: 'google',
    google: InitParamsGoogle(apiKey: 'API-KEY'),
    microsoft: InitParamsMicrosoft(subscriptionKey: 'SUBSCRIPTION-KEY', region: 'eastus'),
    withLogs: true);
```

To change provider use:
```dart
    TtsUniversal.setProvider(provider: 'microsoft');
```

To get the list of all voices use:

```dart
    // Get voices
    final voicesResponse = await TtsUniversal.getVoices();
    final voices = voicesResponse.voices; 
    
    //Print all available voices
    print(voices);

    //Pick an English Voice
    final voice = voicesResponse.voices
      .where((element) => element.locale.startsWith("en-"))
      .toList(growable: false)
      .first;
```

To convert TTS and get audio use:

```dart
   //Generate Audio for a text
  final text = '<speak>Google and Microsoft<break time="2s"> Speech Service Text-to-Speech API are awesome!</speak>';

  TtsParamsUniversal params = TtsParamsUniversal(
      voice: voice,
      audioFormatGoogle: AudioOutputFormatGoogle.mp3,
      audioFormatMicrosoft: AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
      text: text,
      rate: 'slow', // optional
      pitch: 'default' // optional
  );

  final ttsResponse = await TtsUniversal.convertTts(params);

  //Get the audio bytes.
  final audioBytes = ttsResponse.audio.buffer.asByteData();
```


### Google

To init configuration use:
```dart
    //Do init once and run it before any other method
    TtsGoogle.init(
      apiKey: "API-KEY", 
      withLogs: true);
```

To get the list of all voices use:

```dart
    // Get voices
    final voicesResponse = await TtsGoogle.getVoices();
    final voices = voicesResponse.voices; 
    
    //Print all available voices
    print(voices);

    //Pick an English Voice
    final voice = voicesResponse.voices
      .where((element) => element.locale.startsWith("en-"))
      .toList(growable: false)
      .first;
```

To convert TTS and get audio use:

```dart
   //Generate Audio for a text
  final text = '<speak>Google<break time="2s"> Speech Service Text-to-Speech API is awesome!</speak>';

  TtsParamsGoogle params = TtsParamsGoogle(
      voice: voice,
      audioFormat: AudioOutputFormatGoogle.mp3,
      text: text,
      rate: 'slow', // optional
      pitch: 'default' // optional
  );

  final ttsResponse = await TtsGoogle.convertTts(params);

  //Get the audio bytes.
  final audioBytes = ttsResponse.audio.buffer.asByteData();
```


### Microsoft

To init configuration use:
```dart
  //Do init once and run it before any other method
  TtsMicrosoft.init(
    subscriptionKey: "SUBSCRIPTION-KEY", 
    region: "eastus", 
    withLogs: true);
```

To get the list of all voices use:

```dart
    // Get voices
    final voicesResponse = await TtsMicrosoft.getVoices();
    final voices = voicesResponse.voices; 
    
    //Print all available voices
    print(voices);

    //Pick an English Voice
    final voice = voicesResponse.voices
      .where((element) => element.locale.startsWith("en-"))
      .toList(growable: false)
      .first;
```

To convert TTS and get audio use:

```dart
   //Generate Audio for a text
  final text = '<speak>Microsoft<break time="2s"> Speech Service Text-to-Speech API is awesome!</speak>';

  TtsParamsMicrosoft params = TtsParamsMicrosoft(
      voice: voice,
      audioFormat: AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
      text: text,
      rate: 'slow', // optional
      pitch: 'default' // optional
  );

  final ttsResponse = await TtsMicrosoft.convertTts(params);

  //Get the audio bytes.
  final audioBytes = ttsResponse.audio.buffer.asByteData();
```