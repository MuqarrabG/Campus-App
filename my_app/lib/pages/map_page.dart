import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        panEnabled: true,
        minScale: 1,
        maxScale: 4,
        child: Center(
          child: Image.asset(
            'lib/images/mq-campus-map.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
