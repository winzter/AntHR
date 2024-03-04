import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/loading.dart';
import '../bloc/LocationBloc_bloc.dart';
import '../pages/travelling_history.dart';
import 'preview.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationBloc locationBloc = sl<LocationBloc>();
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

    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locationBloc,
      child: FutureBuilder(
        future: determinePosition(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading(color: Colors.blueAccent,);
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                      bearing: 192.8334901395799,
                      target:
                          LatLng(userLocation.latitude, userLocation.longitude),
                      zoom: 19.151926040649414),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff15264F).withOpacity(0.79),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TravellingHistoryPage()),
                      );
                    },
                    child: const Text(
                      "ประวัติการเดินทาง",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: PreviewWidget(
                    bloc: locationBloc,
                    lat: userLocation.latitude,
                    lng: userLocation.longitude,
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else {
            return const Center(
              child: Text('ไม่มีข้อมูลสถานที่'),
            );
          }
        },
      ),
    );
  }
}
