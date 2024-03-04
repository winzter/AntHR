import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/daily_detail_bloc/working_time_bloc.dart';

class SearchForm extends StatefulWidget {
  final WorkingTimeBloc bloc;
  final List<EmployeesEntity> empData;
  const SearchForm({
    super.key,
    required this.bloc,
    required this.empData});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  Future pickDate() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 1),
        lastDate: DateTime(2030, 12));

    if (newDate == null) {
      return;
    } else {
      final startDateFormatted = DateFormat("dd/MM/yyyy").format(newDate);
      widget.bloc.add(GetWorkingTimeData(
        start: DateFormat("yyyy-MM-dd").format(newDate),
      ));
      setState(() {
        dateController.text = startDateFormatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "ชื่อ - สกุล",
                style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40,
                width: 250,
                child: SearchField<EmployeesEntity>(
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
                    onSearchTextChanged: (String? text){
                      if(text == ""){
                        widget.bloc.add(ShowSomeEmpAttendance(empId: null));
                      }
                      return null;
                    },
                    onSuggestionTap:(SearchFieldListItem<EmployeesEntity> x){
                      FocusScope.of(context).unfocus();
                      widget.bloc.add(ShowSomeEmpAttendance(empId: x.item!.idEmp!));
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
                  onTap: pickDate,
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
    );
  }

  @override
  void dispose(){
    super.dispose();
    dateController.dispose();
    searchController.dispose();
  }
}
