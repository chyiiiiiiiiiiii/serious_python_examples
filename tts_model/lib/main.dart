import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:serious_python/serious_python.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await startPython();

  runApp(const MyApp());
}

Future<void> startPython() async {
  Directory tempDir = await (await getTemporaryDirectory()).createTemp("tts");
  final audioFilePath = join(tempDir.path, "out.wav");
  final logFilePath = join(tempDir.path, "log.txt");

  await SeriousPython.run(
    "app/app.zip",
    environmentVariables: {
      "AUDIO_FILEPATH": audioFilePath,
      "LOG_FILEPATH": logFilePath,
    },
    sync: false,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _result;

  @override
  void initState() {
    super.initState();

    getServiceResult();
    getError();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getServiceResult() async {
    while (true) {
      try {
        var response = await http.get(Uri.parse("http://127.0.0.1:55005"));
        setState(() {
          _result = response.body;
        });
        return;
      } catch (error) {
        setState(() {
          _result = "Error: $error";
        });
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
  }

  Future<void> getError() async {
    Directory tempDir = await (await getTemporaryDirectory()).createTemp("tts");
    final logFilePath = join(tempDir.path, "log.txt");

    var i = 10;
    var lastString = "";
    while (i-- > 0) {
      var out = File(logFilePath);
      if (await out.exists()) {
        var r = await out.readAsString();
        print('Log from Python 1: $r');

        if (r == lastString) {
          print("Log from Python 2: $r");

          break;
        }

        lastString = r;
      } else {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? result;
    if (_result != null) {
      result = Text(_result!);
    } else {
      result = const CircularProgressIndicator();
    }

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Python REPL'),
          ),
          body: SafeArea(
              child: Column(children: [
            Expanded(
              child: Center(
                child: result,
              ),
            ),
            ElevatedButton(
                onPressed: _result != null
                    ? () {
                        setState(() {
                          _result = null;
                        });
                        http.post(
                          Uri.parse("http://127.0.0.1:55005/audio"),
                          headers: {'Content-Type': 'application/json'},
                        ).then((resp) => setState(() {
                              _result = resp.body;
                            }));
                      }
                    : null,
                child: const Text("Run"))
          ]))),
    );
  }
}
