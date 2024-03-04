import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../injection_container.dart';
import '../bloc/overview_bloc.dart';
import '../widgets/expense_menu/expense_widgets.dart';
import '../widgets/widgets.dart';


class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
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
                appBarOverview(context,"รายรับรายจ่าย"),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
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
                                  bloc: overviewBloc, title: "รายรับรายจ่าย",
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      EmployeesNum(bloc: overviewBloc),
                                      OtMoreThan36(bloc: overviewBloc)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BlocBuilder<OverviewBloc, OverviewState>(
                                          builder: (context, state) {
                                            return MonthlyExpense(
                                              title: "จ่ายค่าแรง",
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
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        BlocBuilder<OverviewBloc, OverviewState>(
                                          builder: (context, state) {
                                            return MonthlyExpense(
                                              title: "จ่ายอื่นๆ",
                                              svgPath:
                                              "assets/icons/overview_manager/box.svg",
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
                                      title: 'รวมจ่าย',
                                      value: state.costData != null
                                          ? (state.costData!.otTotal!.the15!.payTotal! +
                                          state.costData!.otTotal!.the2!
                                              .payTotal! +
                                          state.costData!.otTotal!.the3!
                                              .payTotal! + state.costData!.salaryTotal!)
                                          : 0,
                                      svgPath:
                                      "assets/icons/overview_manager/summary_expense.svg", color:const Color(0xffB72136),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BlocBuilder<OverviewBloc, OverviewState>(
                                          builder: (context, state) {
                                            return IncomeBox(
                                              title: "รายรับค่าแรงรวม",
            
                                              svgPath:
                                              "assets/icons/overview_manager/working.svg",
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
                                            return IncomeBox(
                                              title: "รายรับค่าดำเนินการ",
                                              svgPath:
                                              "assets/icons/overview_manager/dollar.svg",
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
                                      title: 'รายรับค่าแรงรวม',
                                      value: state.costData != null
                                          ? (state.costData!.otTotal!.the15!.payTotal! +
                                          state.costData!.otTotal!.the2!
                                              .payTotal! +
                                          state.costData!.otTotal!.the3!
                                              .payTotal! + state.costData!.salaryTotal!)
                                          : 0,
                                      color:const Color(0xff30B98F),
                                      svgPath:
                                      "assets/icons/overview_manager/summary_expense.svg",
                                    );
                                  },
                                ),
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return DifferenceCost(
                                      title: 'ส่วนต่าง',
                                      value: state.costData != null
                                          ? (state.costData!.otTotal!.the15!.payTotal! +
                                          state.costData!.otTotal!.the2!
                                              .payTotal! +
                                          state.costData!.otTotal!.the3!
                                              .payTotal! + state.costData!.salaryTotal!)
                                          : 0,
                                      color:Colors.white,
                                      svgPath:
                                      "assets/icons/overview_manager/dollar_bag.svg",
                                    );
                                  },
                                ),
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return ChartOt(overtimeData: state.overtimeData,date:state.date);
                                  },
                                ),
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return ChartExpense(overviewData: state.overviewData);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 150,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: isExpanded?const Color(0xffE46A76):const Color(0xff30B98F),
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
