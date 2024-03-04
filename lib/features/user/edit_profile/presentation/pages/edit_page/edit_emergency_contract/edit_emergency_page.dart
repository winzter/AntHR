import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../../provider/edit_profile_provider.dart';
import '../../../widgets/widgets.dart';

class EditEmergencyContractPage extends StatefulWidget {
  final String title;
  final List<String> labels;
  final List<String> data;
  const EditEmergencyContractPage({super.key, required this.title, required this.labels, required this.data});

  @override
  State<EditEmergencyContractPage> createState() => _EditEmergencyContractPageState();
}

class _EditEmergencyContractPageState extends State<EditEmergencyContractPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String phoneNum = "";
  String emergencyName = "";
  String emergencyRelationship = "";

  @override
  void initState(){
    super.initState();
    setState(() {
      emergencyName = widget.data[0];
      emergencyRelationship = widget.data[1];
      phoneNum = widget.data[2];
    });
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ProfileProvider>(context);
    final editUserProvider = Provider.of<EditProfileProvider>(context,listen: false);
    return SafeArea(child:
    Scaffold(
      backgroundColor: const Color(0xffEAEDF2),
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            EditAppbar(title: widget.title,),
            const EditBackground(),
            const NameDetail(),
            Positioned(
                top:  250,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).devicePixelRatio*10,
                        vertical: MediaQuery.of(context).devicePixelRatio*3),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).devicePixelRatio*10,
                          vertical: MediaQuery.of(context).devicePixelRatio*5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          for(var i=0;i<widget.data.length;i++)...[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).devicePixelRatio*3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(widget.labels[i],style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),
                            TextFormField(
                              keyboardType:  widget.labels[i] == "เบอร์โทรศัพท์"?TextInputType.phone
                                  :TextInputType.text,
                              initialValue: widget.data[i],
                              validator: (value) {
                                RegExp regex = widget.labels[i] == "เบอร์โทรศัพท์"?RegExp(r'^\d{10}$')
                                    :RegExp(r"");
                                if (value == null || value.isEmpty || value == "") {
                                  return "กรุณาใส่ข้อมูล";
                                }else if(!regex.hasMatch(value)){
                                  return "กรอกข้อมูลให้ถูกต้อง";
                                }
                                return null;
                              },
                              onChanged: (String value){
                                setState(() {
                                  if(i==0){
                                    emergencyName = value;
                                  }else if(i==1){
                                    emergencyRelationship = value;
                                  }else{
                                    phoneNum = value;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                labelStyle: const TextStyle(fontSize: 18,color: Colors.grey),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                errorStyle: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(height: 5,)
                          ],
                          const SizedBox(height: 20,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: const Color(0xff27385E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                editUserProvider.sendEditEmergencyContractData(
                                    emergencyName,
                                    phoneNum,
                                    emergencyRelationship);
                                userProvider.setEmergency(emergencyName, emergencyRelationship, phoneNum);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('บันทึกข้อมูลสำเร็จ',style: TextStyle(fontSize: 17,fontFamily: 'kanit'),),
                                      backgroundColor: Color(0xff277B89),
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
                              } else {
                                log("not success");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child:
                              Text(
                                "บันทึกข้อมูล",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ],),
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      )
      ),
    );
  }
}
