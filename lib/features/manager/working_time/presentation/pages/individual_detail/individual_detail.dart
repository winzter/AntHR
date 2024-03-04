import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../../components/widgets/loading.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/individual_detail/workingtime_individual_bloc.dart';
import '../../widgets/individual_detail/form.dart';
import '../../widgets/individual_detail/timetable_body.dart';

class IndividualDetail extends StatefulWidget {
  const IndividualDetail({super.key});

  @override
  State<IndividualDetail> createState() => _IndividualDetailState();
}

class _IndividualDetailState extends State<IndividualDetail> {
  List<EmployeesEntity> empData = [];
  final WorkingTimeIndividualBloc bloc = sl<WorkingTimeIndividualBloc>();


  @override
  void initState(){
    super.initState();
    bloc.add(GetEmployeesData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<WorkingTimeIndividualBloc,WorkingTimeIndividualState>(
            builder: (context,state){
              if(state is WorkingTimeIndividualInitial){
                return Column(
                  children: [
                    SearchFormIndividual(bloc: bloc, empData: state.empData,),
                    const Text("กำลังโหลดข้อมูล",style: TextStyle())
                  ],
                );
              }
              else if(state is WorkingTimeIndividualLoading){
                return Column(
                  children: [
                    SearchFormIndividual(bloc: bloc, empData: state.empData,),
                    const Loading(color: Colors.blueAccent,)
                  ],
                );
              }
              else if(state is WorkingTimeIndividualLoaded){
                return  Column(
                  children: [
                    SearchFormIndividual(bloc: bloc, empData: state.empData,),
                    Expanded(
                      child: TimeTableBody(
                        attendanceData: state.empAttendanceData,
                        showingData: state.showingData,
                        reasons: state.reasons,
                        idEmp: state.idEmp,
                        empData: state.empData,),
                    ),
                  ],
                );
              }
              else if(state is WorkingTimeIndividualFailure){
                return Center(child: Text("${state.error}"));
              }
              return SearchFormIndividual(bloc: bloc, empData: state.empData,);
            }),
      ),
    );
  }
}
