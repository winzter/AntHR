import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/manager/presentation/provider/manager_profile_provider.dart';
import '../bloc/overview_bloc.dart';
import 'department_dropdown.dart';

class DepartmentSelect extends StatefulWidget {
  final OverviewBloc bloc;
  final bool isExpanded;

  const DepartmentSelect(
      {super.key, required this.bloc, required this.isExpanded});

  @override
  State<DepartmentSelect> createState() => _DepartmentSelectState();
}

class _DepartmentSelectState extends State<DepartmentSelect>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    final ManagerProfileProvider managerData =
        Provider.of<ManagerProfileProvider>(context, listen: false);
    // setState(() {
    //   selectedValue = managerData.profileData.companyName ?? '';
    // });
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.isExpanded) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(DepartmentSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ManagerProfileProvider managerData = Provider.of<ManagerProfileProvider>(context);
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Column(
          children: [
            BlocBuilder<OverviewBloc, OverviewState>(
              builder: (context, state) {
                return DepartmentDropdown(
                  bloc: widget.bloc,
                  title: "ฝ่าย",
                  data: state.departmentName,
                  selectedValue: state.selectedDivisionName,
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            // BlocBuilder<OverviewBloc, OverviewState>(
            //   builder: (context, state) {
            //     return DepartmentDropdown(
            //       bloc: widget.bloc,
            //       title: "ส่วน",
            //       data: state.departmentName,
            //       selectedValue: state.selectedDepartmentName,
            //     );
            //   },
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            BlocBuilder<OverviewBloc, OverviewState>(
              builder: (context, state) {
                return DepartmentDropdown(
                  bloc: widget.bloc,
                  title: "แผนก",
                  data: state.sectionName,
                  selectedValue: state.selectedSectionName,
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff007AFE)),
                    onPressed: () {
                      widget.bloc.add(SearchOverviewData());
                    },
                    child: const Text(
                      "ค้นหา",
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}
