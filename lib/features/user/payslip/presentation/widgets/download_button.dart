import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../domain/entities/payslip.dart';
import '../pages/payslip_download_page.dart';

class DownloadButton extends StatelessWidget {
  final List<PayslipEntity> data;
  const DownloadButton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff27385E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PayslipDownloadPage(payslipData: data)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/download.svg",
                        width: 35,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "ดาวน์โหลดสลิปเงินเดือน",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
