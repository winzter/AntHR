import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../components/bottom_navbar_user.dart';
import '../../../components/bottom_navbar_manager.dart';
import '../../../components/widgets/loading.dart';
import '../../storage/secure_storage.dart';
import '../login/presentation/pages/login_page.dart';

class LoadingPage extends StatefulWidget {
  final bool isLogIn;
  const LoadingPage({super.key, required this.isLogIn});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final Logger logger = Logger();

  startLoading() async {
    return Timer(const Duration(seconds: 2), () async {
      if (widget.isLogIn && await LoginStorage.readToken() != null) {
        String idRole = await LoginStorage.readIdRoles();
        if (idRole == "1") {
          if (mounted) {
            logger.i("Role : User");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavigatorBar()),
            );
          }
        } else if (idRole == "2") {
          if (mounted) {
            logger.i("Role : Manager");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigatorBarManager()),
            );
          }
        } else {
          if (mounted) {
            logger.w("Role อื่นๆ: ยังไม่พร้อมใช้งาน");
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                confirmBtnText: 'ย้อนกลับ',
                title: 'ยังไม่เปิดให้บริการ',
                text:
                    "สิทธิ์แอดมิน ยังไม่เปิดให้บริการใน Mobile App\n กรุณาใช้ผ่าน Website",
                confirmBtnColor: const Color(0xffE46A76),
                onConfirmBtnTap: () async {
                  await LoginStorage.deleteAll();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                });
            await LoginStorage.deleteAll();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        }
      } else {
        if (mounted) {
          await LoginStorage.deleteAll();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
                child: Loading(
              color: Colors.white,
            )),
          ),
        ],
      ),
    );
  }
}
