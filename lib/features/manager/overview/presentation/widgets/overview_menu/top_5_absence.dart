import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../../domain/entities/overview_entity.dart';

class Top5Absence extends StatelessWidget {
  final OverviewEntity? overviewData;
  const Top5Absence({super.key, this.overviewData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 5,
            vertical: MediaQuery.of(context).devicePixelRatio * 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              "Top 5 Leave Absence",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if(overviewData != null && overviewData!.workingTimeEmployeeInfo!.top5AbsentEmployees!.isNotEmpty)...[
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: overviewData!.workingTimeEmployeeInfo!.top5AbsentEmployees!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: badges.Badge(
                          position: badges.BadgePosition.topEnd(top: -15),
                          badgeStyle: badges.BadgeStyle(
                              padding: const EdgeInsets.all(10),
                              badgeColor: (index > 2)?const Color(0xffFFA25F):const Color(0xffFFA3CB)),
                          badgeContent: Text(
                            "${index+1}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xffc4c4c4),
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(
                          "${overviewData!.workingTimeEmployeeInfo!.top5AbsentEmployees![index].firstnameTh} ${overviewData!.workingTimeEmployeeInfo!.top5AbsentEmployees![index].lastnameTh}",
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "${overviewData!.workingTimeEmployeeInfo!.top5AbsentEmployees![index].absentTotal} วัน",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xffFFA3CB)),
                        ),
                      ),
                      if(overviewData!.workingTimeEmployeeInfo!.top5AbsentEmployees!.length - index != 1)
                        const Divider(thickness: 1,endIndent: 25,indent: 25,)
                    ],
                  );
                },
              )
            ]
            else...[
              const Padding(
                padding: EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text("ไม่มีพนักงานขาดงาน",style: TextStyle(fontSize: 18),),
                  ],
                ),
              ),
            ]

          ],
        ),
      ),
    );
  }
}
