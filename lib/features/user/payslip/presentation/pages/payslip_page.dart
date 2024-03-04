import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../provider/payslip_provider.dart';
import '../widgets/widgets.dart';

class PaySlip extends StatefulWidget {
  const PaySlip({super.key});
  @override
  State<PaySlip> createState() => _PaySlipState();
}

class _PaySlipState extends State<PaySlip> {
  PageController pageController = PageController(initialPage: 0);
  late GetPayslipProvider payslipProvider;

  @override
  void initState() {
    super.initState();
    payslipProvider = GetPayslipProvider.of(context, listen: false);
    payslipProvider.getPayslipData();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<GetPayslipProvider>();
    final ProfileProvider profileData = Provider.of<ProfileProvider>(context);
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
        title: const Text(
          "สลิปเงินเดือน",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              if (profileData.isPayslipValidate) {
                Navigator.pop(context);
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xffC4C4C4),
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const DropdownYear(),
              const SizedBox(
                height: 5,
              ),
              ExpandablePageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: data.months.length,
                onPageChanged: (index) {
                  data.setIndex(index);
                  data.setMonth(data.months[data.currentPageIndex]);
                  payslipProvider.getPayslipData();
                },
                itemBuilder: (context, index) {
                  return CardList(
                    index: index,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "รายได้สะสม - ${data.month} ปี ${data.year}",
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color(0xff275F77),
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              if (data.payslipData.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BenefitBox(
                          title: "เงินได้สะสม",
                          total: (data.payslipData[0].accumulateEarnings ?? 0),
                          profit1:
                              (data.payslipData[0].accumulateEarnings ?? 0) -
                                  (data.payslipData[0].totalEarnings ?? 0),
                          profit2: (data.payslipData[0].totalEarnings ?? 0),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        BenefitBox(
                            title: "ภาษีหัก ณ ที่จ่ายสะสม",
                            total: data.payslipData[0].accumulateTax ?? 0)
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BenefitBox(
                            title: "กองทุนสำรองเลี้ยงชีพ\nสะสม",
                            total: (data.payslipData[0].accumulatePf ?? 0),
                            profit1: (data.payslipData[0].accumulatePf ?? 0) -
                                (data.deductionPF.value ?? 0),
                            profit2: (data.deductionPF.value ?? 0))
                      ],
                    ),
                    Column(
                      children: [
                        BenefitBox(
                            title: "ประกันสังคมสะสม",
                            total: (data.payslipData[0].accumulateSso ?? 0),
                            profit1: (data.payslipData[0].accumulateSso ?? 0) -
                                (data.deductionSSO.value ?? 0),
                            profit2: (data.deductionSSO.value ?? 0))
                      ],
                    )
                  ],
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [BenefitBox(title: "เงินได้สะสม", total: 0)],
                    ),
                    Column(
                      children: [
                        BenefitBox(title: "ภาษีหัก ณ ที่จ่ายสะสม", total: 0)
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BenefitBox(title: "กองทุนสำรองเลี้ยงชีพ\nสะสม", total: 0)
                      ],
                    ),
                    Column(
                      children: [
                        BenefitBox(title: "ประกันสังคมสะสม", total: 0)
                      ],
                    )
                  ],
                ),
              ],
              const SizedBox(
                height: 10,
              ),
              DownloadButton(
                data: data.payslipData,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
