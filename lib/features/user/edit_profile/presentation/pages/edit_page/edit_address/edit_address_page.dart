import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../../provider/edit_profile_provider.dart';
import '../../../widgets/widgets.dart';

class EditAddressPage extends StatefulWidget {
  final String title;
  final List<String> labels;
  final List<String> data;
  const EditAddressPage({super.key, required this.title, required this.labels, required this.data});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String address = "";
  String district = "";
  String province = "";
  String zipcode = "";

  @override
  void initState(){
    super.initState();
    setState(() {
      address = widget.data[0];
      district = widget.data[1];
      province = widget.data[2];
      zipcode = widget.data[3];
    });
  }
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context,listen:true);
    final editProfileProvider = Provider.of<EditProfileProvider>(context,listen:false);
    return SafeArea(child:
    Scaffold(
      backgroundColor: const Color(0xffEAEDF2),
      body: Consumer(builder: (context, EditProfileProvider data, child){
        return  GestureDetector(
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
                                keyboardType:  widget.labels[i] == "รหัสไปรษณีย์"?TextInputType.phone
                                    :TextInputType.text,
                                initialValue: widget.data[i],
                                validator: (value) {
                                  RegExp regex = widget.labels[i] == "รหัสไปรษณีย์"?RegExp(r'^\d{5}$')
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
                                      address = value;
                                    }else if(i==1){
                                      district = value;
                                    }else if(i==2){
                                      province = value;
                                    }else{
                                      zipcode = value;
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
                                  editProfileProvider.sendEditAddressData(
                                      address,
                                      district,
                                      province,
                                      zipcode
                                  );
                                  profileProvider.setAddress(address, district, province, zipcode);
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
        );
      }
      ),
    ));
  }
}
