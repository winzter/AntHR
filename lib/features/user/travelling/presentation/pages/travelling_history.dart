import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/date_range.dart';

class TravellingHistoryPage extends StatelessWidget {
  const TravellingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xff27385E),
                Color(0xff275F77),
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "บันทึกการเดินทาง",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xffC4C4C4),
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.024,
            ),
            const DateRangeButton(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(children: [
                        const Expanded(child: Icon(Icons.location_on,color: Color(0xff229A16),)),
                        const Expanded(child: Text("SCG บางซื่อ",style: TextStyle(fontSize: 18),)),
                        Expanded(
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffD8F2DC),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on,color: Color(0xff229A16),),
                                  // SizedBox(width: 5,),
                                  Text(DateFormat("HH:mm").format(DateTime.now()),
                                      style: const TextStyle(fontSize: 18,color:Color(0xff229A16),fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],),
                      const SizedBox(height: 10,),
                      Row(children: [
                        const Expanded(child: Icon(Icons.location_on,color: Color(0xffB72136),)),
                        const Expanded(child: Text("ระยอง",style: TextStyle(fontSize: 18),)),
                        Expanded(
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffFFD7DB),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on,color: Color(0xffB72136),),
                                  // SizedBox(width: 5,),
                                  Text(DateFormat("HH:mm").format(DateTime.now()),
                                      style: const TextStyle(fontSize: 18,color:Color(0xffB72136),fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
