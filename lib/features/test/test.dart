import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  final dynamic tmp;
  const Test({super.key, required this.tmp});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.tmp.toString()),
      ),
    );
  }
}
