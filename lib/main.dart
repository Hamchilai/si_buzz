import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  StreamSubscription<String>? _setupSubscription;
  StreamSubscription<MidiPacket>? _packetSubscription;
  MidiDevice? _connectedDevice;

  final MidiCommand _midiCommand = MidiCommand();

  @override
  void initState() {
    super.initState();

    print("PREVED");
    _packetSubscription = _midiCommand.onMidiDataReceived?.listen((event) {
      print("data received!!!! ");
      print("data received ${event!.toDictionary}");
      for (final b in event!.data) {
        print("   ${b.toRadixString(16)}");
      }
      if (event.data[0] == 0x90) {
        event.data[0] |= 1;
        _midiCommand.sendData(event.data);
      }
    });
    _setupSubscription = _midiCommand.onMidiSetupChanged?.listen((data) async {
      print("setup changed $data");
      /*
      var devices = await _midiCommand.devices;
      if (_connectedDevice != null && _connectedDevice!.connected) {
        _midiCommand.disconnectDevice(_connectedDevice!);
        _connectedDevice = null;
      }
      if (devices != null && devices.length == 1) {
        _connectedDevice = devices[0];
        _midiCommand.connectToDevice(_connectedDevice!);
      }
      setState(() {});
       */
    });
    _midiCommand.devices.then((value) {
      for (final d in value!) {
        print("devices ${d.toDictionary} ");
        _connectedDevice = d;
        _midiCommand.connectToDevice(_connectedDevice!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            child: FutureBuilder(
                future: _midiCommand.devices,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    var devices = snapshot.data as List<MidiDevice>;
                    return ListView.builder(
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          MidiDevice device = devices[index];

                          return ListTile(
                            title: Text(
                              device.name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline5,
                            ),
                            subtitle: Text(
                                "ins:${device.inputPorts.length} outs:${device
                                    .outputPorts.length}, ${device.id}, ${device
                                    .type}"),
                          );
                        });
                  }
                  return CircularProgressIndicator();
                })
        )
    );
  }
}
