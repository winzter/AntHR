import 'package:flutter/material.dart';
import '../widgets/map.dart';
import '../widgets/travelling_appbar.dart';

class TravellingPage extends StatefulWidget {
  const TravellingPage({super.key});

  @override
  State<TravellingPage> createState() => _TravellingPageState();
}

class _TravellingPageState extends State<TravellingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: travellingAppBar(context, "บันทึกการเดินทาง"),
        body: const MapPage()
    );
  }
}
