import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud TTS Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Cloud TTS Test Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final InitParamsGoogle initParamsGoogle =
      InitParamsGoogle(apiKey: dotenv.env['GOOGLE_API_KEY']!);
  final InitParamsMicrosoft initParamsMicrosoft = InitParamsMicrosoft(
      subscriptionKey: dotenv.env['MICROSOFT_SUBSCRIPTION_KEY']!,
      region: dotenv.env['MICROSOFT_REGION']!);
  final InitParamsAmazon initParamsAmazon = InitParamsAmazon(
      keyId: dotenv.env['AMAZON_KEY_ID']!,
      accessKey: dotenv.env['AMAZON_ACCESS_KEY']!,
      region: dotenv.env['AMAZON_REGION']!);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String testTitle = 'Press any Floating Action Button to Test';
  List<Widget> voices = [];
  String audioSize = '';

  Future<void> _tts(String provider) async {
    //Generate Audio for a text
    String text = '''
  <mstts:express-as style="cheerful" styledegree="2"> That'd be just amazing! </mstts:express-as>
''';
    switch (provider) {
      case 'google':
        setState(() {
          testTitle = 'Google TTS Test';
        });

        try {
          TtsGoogle.init(params: widget.initParamsGoogle, withLogs: true);

          // Get voices
          final voicesResponseGoogle = await TtsGoogle.getVoices();
          final voicesGoogle = voicesResponseGoogle.voices;

          //Set all voices
          setState(() {
            voices = voicesGoogle
                .map((e) => Text(
                    '${e.locale.name} - ${e.locale.code}: ${e.name} (${e.gender}) - ${e.engines.join(", ")}'))
                .toList();
          });

          //Pick an English Voice
          final voiceGoogle = voicesResponseGoogle.voices
              .where((element) => element.locale.code.startsWith("en-"))
              .toList(growable: false)
              .first;

          TtsParamsGoogle paramsGoogle = TtsParamsGoogle(
              voice: voiceGoogle,
              audioFormat: AudioOutputFormatGoogle.linear16,
              text: text,
              rate: 'slow',
              // optional
              pitch: 'default' // optional
              );

          final ttsResponseGoogle = await TtsGoogle.convertTts(paramsGoogle);

          //Get the audio bytes.
          final audioBytesGoogle = ttsResponseGoogle.audio.buffer
              .asByteData(); // you can save to a file for playback

          setState(() {
            audioSize =
                "${(audioBytesGoogle.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb";
          });
        } catch (e) {
          rethrow;
          print("Something went wrong: $e");
        }
        break;
      case 'microsoft':
        setState(() {
          testTitle = 'Microsoft TTS Test';
        });

        try {
          TtsMicrosoft.init(params: widget.initParamsMicrosoft, withLogs: true);

          // Get voices
          final voicesResponseMicrosoft = await TtsMicrosoft.getVoices();
          final voicesMicrosoft = voicesResponseMicrosoft.voices;

          //Set all voices
          setState(() {
            voices = voicesMicrosoft
                .map((e) => Text(
                    '${e.locale.name} - ${e.locale.code}: ${e.name} (${e.gender}) - ${e.engines.join(", ")}'))
                .toList();
          });
          //Pick an English Voice
          final voiceMicrosoft = voicesResponseMicrosoft.voices
              .where((element) => element.locale.code.startsWith("en-"))
              .toList(growable: false)
              .first;

          TtsParamsMicrosoft paramsMicrosoft = TtsParamsMicrosoft(
              voice: voiceMicrosoft,
              audioFormat:
                  AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
              text: text,
              rate: 'slow',
              // optional
              pitch: 'default' // optional
              );

          final ttsResponseMicrosoft =
              await TtsMicrosoft.convertTts(paramsMicrosoft);

          //Get the audio bytes.
          final audioBytesMicrosoft = ttsResponseMicrosoft.audio.buffer
              .asByteData(); // you can save to a file for playback
          setState(() {
            audioSize =
                "${(audioBytesMicrosoft.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb";
          });
        } catch (e) {
          print("Something went wrong: $e");
        }
        break;
      case 'amazon':
        setState(() {
          testTitle = 'Amazon TTS Test';
        });

        try {
          TtsAmazon.init(params: widget.initParamsAmazon, withLogs: true);

          // Get voices
          final voicesResponseAmazon = await TtsAmazon.getVoices();
          final voicesAmazon = voicesResponseAmazon.voices;

          //Set all voices
          setState(() {
            voices = voicesAmazon
                .map((e) => Text(
                    '${e.locale.name} - ${e.locale.code}: ${e.name} (${e.gender}) - ${e.engines.join(", ")}'))
                .toList();
          });

          //Pick an English Voice
          final voiceAmazon = voicesResponseAmazon.voices
              .where((element) => element.locale.code.startsWith("en-"))
              .toList(growable: false)
              .first;

          TtsParamsAmazon paramsAmazon = TtsParamsAmazon(
              voice: voiceAmazon,
              audioFormat: AudioOutputFormatAmazon.mp3,
              text: text,
              rate: 'slow',
              // optional
              pitch: 'default' // optional
              );

          final ttsResponseAmazon = await TtsAmazon.convertTts(paramsAmazon);

          //Get the audio bytes.
          final audioBytesAmazon = ttsResponseAmazon.audio.buffer
              .asByteData(); // you can save to a file for playback
          setState(() {
            audioSize =
                "${(audioBytesAmazon.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb";
          });
        } catch (e) {
          print("Something went wrong: $e");
        }
        break;
      case 'universal-single':
        setState(() {
          testTitle = 'Universal(Single) TTS Test';
        });

        try {
          TtsUniversal.init(
              provider: 'amazon',
              googleParams: widget.initParamsGoogle,
              microsoftParams: widget.initParamsMicrosoft,
              amazonParams: widget.initParamsAmazon,
              withLogs: true);

          for (String provider in ['amazon', 'microsoft', 'google']) {
            TtsUniversal.setProvider(provider);

            final voicesResponse = await TtsUniversal.getVoices();
            final voicesUniversal = voicesResponse.voices;

            //Set all voices
            setState(() {
              voices = voicesUniversal
                  .map((e) => Text(
                      '${e.locale.name} - ${e.locale.code}: ${e.name} (${e.gender}) - ${e.engines.join(", ")}'))
                  .toList();
            });

            //Pick an English Voice
            final voiceUniversal = voicesUniversal
                .where((element) => element.locale.code.startsWith("en-"))
                .toList(growable: false)
                .first;

            final ttsParams = TtsParamsUniversal(
                voice: voiceUniversal,
                audioFormat: AudioOutputFormatUniversal.mp3_64k,
                text: text,
                rate: 'slow', // optional
                pitch: 'default' // optional
                );

            final ttsResponse = await TtsUniversal.convertTts(ttsParams);

            //Get the audio bytes.
            final audioBytesUniversal = ttsResponse.audio.buffer
                .asByteData(); // you can save to a file for playback
            setState(() {
              audioSize =
                  "${(audioBytesUniversal.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb";
            });

            await Future.delayed(const Duration(seconds: 2));
          }
        } catch (e) {
          print("Something went wrong: $e");
        }
        break;
      case 'universal-combine':
        setState(() {
          testTitle = 'Universal(Combine) TTS Test';
        });

        try {
          TtsUniversal.init(
              provider: TtsProviders.combine,
              googleParams: widget.initParamsGoogle,
              microsoftParams: widget.initParamsMicrosoft,
              amazonParams: widget.initParamsAmazon,
              withLogs: true);

          final voicesResponse = await TtsUniversal.getVoices();
          final voicesUniversal = voicesResponse.voices;

          //Set all voices
          setState(() {
            voices = voicesUniversal
                .map((e) => Text(
                    '${e.locale.name} - ${e.locale.code}: ${e.name} (${e.gender}) - ${e.engines.join(", ")} - ${e.provider}'))
                .toList();
          });

          //Pick an English Voice
          final voiceUniversal = voicesUniversal
              .where((element) => element.locale.code.startsWith("en-"))
              .toList(growable: false)
              .first;

          final ttsParams = TtsParamsUniversal(
              voice: voiceUniversal,
              audioFormat: AudioOutputFormatUniversal.mp3_64k,
              text: text,
              rate: 'slow', // optional
              pitch: 'default' // optional
              );

          final ttsResponse = await TtsUniversal.convertTts(ttsParams);

          //Get the audio bytes.
          final audioBytesUniversal = ttsResponse.audio.buffer
              .asByteData(); // you can save to a file for playback
          setState(() {
            audioSize =
                "${(audioBytesUniversal.lengthInBytes / (1024 * 1024)).toStringAsPrecision(2)} Mb";
          });
        } catch (e) {
          print("Something went wrong: $e");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: voices.isNotEmpty
              ? <Widget>[
                  Text(
                    testTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'All Voices:',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: voices,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'File size: $audioSize',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ]
              : [
                  Text(
                    testTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _tts('universal-single'),
            tooltip: 'Increment',
            child: Text(
              "US",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _tts('universal-combine'),
            tooltip: 'Increment',
            child: Text(
              "UC",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _tts('google'),
            tooltip: 'Increment',
            child: Text(
              "G",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            isExtended: true,
            onPressed: () => _tts('microsoft'),
            tooltip: 'Increment',
            child: Text(
              "M",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            isExtended: true,
            onPressed: () => _tts('amazon'),
            tooltip: 'Increment',
            child: Text(
              "A",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          )
        ],
      ),
    );
  }
}
