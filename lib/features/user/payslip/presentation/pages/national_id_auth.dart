import 'package:anthr/features/user/payslip/presentation/pages/payslip_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../components/widgets/appbar_back.dart';
import '../../../../../components/widgets/background_img.dart';
import '../../../../../components/widgets/gap.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';

class NationalIdAuth extends StatefulWidget {
  const NationalIdAuth({super.key});

  @override
  _NationalIdAuthState createState() => _NationalIdAuthState();
}

class _NationalIdAuthState extends State<NationalIdAuth> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userProfile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            const BackgroundImg(imgPath: 'assets/images/bg1.png',),
            const AppbarBack(),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.17,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(height: 25),
                       SizedBox(
                        // width: 170,
                        child: Text(userProfile.profileData.firstname??"สวัสดี",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Gap(height: 15),
                      Center(
                      child: Container(
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
                            size: 75,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                      const Gap(height: 55),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "ยืนยันตัวตนด้วยเลขบัตรประชาชน",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          ),
                        ],
                      ),
                      const Gap(height: 10),
                      Form(
                        key: formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: idController,
                            style: const TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วนและถูกต้อง";
                              } else if (value !=
                                  userProfile.profileData.personalId) {
                                return "เลขบัตรประชาชนไม่ถูกต้อง";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                hintText: "เลขบัตรประชาชน",
                                hintStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                errorStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: const Color(0xffEEAC19),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                userProfile.setPayslipValidate(true);
                                setState(() {
                                  isCorrect = true;
                                });
                                await Future.delayed(const Duration(seconds: 1));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PaySlip(),
                                    ));
                              }
                            },
                            child: const Text(
                              "ยืนยัน",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isCorrect)
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.3),
                      // Colors.black.withOpacity(0.95)
                    ])),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
