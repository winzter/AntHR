import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/LocationBloc_bloc.dart';
import '../pages/mileage.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({
    super.key,
    required this.bloc,
    required this.lat,
    required this.lng,
  });

  final LocationBloc bloc;
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xff27385E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state.isSetLocation) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xffFF6575),
                      size: 30,
                    ),
                    Flexible(
                      child: Text(
                        "${state.address!.reversed.last.name} ${state.address!.reversed.last.street} ${state.address!.reversed.last.subLocality} "
                            "\n${state.address!.reversed.last.locality} ${state.address!.reversed.last.postalCode} ${state.address!.reversed.last.country}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.065,
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("วันที่ dd/MM/yy").format(DateTime.now()),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                Text(
                  DateFormat("เวลา HH:mm").format(DateTime.now()),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff30B98F),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                    onPressed: () async {
                      bloc.add(
                        GetCurrentAddress(lat: lat, lng: lng),
                      );
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MileagePage(),
                          ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "เริ่มออกเดินทาง",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE46A76),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "สิ้นสุดการเดินทาง",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
