import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../injection_container.dart';
import '../../../loading_page/loading_page.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool obscure = true;
  bool userFieldError = false;
  bool passwordFieldError = false;
  bool isLoginFail = false;
  bool isLoading = false;
  Map loginData = {"username": "", "password": ""};

  Future<bool> onBackPress() async {
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final logInProvider = Provider.of<LoginProvider>(context,listen: true);
    return WillPopScope(
      onWillPop: onBackPress,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider(
          create: (context) => sl<LoginBloc>(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints.expand(),
                  child: Image.asset(
                    'assets/images/login_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 50),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/Ant_white.png",
                                  height: 250,
                                  width: 250,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "เข้าสู่ระบบ",
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 18),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        setState(() => userFieldError = true);
                                        return "กรุณาใส่ชื่อผู้ใช้";
                                      }
                                      setState(() => userFieldError = false);
                                      return null;
                                    },
                                    onChanged: (String username) {
                                      setState(() {
                                        loginData["username"] = username;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: "ชื่อผู้ใช้",
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(
                                          fontSize: 18,
                                          color: userFieldError
                                              ? Colors.red
                                              : Colors.grey),
                                      prefixIcon: Icon(
                                          Icons.account_circle_rounded,
                                          color: userFieldError
                                              ? Colors.red
                                              : Colors.grey),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      errorStyle: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 18),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        setState(
                                            () => passwordFieldError = true);
                                        return "กรุณาใส่รหัสผ่าน";
                                      } else if (value.length < 8) {
                                        setState(
                                            () => passwordFieldError = true);
                                        return "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร";
                                      }
                                      setState(
                                          () => passwordFieldError = false);
                                      return null;
                                    },
                                    onChanged: (String password) {
                                      setState(() {
                                        loginData["password"] = password;
                                      });
                                    },
                                    obscureText: obscure,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle: const TextStyle(),
                                      labelText: "รหัสผ่าน",
                                      labelStyle: TextStyle(
                                          fontSize: 18,
                                          color: passwordFieldError
                                              ? Colors.red
                                              : Colors.grey),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: passwordFieldError
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() => obscure = !obscure);
                                        },
                                        icon: Icon(
                                          obscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      errorStyle: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    if (state is LoginStateLoading) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xffc6c6c6),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  log("success");
                                                } else {
                                                  log("not success");
                                                }
                                              },
                                              child: const Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          height: 25,
                                                          width: 25,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        "กำลังเข้าสู่ระบบ",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      );
                                    } else if (state is LoginStateFailure) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffEEAC19),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    context
                                                        .read<LoginBloc>()
                                                        .add(LoginEventDoLogin(
                                                            username: loginData[
                                                                "username"],
                                                            password: loginData[
                                                                "password"]));
                                                    // logInProvider.login(loginData["username"], loginData["password"]);
                                                    log("success");
                                                  } else {
                                                    log("not success");
                                                  }
                                                },
                                                child: const Text(
                                                  "เข้าสู่ระบบ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "ชื่อผู้ใช้ หรือ รหัสผ่าน ไม่ถูกต้อง",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
                                          )
                                        ],
                                      );
                                    } else if (state is LoginStateSuccess) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LoadingPage(
                                              isLogIn: true,
                                            ), // Replace with your home page
                                          ),
                                          (route) => false,
                                        );
                                      });
                                      return SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xffEEAC19),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                            },
                                            child: const Text(
                                              "เข้าสุ่ระบบสำเร็จ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffEEAC19),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    context
                                                        .read<LoginBloc>()
                                                        .add(LoginEventDoLogin(
                                                            username: loginData[
                                                                "username"],
                                                            password: loginData[
                                                                "password"]));
                                                    // logInProvider.login(loginData["username"], loginData["password"]);
                                                    log("success");
                                                  } else {
                                                    log("not success");
                                                  }
                                                },
                                                child: const Text(
                                                  "เข้าสุ่ระบบ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
