import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/individual_detail/workingtime_individual_bloc.dart';

class SearchFormIndividual extends StatefulWidget {
  final WorkingTimeIndividualBloc bloc;
  final List<EmployeesEntity> empData;
  const SearchFormIndividual({
    super.key,
    required this.bloc,
    required this.empData,
  });

  @override
  State<SearchFormIndividual> createState() => _SearchFormIndividualState();
}

class _SearchFormIndividualState extends State<SearchFormIndividual> {
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  int? empId;
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0));

  Future pickDateRange() async {
    FocusScope.of(context).unfocus();
    DateTimeRange? newDateRange = await showDateRangePicker(
        initialEntryMode:DatePickerEntryMode.calendarOnly,
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2200),
        initialDateRange: dateRange);

    if (newDateRange == null) {
      return;
    } else {
      final startDateFormatted = DateFormat("dd/MM/yyyy").format(newDateRange.start);
      final endDateFormatted = DateFormat("dd/MM/yyyy").format(newDateRange.end);
      setState(() {
        dateRange = newDateRange;
        dateController.text = "$startDateFormatted - $endDateFormatted";
        if(empId != null){
          widget.bloc.add(
              GetAttendanceEmpDateData(
                  id: empId!,
                  start: DateFormat("yyyy-MM-dd").format(newDateRange.start),
                  end: DateFormat("yyyy-MM-dd").format(newDateRange.end))
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Form(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "ชื่อ - สุกล",
                        style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 40,
                        width: 250,
                        child:
                        SearchField<EmployeesEntity>(
                            controller: searchController,
                            searchStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          suggestions: widget.empData
                              .map((e) => SearchFieldListItem<EmployeesEntity>(
                              e.firstname!,
                              item: e,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("${e.firstname!} ${e.lastname!}",style: const TextStyle(),)
                                  ],
                                ),
                              ),
                            ),
                          ).toList(),
                            onSuggestionTap:(SearchFieldListItem<EmployeesEntity> x){
                              FocusScope.of(context).unfocus();
                              setState(() {
                                empId = x.item!.idEmp!;
                              });
                              widget.bloc.add(
                                GetAttendanceEmpDateData(
                                    id: x.item!.idEmp!,
                                    start: DateFormat("yyyy-MM-dd").format(dateRange.start),
                                    end: DateFormat("yyyy-MM-dd").format(dateRange.end))
                              );
                            },
                            suggestionsDecoration: SuggestionDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: const Color(0xffC4C4C4))
                            ),
                            searchInputDecoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),)
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.024,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "วันที่ค้นหา",
                        style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 40,
                        width: 250,
                        child: TextFormField(
                          controller: dateController,
                          readOnly: true,
                          onTap: pickDateRange,
                          style: const TextStyle(),
                          decoration: const InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              suffixIcon: Icon(Icons.calendar_month),
                              hintText: "วัน/เดือน/ปี",
                              hintStyle: TextStyle(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              errorStyle: TextStyle()),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    dateController.dispose();
    searchController.dispose();
  }
}
