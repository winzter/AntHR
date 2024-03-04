import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';

class NameDetail extends StatelessWidget {
  const NameDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer( builder: (context, ProfileProvider data, child){
      return  Positioned(
        top: 70, // 70 default
        left: 0,
        right: 0,
        child: Column(
          children: [
             Center(
              child:  Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffc4c4c4),
                  child: Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              // width: 170,
              child: Text(
                "${data.profileData.title} ${data.profileData.firstname} ${data.profileData.lastname}",
                // "นาง นงรักษ์ ฉิมวัย",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });

  }
}
