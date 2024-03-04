import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/universal_app_bar.dart';
import '../bloc/WorkRecord_bloc.dart';
import '../widgets/address_detail.dart';
import '../widgets/appBar.dart';

class MapPage extends StatefulWidget {
  final bool isCheck;

  const MapPage({super.key, required this.isCheck});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final WorkRecordBloc bloc = sl<WorkRecordBloc>();
  late Position userLocation;


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    bloc.add(GetCurrentAddress(
        lat: userLocation.latitude,
        lng: userLocation.longitude,
        isCheck: widget.isCheck));
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: universalAppBar(context, "บันทึกการทำงาน"),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: FutureBuilder<Position>(
                    future: determinePosition(),
                    builder: (context, AsyncSnapshot<Position> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        Position userLocation = snapshot.data!;
                        return GoogleMap(
                          mapType: MapType.normal,
                          compassEnabled: true,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                userLocation.latitude, userLocation.longitude),
                            zoom: 18,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('ไม่มีข้อมูลสถานที่',
                             ),
                        );
                      }
                    },
                  ),
                ),
                BlocBuilder<WorkRecordBloc, WorkRecordState>(
                  builder: (context, state) {
                    if (state.address != null) {
                      return AddressDetail(
                        address: state.address!,
                        isCheck: widget.isCheck,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
