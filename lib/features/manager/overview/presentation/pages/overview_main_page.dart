import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class OverviewMainPage extends StatelessWidget {
  const OverviewMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          constraints: const BoxConstraints.expand(),
          child: Image.asset(
            'assets/images/manager_overview/overview_manager.png',
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              appBarOverview(context,"มุมมองภาพรวม"),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      MenuCard(
                        svgPath: 'assets/icons/overview_manager/income_expense.svg',
                        title: 'รายรับรายจ่าย',
                        page: ExpensePage(),
                      ),
                      MenuCard(
                        svgPath: 'assets/icons/overview_manager/overview.svg',
                        title: 'มุมมองภาพรวม',
                        page: OverviewPage(),
                      ),
                      MenuCard(
                        svgPath: 'assets/icons/overview_manager/overview_ot.svg',
                        title: 'ข้อมูลค่าล่วงเวลา',
                        page: OvertimePage(),
                      ),
                      MenuCard(
                        svgPath: 'assets/icons/overview_manager/overview_working_time.svg',
                        title: 'ภาพรวมเวลาทำงาน',
                        page: WorkingTimePage(),
                      ),
                      MenuCard(
                        svgPath: 'assets/icons/overview_manager/overview_expense.svg',
                        title: 'ภาพรวมค่าใช้จ่าย',
                        page: CostPage(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
