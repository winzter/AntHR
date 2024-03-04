import 'package:flutter/material.dart';
import 'package:anthr/components/widgets/universal_app_bar.dart';
import '../widgets/widgets.dart';

class WorkRecordPage extends StatefulWidget {
  const WorkRecordPage({super.key});

  @override
  State<WorkRecordPage> createState() => _WorkRecordPageState();
}

class _WorkRecordPageState extends State<WorkRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: universalAppBar(context, "บันทึกการทำงาน"),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).devicePixelRatio * 10,
            horizontal: MediaQuery.of(context).devicePixelRatio * 6),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white),
                child: Column(
                  children: [const WorkRecordHeader(), WorkRecordBody()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
