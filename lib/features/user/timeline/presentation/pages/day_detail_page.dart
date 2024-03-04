import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';
import '../widgets/time_line_body/widgets.dart';
// import 'request_time_form_page.dart';

class DayDetailPage extends StatelessWidget {
  final int index;
  final TimeLineEntity data;
  final List<TimeLineEntity> attendanceData;
  final List<ReasonsTimeLineRequest> reasons;
  final List<PayrollSettingTimeLine> payrollData;
  const DayDetailPage({
    super.key,
    required this.attendanceData,
    required this.data,
    required this.index,
    required this.reasons,
    required this.payrollData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(1)
                    ])
            ),
          ),
          backgroundColor: dayColors(data),
          leading: IconButton(
            color: const Color(0xff757575),
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: showDate(data),
          bottom: tabData(data)),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(bottom:MediaQuery.of(context).devicePixelRatio*10 ),
            child: showDetail(data,context),
          )
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: const Color(0xff007AFE),
        backgroundColor: Colors.grey,
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => RequestTimeForm(
          //           index:index,
          //           data: data,
          //           attendanceData: attendanceData,
          //           reasons: reasons,
          //           payrollData: payrollData,
          //         )));
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
