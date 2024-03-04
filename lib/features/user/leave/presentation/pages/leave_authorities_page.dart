import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
import '../bloc/leave_bloc.dart';
import '../widgets/leave_authority_list.dart';
import '../../../../../components/widgets/shimmer.dart';
// import 'leave_form_page.dart';

class LeaveAuthorityPage extends StatefulWidget {
  const LeaveAuthorityPage({super.key});

  @override
  State<LeaveAuthorityPage> createState() => _LeaveAuthorityPageState();
}

class _LeaveAuthorityPageState extends State<LeaveAuthorityPage> with AutomaticKeepAliveClientMixin{
  final LeaveBloc leaveAuthBloc = sl<LeaveBloc>();
  List<LeaveAuthorityEntity> data = [];
  List<LeaveHistoryEntity> historyData = [];
  List<double> remaining = [];
  List<double> used = [];

  @override
  void initState(){
    super.initState();
    leaveAuthBloc.add(GetAllLeaveData());
  }

  @override
  Widget build(BuildContext context) {
    final allLoading = Provider.of<ProfileProvider>(context);
    super.build(context);
    return RefreshIndicator(
      onRefresh: ()async{
        leaveAuthBloc.add(GetAllLeaveData());
      },
      child: BlocProvider(
        create: (context) => leaveAuthBloc,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 5, right: 5, bottom: 60),
                child: BlocBuilder<LeaveBloc, LeaveState>(
                    builder: (context,state){
                      if(state is LeaveInitial){
                        return const Center(
                          child: Text("กำลังโหลดข้อมูล",style: TextStyle(
                              fontSize: 17
                          ),),
                        );
                      }
                      else if(state is LeaveLoading || allLoading.isLoading){
                        return const ShimmerComponent(width: 200, height: 100,);
                      }
                      else if(state is LeaveLoaded){
                        data = state.leaveAuthorityData;
                        historyData = state.leaveHistoryData;
                        remaining = state.remaining!;
                        used = state.used!;
                        return LeaveAuthorityList(
                          leaveData: state.leaveKeyData,
                          leaveAuthority: state.leaveAuthorityData,
                          used: state.used!,
                          remaining: state.remaining!,
                        );
                      }
                      else if(state is LeaveFailure){
                        return Text("${state.error}",style: const TextStyle(fontSize: 17),);
                      }
                      else{
                        return LeaveAuthorityList(
                          leaveData: state.leaveKeyData,
                          leaveAuthority: state.leaveAuthorityData,
                          used: state.used!,
                          remaining: state.remaining!,
                        );
                      }
                }),
            ),
            BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                if(state is LeaveLoaded){
                  return Positioned(
                      bottom: 85,
                      right: 15,
                      child: FloatingActionButton(
                        heroTag: "formbtn",
                        elevation: 5,
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LeaveFormPage(
                          //           data: data,
                          //           remaining: remaining,
                          //           historyData: historyData,
                          //           used: used, leaveUsedData: state.leaveKeyData,
                          //         )));
                        },
                        // backgroundColor: const Color(0xff007AFE),
                        backgroundColor: Colors.grey,
                        child: Icon(
                          state.leaveAuthorityData.isEmpty ? Icons.refresh : Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ));
                }
                return const SizedBox();
              },
            )
          ]),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
