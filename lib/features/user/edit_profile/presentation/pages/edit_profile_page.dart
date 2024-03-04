import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../widgets/widgets.dart';
import 'change_password/change_password_page.dart';
import 'user_address/user_address_page.dart';
import 'user_information/user_information_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<bool> onBackPress() async{
    final NavIndex navigationProvider = Provider.of<NavIndex>(context,listen: false);
    navigationProvider.controller.jumpToPage(0);
    navigationProvider.setIndex(0);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return WillPopScope(
      onWillPop: onBackPress,
      child: Consumer(builder: (context, ProfileProvider data, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: DefaultTabController(
            length: 3,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 100,
                    child: AppBar(
                      elevation: 0,
                      toolbarHeight: 80,
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff27385E),
                              Color(0xff277B89),
                              Color(0xffFFCA11),
                            ],
                          ),
                        ),
                      ),
                      title: TabBar(
                        controller: tabController,
                        onTap: (value) {
                          setState(() {
                            tabController.index = value;
                          });
                        },
                        indicatorWeight: 4,
                        labelPadding: const EdgeInsets.all(0),
                        indicator: const BoxDecoration(
                            gradient: LinearGradient(colors: [ Color(0xffFFCA11),Color(0xff275F77),])),
                        indicatorPadding: const EdgeInsets.only(top:45),
                        labelColor: Colors.white,
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: const Color(0xffc4c4c4),
                        tabs: const [
                          TabsMenu(title:"ข้อมูลส่วนตัว"),
                          TabsMenu(title:"ที่อยู่"),
                          TabsMenu(title:"เปลี่ยนรหัสผ่าน"),
                        ],
                      ),
                    ),
                  ),
                ),
                if (tabController.index != 2)
                  Positioned(
                    top: 70, // 70 default
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        if (profileProvider.isLoading) ...[
                          Container(
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
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const CircleAvatar(
                                    radius: 45,
                                    backgroundColor: Color(0xffc4c4c4),
                                  ),
                                )),
                          ),
                        ]
                        else...[
                          Container(
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
                              radius: 50,
                              backgroundColor: Color(0xffc4c4c4),
                              child: Icon(Icons.person,size: 85,color: Colors.white,),
                            ),
                          ),
                        ],

                        const SizedBox(
                          height: 15,
                        ),
                        profileProvider.isLoading?
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: 150,
                              height: 30,
                              decoration: ShapeDecoration(
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ))
                            :SizedBox(
                          // width: 170,
                          child: Text(
                            "${data.profileData.title ?? ''} ${data.profileData.firstname ?? 'ไม่พบข้อมูล'} ${data.profileData.lastname ?? ''}",
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
                  ),
                Positioned(
                  top: tabController.index == 2 ? 100 : 220,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      UserInformation(),
                      UserAddress(),
                      UserChangePassword(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
