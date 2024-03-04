import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';

class Leave extends StatelessWidget {
  final List<EmployeesLeaveEntity> empLeave;
  const Leave({super.key,required this.empLeave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffFFCA11),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("ลางาน",style: TextStyle(color: Colors.white,fontSize: 17),),
                Text("${empLeave.length} คน",style: const TextStyle(color: Colors.white,fontSize: 17),),
              ],),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: empLeave.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          ListTile(
                              leading: const CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0xffc4c4c4),
                                child: Icon(Icons.person,size: 35,color: Colors.white,),
                              ),
                              title: Text("${empLeave[index].firstname} ${empLeave[index].lastname}",
                                style: const TextStyle(),),
                              subtitle: Text("${empLeave[index].positionsName}",
                                style: const TextStyle(color: Color(0xff757575)),),
                              trailing: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffe3f5ed),
                                  ),
                                  child: Text("${empLeave[index].name}",style: const TextStyle(),textAlign: TextAlign.center,)),
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          )
                        ],
                      );
                    }
                )
            ),
          ),
        ],
      ),
    );
  }
}
