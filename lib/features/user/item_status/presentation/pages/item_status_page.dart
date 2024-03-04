import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/loading.dart';
import '../../../../../components/widgets/shimmer.dart';
import '../../../home/presentation/provider/leave_provider.dart';
import '../bloc/item_status_bloc.dart';
import '../widgets/widgets.dart';

class ItemStatusPage extends StatefulWidget {
  const ItemStatusPage({super.key});

  @override
  State<ItemStatusPage> createState() => _ItemStatusPageState();
}

class _ItemStatusPageState extends State<ItemStatusPage> {
  final itemStatusBloc = sl<ItemStatusBloc>();

  @override
  Widget build(BuildContext context) {
    final numNotApprove = Provider.of<WaitingProvider>(context,listen:true);
    return Scaffold(
      backgroundColor: Colors.white,
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
            "สถานะรายการ",
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
      body: BlocProvider(
        create: (_) => itemStatusBloc,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Column(
            children: [
              RadioButtonMenu(itemStatusBloc: itemStatusBloc),
              const StatusListIcon(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "รออนุมัติ ${numNotApprove.numRequestIsNotApprove()} รายการ",
                    style: const TextStyle(color: Color(0xff757575)),
                  )
                ],
              ),
              BlocBuilder<ItemStatusBloc, ItemStatusState>(
                  builder: (context ,state){
                    if(state is ItemStatusInitial){
                      return const Text("ไม่พบข้อมูล",style: TextStyle(),);
                    }
                    else if(state is ItemStatusLoading){
                      return Expanded(child: ShimmerComponent(width: MediaQuery.of(context).size.width, height: 100));
                    }
                    else if(state is ItemStatusLoaded){
                      return ExpansionList(
                          leaveData: state.leaveData??[],
                          requestTimeData: state.requestTimeData??[],
                          withdrawData: state.withdrawData??[],
                          allData: state.allData??[],
                          payrollSettingData: state.payrollSettingData??[],
                          dataRequestTime: state.dataRequestTime ??[],
                          dataRequestOT: state.dataRequestOT??[],
                          bloc:itemStatusBloc
                      );
                    }
                    else if(state is ItemStatusStateFailure){
                      return const Text("error");
                    }else{
                      return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

