import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
        primarySwatch: Colors.blue,
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

  List item = [
    1,
    0,
    2,
    3,
    2,
    2,
    2,
    0,
    3,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    3,
    2,
    2,
    2,
    2,
    0,
    2,
    0,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    0,
    0,
    2,
    3,
    2,
    2,
    2,
    2,
    2,
    0,
    0,
    3,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    2,
    2,
    0,
    2,
    2,
    2,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    2,
    3,
    2,
    2,
    2,
    0,
    2,
    3,
    0,
    3,
    2,
    2,
    2,
    3,
    0,
    4
  ];

  @override
  void initState() {
    super.initState();
    checkMicrophoneAvailability();
  }

  void checkMicrophoneAvailability() async {
    await speechToText.initialize();
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
                color: item[index] == 2
                    ? Colors.orange
                    : item[index] == 3
                        ? Colors.yellow.shade100
                        : item[index] == 4
                            ? Colors.green.shade300
                            : Colors.white30,
                child: item[index] == 1
                    ? const Icon(
                        Icons.person,
                        color: Colors.red,
                      )
                    : item[index] == 3
                        ? Icon(
                            Icons.card_travel_sharp,
                            color: Colors.blue.shade400,
                          )
                        : item[index] == 4
                            ? Icon(
                                Icons.bungalow_outlined,
                                color: Colors.red.shade300,
                                size: 50,
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
    if ((index % 9 == 0 && move == -1) ||
        (index % 9 == 8 && move == 1) ||
        (index ~/ 9 == 0 && move == -9) ||
        (index >= 81 && move == 9)) {
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
    if (split == "top") {
      update(-9);
    }
    if (split == "down") {
      update(9);
    }
    if (split == "left") {
      update(-1);
    }
    if (split == "right") {
      update(1);
    }
  }

  void _listen() async {
    if (!isListening) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });
        speechToText.listen(
            localeId: 'en_US',
            onResult: (result) {
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
