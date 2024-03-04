import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../../components/widgets/loading.dart';
import '../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../bloc/gps_bloc.dart';
import '../../widgets/appbar.dart';
import '../../widgets/widgets.dart';
import 'google_map.dart';

class DisplayGoogleMap extends StatefulWidget {
  final bool checkInOut;
  const DisplayGoogleMap({super.key, required this.checkInOut});

  @override
  State<DisplayGoogleMap> createState() => _DisplayGoogleMapState();
}

class _DisplayGoogleMapState extends State<DisplayGoogleMap> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GpsBloc gpsBloc = sl<GpsBloc>();

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(context,listen:false);
    gpsBloc.add(GetGPSLocation(idEmp: profileProvider.profileData.idEmp!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, "บันทึกเวลา${widget.checkInOut?'เข้า':'ออก'}"),
        body: BlocProvider(
          create: (context) => gpsBloc,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    CheckDetail(checkInOut: widget.checkInOut, formKey: formKey,bloc:gpsBloc),
                    BlocBuilder<GpsBloc, GpsState>(builder: (context,state){
                      if(state.status == FetchStatus.selected){
                        int key = state.groupGpsLocations
                            .firstWhere((element) => element.name == state.selectedLocation).idGroupGpsLocations!;
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 320,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white),
                          child: GoogleMapDisplay(
                            subLocations: state.subLocations[key], gpsBloc: gpsBloc,isPoint: state.isPoint,
                          ),
                        );
                      }
                      // else
                      if(state.status == FetchStatus.fetching){
                        return const Loading(color: Colors.blueAccent,);
                      }
                      else {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 320,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white),
                          child: GoogleMapDisplay(subLocations: null, gpsBloc: gpsBloc,isPoint: state.isPoint,),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}