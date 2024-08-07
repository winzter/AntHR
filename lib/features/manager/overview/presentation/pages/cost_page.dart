import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../injection_container.dart';
import '../bloc/overview_bloc.dart';
import '../widgets/cost_menu/cost_widgets.dart';
import '../widgets/widgets.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  final OverviewBloc overviewBloc = sl<OverviewBloc>();
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    overviewBloc.add(GetDepartmentData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => overviewBloc,
      child: Scaffold(
        appBar: appBarOverview(context, "ภาพรวมค่าใช้จ่าย"),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xffF9A47A),
                  Color(0xffE793B8),
                  Color(0xff6FC9E4),
                ])),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.4)
                ])),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DepartmentSelect(bloc: overviewBloc, isExpanded: isExpanded,),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          MonthYearPicker(
                            bloc: overviewBloc,
                            title: "ภาพรวมค่าใช้จ่าย",
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EmployeesNum(bloc: overviewBloc),
                                NumOfCompany(bloc: overviewBloc)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BlocBuilder<OverviewBloc, OverviewState>(
                                    builder: (context, state) {
                                      return MonthlyExpense(
                                        title: "รายจ่ายเงินดือน",
                                        svgPath:
                                            "assets/icons/overview_manager/monthly_expense.svg",
                                        rate: (state.costData?.salaryTotal ?? 0)
                                            .toDouble(),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  BlocBuilder<OverviewBloc, OverviewState>(
                                    builder: (context, state) {
                                      return MonthlyExpense(
                                        title: "รายจ่ายค่าล่วงเวลา",
                                        svgPath:
                                            "assets/icons/overview_manager/monthly_ot.svg",
                                        rate: state.costData != null?(state.costData!.otTotal!.the2!.payTotal!+state.costData!.otTotal!.the3!.payTotal!+state.costData!.otTotal!.the15!.payTotal!):0,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ExpenseBox(
                                title: 'รวมรายจ่าย',
                                value: state.costData != null
                                    ? (state.costData!.otTotal!.the15!.payTotal! +
                                        state.costData!.otTotal!.the2!
                                            .payTotal! +
                                        state.costData!.otTotal!.the3!
                                            .payTotal! + state.costData!.salaryTotal!)
                                    : 0,
                                svgPath:
                                    "assets/icons/overview_manager/summary_expense.svg",
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ChartExpense(
                                  costData: state.costData,
                                  date: state.date);
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ChartOt(
                                  costData: state.costData,
                                  date: state.date,);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: isExpanded?Color(0xffE46A76):Color(0xff30B98F),
            child: Icon(isExpanded?Icons.search_off:Icons.search,size: 35,color: Colors.white,),
            onPressed: (){
              setState(() {
                isExpanded = !isExpanded;
              });
            }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
