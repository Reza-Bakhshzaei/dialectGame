import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  var isListening = false;

  // String _text = 'Press the button and start speaking';
  List item = [
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];

  @override
  void initState() {
    super.initState();
    checkMicrophoneAvailability();
  }

  void checkMicrophoneAvailability() async {
    bool available = await speechToText.initialize();
    if (available) {
      setState(() {
        if (kDebugMode) {
          print('Microphone available: $available');
        }
      });
    } else {
      if (kDebugMode) {
        print("The user has denied the use of speech recognition.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade200,
        appBar: AppBar(
          title: const Text('speach game'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          glowColor: Theme.of(context).primaryColor,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: Container(
          color: Colors.blue.shade200,
          child: GridView.count(
            crossAxisCount: 9,
            children: List.generate(item.length, (index) {
              return Card(
                color: Colors.black12,
                child: item[index] == 1
                    ? const Icon(
                        Icons.person,
                        color: Colors.white,
                      )
                    : const SizedBox(),
              );
            }),
          ),
        ));
  }

  void update(int move) {
    var index = item.indexOf(1);
    item[index] = 0;
    if (index % 9 == 0 && move == -1) {
      move = 0;
    } else if (index % 9 == 8 && move == 1) {
      move = 0;
    } else if (index ~/ 9 == 0 && move == -9) {
      move = 0;
    } else if (index >= 81 && move == 9) {
      move = 0;
    }
    if (index + move >= 0 && index + move <= 90) {
      setState(() {
        item[index + move] = 1;
        isListening = false;
        speechToText.stop();
      });
    }
  }

  void spliter(String text) {
    String split = text.split(" ")[0].toLowerCase();
    int move = 0;
    if (split == "up") {
      move = -9;
    }
    if (split == "down") {
      move = 9;
    }
    if (split == "left") {
      move = -1;
    }
    if (split == "right") {
      move = 1;
    }
    update(move);
  }

  void _listen() async {
    if (!isListening) {
      // var local = await speechToText.locales();
      // for (var i in local) {
      //   print("local name: ${i.name}, local id: ${i.localeId}");
      // }
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });
        speechToText.listen(
            // localeId: local[].localeId,
            onResult: (result) {
          print(result.recognizedWords);
          spliter(result.recognizedWords);
        });
      }
    } else {
      setState(() {
        isListening = false;
      });
      speechToText.stop();
    }
  }
}
