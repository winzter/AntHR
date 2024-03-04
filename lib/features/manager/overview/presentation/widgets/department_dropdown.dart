import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../bloc/overview_bloc.dart';

class DepartmentDropdown extends StatefulWidget {
  final OverviewBloc bloc;

  final String title;
  final Map<int, String> data;

  final String? selectedValue;

  const DepartmentDropdown(
      {super.key,
      required this.bloc,
      required this.title,
      required this.data,
      this.selectedValue});

  @override
  State<DepartmentDropdown> createState() => _DepartmentDropdownState();
}

class _DepartmentDropdownState extends State<DepartmentDropdown> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 20,
            child: Text(
              "${widget.title} :",
              style: const TextStyle(fontSize: 18),
            )),
        Expanded(
          flex: 80,
          child: DropdownButton2(
            alignment: Alignment.center,
            underline: Container(),
            buttonStyleData: ButtonStyleData(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.white),
              elevation: 2,
            ),
            dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            )),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
            items: widget.data.values.map((String item) => DropdownMenuItem<String>(
                      value: item,
                      // alignment: Alignment.center,
                      child:  SizedBox(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ))
                .toList(),
            hint: Text("เลือก${widget.title}"),
            value: widget.selectedValue,
            onChanged: (value) {

              if (widget.title == "ฝ่าย") {
                widget.bloc.add(DivisionChange(divisionName: value!));
              } else if (widget.title == "ส่วน") {
                widget.bloc.add(DepartmentChange(departmentName: value!));
              }else{
                widget.bloc.add(SectionChange(sectionName: value!));
              }

            },
          ),
        ),
      ],
    );
  }
}
