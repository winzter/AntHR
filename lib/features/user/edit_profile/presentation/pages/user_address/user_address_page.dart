import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../widgets/shimmer_profile.dart';
import '../../widgets/user_address_widgets/widgets.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 150),
        child: Column(
          children: [
            profileProvider.isLoading?
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ShimmerProfile(width: MediaQuery.of(context).size.width, height: 270),
            ):
            Reuse4LinesBox(
              title:"ที่อยู่ปัจจุบัน",
              detail_1:"ที่อยู่",
              detail_2:"อำเภอ",
              detail_3: "จังหวัด",
              detail_4: "รหัสไปรษณีย์",
              data_1:profileProvider.address ?? "ไม่ระบุ",
              data_2:profileProvider.district ?? "ไม่ระบุ",
              data_3:profileProvider.province ?? "ไม่ระบุ",
              data_4:profileProvider.areaCode ?? "ไม่ระบุ",
            ),
            if(profileProvider.profileData.education! .isEmpty)...[
              profileProvider.isLoading?
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ShimmerProfile(width: MediaQuery.of(context).size.width, height: 150),
              )
                  :const EducationDetail(
                  title:"ประวัติการศึกษา",
                  university: "(- ถึง -) ไม่ระบุสถานศึกษา",
                  faculty: "สาขา -, คณะ -, ระดับ -",
                  grade: "-"
              )
            ]
            else...[
              profileProvider.isLoading?
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ShimmerProfile(width: MediaQuery.of(context).size.width, height: 150),
              )
                  : EducationDetail(
                  title:"ประวัติการศึกษา",
                  university: "(${profileProvider.profileData.education?[0].fromYear ?? '-'} ถึง ${profileProvider.profileData.education?[0].endYear ?? '-'}) ${profileProvider.profileData.education?[0].university ?? 'ไม่ระบุสถานศึกษา'}",
                  faculty: "สาขา ${profileProvider.profileData.education?[0].major ?? 'ไม่ระบุ'}, คณะ ${profileProvider.profileData.education?[0].faculty ?? 'ไม่ระบุ'}, ระดับ ${profileProvider.profileData.education?[0].degree ?? 'ไม่ระบุ'}",
                  grade: "${profileProvider.profileData.education?[0].gpa ?? 'ไม่ระบุ'}")
            ]

          ],
        ),
      ),
    );
  }
}
