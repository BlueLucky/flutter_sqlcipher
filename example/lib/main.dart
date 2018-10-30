/* This is free and unencumbered software released into the public domain. */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlcipher/sqlcipher.dart';
import 'package:flutter_sqlcipher/sqlite.dart';

////////////////////////////////////////////////////////////////////////////////

void main() => runApp(MyApp());

////////////////////////////////////////////////////////////////////////////////

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

////////////////////////////////////////////////////////////////////////////////

class _MyAppState extends State<MyApp> {
  String _libraryVersion = "Unknown";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String libraryVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      libraryVersion = await SQLCipher.version;
      //libraryVersion = await SQLite.version;
    }
    on PlatformException {
      libraryVersion = "Failed to get SQLCipher library version.";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _libraryVersion = libraryVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SQLCipher for Flutter"),
        ),
        body: Center(
          child: Text("Running on: v$_libraryVersion\n"),
        ),
      ),
    );
  }
}
