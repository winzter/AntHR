import 'package:flutter/material.dart';

class EducationDetail extends StatelessWidget {
  final String title;
  final String university;
  final String faculty;
  final String grade;

  const EducationDetail({super.key, required this.title, required this.university, required this.faculty, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
            border: Border.all(color: Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Flexible(
                  child: Text(
                    university,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Text(
                    faculty,
                    style: const TextStyle(
                        fontSize: 15, color: Color(0xff757575)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const Text(
                  "เกรดเฉลี่ย: ",
                  style: TextStyle(
                      fontSize: 15, color: Color(0xff757575)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(grade, style: const TextStyle(fontSize: 16))
              ],
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
