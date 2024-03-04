import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import '../../domain/entities/payslip.dart';

class PayslipDownloadPage extends StatefulWidget {
  final List<PayslipEntity> payslipData;
  const PayslipDownloadPage({super.key, required this.payslipData});

  @override
  State<PayslipDownloadPage> createState() => _PayslipDownloadPageState();
}

class _PayslipDownloadPageState extends State<PayslipDownloadPage> {
  Future saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File("$path/$fileName");
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open("$path/$fileName");
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.kanitRegular();
    final fontBold = await PdfGoogleFonts.kanitMedium();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(25),
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Text("Confidential", style: pw.TextStyle(font: font)),
                  pw.Spacer(),
                  pw.Text("PAY SLIP",
                      style: pw.TextStyle(
                          font: fontBold,
                          color: const PdfColor.fromInt(0xffD13B3B),
                          fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Table(
                // border: pw.TableBorder.all(),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const pw.FractionColumnWidth(2),
                  1: const pw.FractionColumnWidth(7),
                  2: const pw.FractionColumnWidth(2),
                  3: const pw.FractionColumnWidth(2)
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text("ชื่อ-สกุล :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          "${widget.payslipData[0].title} ${widget.payslipData[0].firstname} ${widget.payslipData[0].lastname}",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("รหัสพนักงาน :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text("${widget.payslipData[0].employeeId}",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("บริษัท :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(widget.payslipData[0].vendorName ?? '',
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("วันที่เริ่มต้น :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          widget.payslipData[0].start != null
                              ? DateFormat("dd/MM/yyyy")
                                  .format(
                                      widget.payslipData[0].start!)
                              : "",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("ส่วน :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(widget.payslipData[0].sectionName ?? '',
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("วันที่สิ้นสุด :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          widget.payslipData[0].end != null
                              ? DateFormat("dd/MM/yyyy")
                                  .format(
                                      widget.payslipData[0].end!)
                              : "",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("เลขที่บัญชี :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(widget.payslipData[0].bookBankId ?? '',
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("วันที่สิ้นสุด :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          widget.payslipData[0].payDate != null
                              ? DateFormat("dd/MM/yyyy")
                                  .format(
                                      widget.payslipData[0].payDate!)
                              : "",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const pw.FractionColumnWidth(.25),
                  1: const pw.FractionColumnWidth(.15),
                  2: const pw.FractionColumnWidth(.3),
                  3: const pw.FractionColumnWidth(.15)
                },
                border: const pw.TableBorder(
                  verticalInside: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                  left: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                  right: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                  bottom: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                ),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                        color: PdfColor.fromInt(0xff007AFE)),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("รายการเงินได้",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("จำนวน(บาท)",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white),
                            textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("รายการเงินหัก",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("จำนวน(บาท)",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white),
                            textAlign: pw.TextAlign.right),
                      ),
                    ],
                  ),
                  for (var i = 0, j = 0;
                      i < widget.payslipData[0].addition!.length ||
                          j < widget.payslipData[0].deduction!.length;
                      i++, j++)
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              "${i < widget.payslipData[0].addition!.length ? widget.payslipData[0].addition![i].name : ''}",
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39))),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              i < widget.payslipData[0].addition!.length
                                  ? NumberFormat("#,###.##").format(
                                      widget.payslipData[0].addition![i].value)
                                  : '',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39)),
                              textAlign: pw.TextAlign.right),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              "${j < widget.payslipData[0].deduction!.length ? widget.payslipData[0].deduction![j].name : ''}",
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39))),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              j < widget.payslipData[0].deduction!.length
                                  ? NumberFormat("#,###.##").format(
                                      widget.payslipData[0].deduction![j].value)
                                  : '',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39)),
                              textAlign: pw.TextAlign.right),
                        ),
                      ],
                    ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 30),
                        child: pw.Text("", style: pw.TextStyle(font: font)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 30),
                        child: pw.Text("", style: pw.TextStyle(font: font)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    decoration: const pw.BoxDecoration(
                        color: PdfColor.fromInt(0xffEEEEEE)),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("รวมเงินได้",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E))),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: pw.Text(
                            NumberFormat("#,###.##").format(
                                widget.payslipData[0].accumulateEarnings),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E)),
                            textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("รวมเงินหัก",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E))),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData[0].totalDeductions),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E)),
                            textAlign: pw.TextAlign.right),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const pw.FractionColumnWidth(.25),
                  1: const pw.FractionColumnWidth(.15),
                  2: const pw.FractionColumnWidth(.3),
                  3: const pw.FractionColumnWidth(.15)
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("", style: pw.TextStyle(font: font)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("",
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ),
                      pw.Container(
                        color: const PdfColor.fromInt(0xffE0E0E0),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: pw.Text("จ่ายสุทธิ",
                              style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: const PdfColor.fromInt(0xff4A525B))),
                        ),
                      ),
                      pw.Container(
                        color: const PdfColor.fromInt(0xffE0E0E0),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: pw.Text(
                              NumberFormat("#,###.##")
                                  .format(widget.payslipData[0].net),
                              style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: const PdfColor.fromInt(0xff4A525B)),
                              textAlign: pw.TextAlign.right),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 15, bottom: 5),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                            DateFormat("รายได้สะสม - ปี yyyy")
                                .format(
                                    widget.payslipData[0].monthPeriod!),
                            style: pw.TextStyle(
                                font: font,
                                color: const PdfColor.fromInt(0xff212B36))),
                      ])),
              pw.Table(
                border: pw.TableBorder.all(
                    color: const PdfColor.fromInt(0xffE0E0E0)),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                // columnWidths: {
                //   0: const pw.FractionColumnWidth(2),
                //   1: const pw.FractionColumnWidth(3),
                //   2: const pw.FractionColumnWidth(4),
                //   3: const pw.FractionColumnWidth(5)},
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text("รายได้สะสม (บาท)",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text("ภาษีหัก ณ ที่จ่ายสะสม (บาท)",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text("ประกันสังคม (บาท)",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text("กองทุนสำรองเลี้ยงชีพสะสม (บาท)",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##").format(
                                widget.payslipData[0].accumulateEarnings),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData[0].accumulateTax),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData[0].accumulateSso),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData[0].accumulatePf),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getApplicationSupportDirectory();

    final file = File(
        "${output.path}/สลิปเงินเดือน ${DateFormat("MMMM yyyy", "en_US").format(widget.payslipData[0].monthPeriod!)}.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(
        "${output.path}/สลิปเงินเดือน ${DateFormat("MMMM yyyy", "en_US").format(widget.payslipData[0].monthPeriod!)}.pdf");
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xffEAEDF2),
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 70,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff27385E),
                      Color(0xff277B89),
                      Color(0xffFFCA11),
                    ],
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                "สลิปเงินเดือน",
                style: GoogleFonts.kanit(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xffC4C4C4),
                  )),
            ),
            body: widget.payslipData.isNotEmpty
                ? InteractiveViewer(
                    minScale: 0.1,
                    maxScale: 3,
                    child: PdfPreview(
                        canDebug: false,
                        useActions: false,
                        padding: const EdgeInsets.all(0),
                        build: (format) => _generatePdf(format, "title")),
                  )
                : Center(
                    child: Text(
                    "ไม่พบข้อมูล",
                    style: GoogleFonts.kanit(fontSize: 25),
                    textAlign: TextAlign.center,
                  ))));
  }
}
