import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter/material.dart';
import 'package:sonic/background_service.dart';
import 'background_service.dart';
import 'package:quickalert/quickalert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeService();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late String buttonText;
  bool isServiceRunning = false;
  late String lastMessage2;

  @override
  void initState() {
    super.initState();
    buttonText = 'Start Service';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SONIC"),
          // title: const Text("පියා"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<Map<String, dynamic>?>(
                stream: FlutterBackgroundService().on('update'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data!;
                  String? lastMessage = data["last_message"];
                  lastMessage2=lastMessage!;
                  print("\n\n\n\n");
                  print(lastMessage);
                  if(lastMessage=="meeting"){
                    //TODO : fix the popup first
                    
                  }
                  print("\n\n\n\n");
                  DateTime? date = DateTime.tryParse(data["current_date"]);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(lastMessage ?? 'Unknown'),
                      Text(date.toString()),
                      
                    ],
                  );
                },
              ),
              Container(
                child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SecondRoute()));
                }, 
                child: Text("test"),
              ),
              )
              // buildButton("Foreground Mode", () {
              //   FlutterBackgroundService().invoke("setAsForeground");
              // }),
              // buildButton("Background Mode", () {
              //   print('start');
              //   FlutterBackgroundService().invoke("setAsBackground");
              // }),
              // buildButton(buttonText, () async {
              //   final service = FlutterBackgroundService();
              //   if (isServiceRunning) {
              //     service.invoke("stopService");
              //   } else {
              //     service.startService();
              //   }

              //   isServiceRunning = await service.isRunning();

              //   setState(() {
                  
                  
              //     buttonText = isServiceRunning ? 'Stop Service' : 'Start Service';
              //   }
              //   );
              // }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String label, void Function() onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}



class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}