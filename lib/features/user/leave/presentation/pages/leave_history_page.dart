import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../../../../injection_container.dart';
import '../bloc/leave_bloc.dart';
import '../widgets/leave_history_list.dart';
import '../../../../../components/widgets/shimmer.dart';

class LeaveHistoryPage extends StatefulWidget {
  const LeaveHistoryPage({super.key});

  @override
  State<LeaveHistoryPage> createState() => _LeaveHistoryPageState();
}

class _LeaveHistoryPageState extends State<LeaveHistoryPage>{
  final LeaveBloc leaveBloc = sl<LeaveBloc>();

  @override
  void initState(){
    super.initState();
    leaveBloc.add(GetLeaveHistoryData());
  }

  @override
  Widget build(BuildContext context) {
    final allLoading = Provider.of<ProfileProvider>(context);
    return BlocProvider(create: (context)=> leaveBloc,
      child: RefreshIndicator(
        onRefresh: ()async{
          leaveBloc.add(GetLeaveHistoryData());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body:BlocBuilder<LeaveBloc,LeaveState>(
            builder: (BuildContext context, LeaveState state) {
              if(state is LeaveInitial){
                return const Center(
                  child: Text("กำลังโหลดข้อมูล",style: TextStyle(
                      fontSize: 17
                  ),),
                );
              }
              else if(state is LeaveLoading || allLoading.isLoading){
                return const ShimmerComponent(width: 200, height: 200,);
              }
              else if(state is LeaveLoaded){
                return LeaveHistoryList(
                    leaveHistory: state.leaveHistoryData,
                    bloc:leaveBloc
                );
              }
              else if(state is LeaveFailure){
                return Text("${state.error}",style: const TextStyle(
                    fontSize: 17
                ),);
              }
              else{
                return Container();
              }
            },

          )
        ),
      ),
    );
  }

}
