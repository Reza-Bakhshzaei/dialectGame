import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:math' as math;
import 'package:restart_app/restart_app.dart';

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

  List level1 = [
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
  List level2 = [
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
    2,
    2,
    0,
    2,
    2,
    2,
    3,
    2,
    3,
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
    3,
    2,
    2,
    3,
    0,
    0,
    4
  ];
  List level3 = [
    1,
    0,
    2,
    3,
    2,
    2,
    2,
    3,
    2,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    3,
    3,
    2,
    2,
    0,
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
    0,
    2,
    3,
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
    3,
    2,
    0,
    0,
    2,
    0,
    2,
    0,
    2,
    2,
    2,
    0,
    3,
    2,
    2,
    2,
    3,
    2,
    3,
    0,
    0,
    0,
    0,
    0,
    3,
    2,
    2,
    2,
    0,
    2,
    0,
    2,
    0,
    2,
    3,
    2,
    3,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    2,
    0,
    3,
    2,
    2,
    3,
    0,
    0,
    4
  ];
  List? item;
  final _colors5 = Map<int, Color>();
  Color _colorActor = Colors.red;
  String textLevel = "";

  @override
  void initState() {
    item = level1;
    textLevel = "Level 1";
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
          title: Text(textLevel),
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
            children: List.generate(item!.length, (index) {
              return Card(
                color: item![index] == 2
                    ? Colors.orange
                    : item![index] == 3
                        ? Colors.yellow.shade100
                        : item![index] == 4
                            ? Colors.green.shade300
                            : item![index] == 5
                                ? _colors5[index]
                                : Colors.white30,
                child: item![index] == 1
                    ? Icon(
                        Icons.person,
                        color: _colorActor,
                        size: 35,
                      )
                    : item![index] == 3
                        ? Icon(
                            Icons.card_travel_sharp,
                            color: Colors.blue.shade400,
                            size: 30,
                          )
                        : item![index] == 4
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

  void rated(int rate) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Exit Game"),
            content: Text(
                "Thank you for choosing this game.\nAnd you rated the game $rate."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Restart.restartApp();
                  },
                  child: const Text("Restart")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    exit(0);
                  },
                  child: const Text("Exit"))
            ],
          );
        });
  }

  void update(int move) {
    var index1 = item!.indexOf(1);
    if ((index1 % 9 == 0 && move == -1) ||
        (index1 % 9 == 8 && move == 1) ||
        (index1 ~/ 9 == 0 && move == -9) ||
        (index1 >= item!.length - 9 && move == 9)) {
      move = 0;
    }
    if (index1 + move >= 0 &&
        index1 + move <= item!.length &&
        item![index1 + move] != 2) {
      if (item![index1 + move] == 3) {
        item![index1 + move] = 5;
        Color random = Color.fromRGBO(
          math.Random().nextInt(255),
          math.Random().nextInt(255),
          math.Random().nextInt(255),
          math.Random().nextDouble(),
        );
        _colors5[index1 + move] = random;
        _colorActor = random;
        move = 0;
      }
      if (item![index1 + move] == 4) {
        if (item!.length == 108) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Survey"),
                  content: const Text("Please rate our game."),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          rated(1);
                        },
                        icon: const Icon(Icons.star_border)),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          rated(2);
                        },
                        icon: const Icon(Icons.star_border)),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          rated(3);
                        },
                        icon: const Icon(Icons.star_border)),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          rated(4);
                        },
                        icon: const Icon(Icons.star_border)),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          rated(5);
                        },
                        icon: const Icon(Icons.star_border)),
                  ],
                  backgroundColor: Colors.orange.shade300,
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Next Level"),
                  content: const Text("mission complate."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (item!.length <= 90) {
                              item = level2;
                              textLevel = "Level 2";
                            } else if (item!.length <= 99) {
                              item = level3;
                              textLevel = "Level 3";
                            }
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("next"))
                  ],
                  backgroundColor: Colors.orange.shade300,
                );
              });
        }
      }
      speechToText.stop();
      setState(() {
        item![index1] = 0;
        item![index1 + move] = 1;
        isListening = false;
      });
    }
  }

  void spliter(String text) {
    String split = text.split(" ")[0].toLowerCase();
    if (split == "top") {
      update(-9);
    }
    if (split == "bottom") {
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
