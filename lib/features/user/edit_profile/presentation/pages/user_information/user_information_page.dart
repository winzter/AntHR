import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/features/loading_page/loading_page.dart';
import '../../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../../widgets/shimmer_profile.dart';
import '../../widgets/user_information_widgets/widgets.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  performLogout(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context,listen: false);
    navigationProvider.setIndex(0);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const LoadingPage(isLogIn: false,)));
  }

  Future<bool> onLogOut() async{
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
        ),
        title: const Center(child: Column(
          children: [
            Icon(Icons.logout, color: Color(0xFFF15E5E),size: 60,),
            Text('ออกจากระบบ',style: TextStyle(color: Color(0xff75838F)),),
          ],
        )),
        content: const Text('คุณต้องการออกจากระบบ ?',style: TextStyle(fontSize: 15,),textAlign: TextAlign.center,),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child:  const Text('ยกเลิก',style: TextStyle(color: Color(0xffA5AFBA))),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFF15E5E)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius here
                      ),)
                ),
                child: const Text('ยืนยัน',style: TextStyle(color: Colors.white)),
                onPressed: ()=>performLogout(context),
              ),
            ],
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ProfileProvider>(context, listen: true);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 150),
        child: Column(children: [
          providerData.isLoading?
          ShimmerProfile(width: MediaQuery.of(context).size.width, height: 100)
          :Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(color: Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        providerData.profileData.positionsName ?? "ไม่ระบุ",
                        // "หัวหน้างาน การบุคคล",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(providerData.profileData.companyName ?? "ไม่ระบุ",
                    // "บริษัท โปรเทค เอ้าท์ซอสซิ่ง จำกัด",
                    style: const TextStyle(
                        fontSize: 15, color: Color(0xff757575))),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    DateFormat('เริ่มงาน dd MMM yyyy')
                        .format(
                        providerData.profileData.hiringDate ?? DateTime.now()),
                    // "เริ่มงาน 01 ก.ย. 2565",
                    style: const TextStyle(
                        fontSize: 15, color: Color(0xffC4C4C4))),
              ],
            ),
          ),
          providerData.isLoading?
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ShimmerProfile(width: MediaQuery.of(context).size.width, height: 170),
          ):
          Reuse3LinesBox(
              title:"ผู้ติดต่อฉุกเฉิน",
              detail_1:"ชื่อผู้ติดต่อ",
              detail_2:"ความสัมพันธ์",
              detail_3:"เบอร์โทรศัพท์",
              data_1:providerData.emergencyContact ?? "ไม่ระบุ",
              data_2:providerData.emergencyRelationship ?? "ไม่ระบุ",
              data_3:providerData.emergencyPhone ?? "ไม่ระบุ",
              fix:true),
          providerData.isLoading?
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ShimmerProfile(width: MediaQuery.of(context).size.width, height: 170),
          ):
          Reuse3LinesBox(
              title:"ข้อมูลพนักงาน",
              detail_1:"รหัสพนักงาน",
              detail_2:"เลขที่บัตรประชาชน",
              detail_3:"วันเกิด",
              data_1:providerData.profileData.employeeId ?? "ไม่ระบุ",
              data_2:providerData.profileData.personalId ?? "ไม่ระบุ",
              data_3:DateFormat('dd MMMM yyyy').format(
                  providerData.profileData.birthday ?? DateTime.now()),
              fix:false),
          providerData.isLoading?
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ShimmerProfile(width: MediaQuery.of(context).size.width, height: 150),
          ):
          Reuse2LinesBox(
              title: "การติดต่อ",
              detail_1: "เบอร์โทรศัพท์",
              detail_2: "อีเมล",
              data_1:providerData.telephoneMobile ?? "ไม่ระบุ",
              data_2:providerData.profileData.email ?? "ไม่ระบุ"
          ),
          const SizedBox(height: 15,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              onLogOut();
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child:
              Text(
                "ออกจากระบบ",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
