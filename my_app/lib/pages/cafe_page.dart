import 'package:flutter/material.dart';

class CafePage extends StatefulWidget {
  final String cafeName;
  const CafePage({super.key, required this.cafeName});

  @override
  State<CafePage> createState() => _CafePageState();
}

class _CafePageState extends State<CafePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cafeName, style: const TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
    );
  }
}
