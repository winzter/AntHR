import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../pages/end_page.dart';
import '../pages/note_page.dart';

class AddressDetail extends StatelessWidget {
  final List<Placemark> address;
  final bool isCheck;

  const AddressDetail(
      {super.key, required this.address, required this.isCheck});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio * 3),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xffFF6575),
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    "${address.reversed.last.name ?? ''} ${address.reversed.last.street ?? ''} ${address.reversed.last.subLocality ?? ''} "
                    "${address.reversed.last.locality ?? ''} ${address.reversed.last.postalCode ?? ''} ${address.reversed.last.country ?? ''}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).devicePixelRatio * 10,
                  horizontal: MediaQuery.of(context).devicePixelRatio * 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007AFE)),
                  onPressed: () {
                    if (isCheck) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EndPage(date: DateTime.now(), isError: false, address: address,isCheck:isCheck),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NotePage(address: address),
                          ));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ยืนยัน",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
