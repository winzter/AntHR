import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/edit_profile_provider.dart';
import '../../widgets/user_change_password_widgets/one_line_text.dart';

class UserChangePassword extends StatefulWidget {
  const UserChangePassword({super.key});

  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController confirmPassController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  String confirm = "";
  String oldPass = "";
  String newPass = "";
  late bool obscure1;
  late bool obscure2;
  late bool obscure3;
  @override
  void initState() {
    super.initState();
    obscure1 = true;
    obscure2 = true;
    obscure3 = true;
  }

  @override
  Widget build(BuildContext context) {
    final EditProfileProvider changePassword =
        Provider.of<EditProfileProvider>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 0),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 25, right: 25, bottom: 15),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                      child: Text(
                    "เปลี่ยนรหัสผ่าน",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  const OneLineText(text: "*รหัสผ่านต้องมีจำนวน 8-16 ตัวอักษร"),
                  const OneLineText(
                      text: "*ต้องเป็นอักษรภาษาอังกฤษหรือตัวเลขเท่านั้น"),
                  const OneLineText(
                      text:
                          "*ต้องมีตัวอักษรภาษาอังกฤษอย่างน้อย 1 ตัว หรือ ตัวเลขอย่างน้อย 1 ตัว"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "รหัสผ่านปัจจุบัน",
                    style: TextStyle(),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "กรุณาใส่รหัสผ่าน";
                      }
                      return null;
                    },
                    obscureText: obscure1,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure1 = !obscure1;
                            });
                          },
                          icon: Icon(obscure1
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "รหัสผ่านใหม่",
                    style: TextStyle(),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || !RegExp(r'\w').hasMatch(value)) {
                        return "รหัสผ่านต้องมีตัวเลขหรือตัวหนังสืออย่างน้อย 1 ตัว";
                      }
                      if (value.length < 8) {
                        return "รหัสผ่านต้องมีอย่างน้อย 8-16 ตัวอักษร";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        newPass = value;
                      });
                    },
                    obscureText: obscure2,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure2 = !obscure2;
                            });
                          },
                          icon: Icon(obscure2
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "ยืนยันรหัสผ่านใหม่",
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (value != value) {
                          return "รหัสผ่านไม่ตรงกัน";
                        }
                      }
                      if (value.isEmpty || !RegExp(r'\w').hasMatch(value)) {
                        return "รหัสผ่านต้องมีตัวเลขหรือตัวหนังสืออย่างน้อย 1 ตัว";
                      }
                      if (value.length < 8) {
                        return "รหัสผ่านต้องมีอย่างน้อย 8-16 ตัวอักษร";
                      }
                      return null;
                    },
                    obscureText: obscure3,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure3 = !obscure3;
                            });
                          },
                          icon: Icon(obscure3
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(238, 172, 25, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                              color: Color.fromRGBO(238, 172, 25, 1)),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          changePassword
                              .changePasswordData(
                                  oldPass, newPass, confirm, context)
                              .then((value) {
                            if (!value) {
                              oldPass = '';
                              newPass = '';
                              confirm = '';
                              confirmPassController.text = '';
                              oldPassController.text = '';
                              newPassController.text = '';
                              setState(() {});
                            }
                          });
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("ยืนยันเปลี่ยนรหัสผ่านใหม่",
                            style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
