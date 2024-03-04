import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/mileage/detail_success.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xff27385E)
          ),
        ),
        centerTitle: true,
        title: const Text(
          'บันทึกการเดินทาง',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).devicePixelRatio * 10,
                horizontal: MediaQuery.of(context).devicePixelRatio * 5,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).devicePixelRatio * 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 5),
                      child: SvgPicture.asset(
                        "assets/icons/success.svg",
                        width: 100,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 5),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "บันทึกเดินทางเข้า",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const DetailSuccess(
                      title: 'สถานที่',
                      detail:
                          '1 ถ. ปูนซีเมนต์ไทย แขวงบางซื่อ เขตบางซื่อ กรุงเทพมหานคร 10800',
                      isEnd: false,
                    ),
                    const DetailSuccess(
                      title: 'วันที่ ',
                      detail: '18/04/23',
                      isEnd: false,
                    ),
                    const DetailSuccess(
                      title: 'เวลา',
                      detail: '16:30',
                      isEnd: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 5),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                ),
                elevation: 5,
                backgroundColor: const Color(0xff007AFE)),
            onPressed: () {
              int count = 0;
              Navigator.of(context)
                  .popUntil((_) => count++ >= 2);
            },
            child: const Text(
              "เสร็จสิ้น",
              style: TextStyle(
                  color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
