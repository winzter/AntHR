import 'package:anthr/core/features/profile/user/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../injection_container.dart';
import '../bloc/timeline_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final TimelineBloc timelineBloc = sl<TimelineBloc>();
  final now = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState(){
    super.initState();
    final ProfileProvider user = Provider.of<ProfileProvider>(context,listen: false);
    timelineBloc.add(GetTimeLineData(startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month + 1, 0),
        idCompany: user.profileData.idCompany!,
        idVendor: user.profileData.idVendor!));
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context,listen: false);
    return BlocProvider(
      create: (context) => timelineBloc,
      child: Scaffold(
        body: BlocBuilder<TimelineBloc,TimelineState>(
          builder: (context,state){
            List listOfDayEvents(DateTime dateTime) {
              if(state.status == FetchStatus.success){
                if (state.events[DateFormat("yyyy-MM-dd").format(dateTime)] != null) {
                  return state.events[DateFormat("yyyy-MM-dd").format(dateTime)]!;
                } else {
                  return [];
                }
              }
             return [];
            }
            return Column(
              children: [
                TableCalendar(
                  onPageChanged: (DateTime date){
                    setState(() {
                      _focusedDay = date;
                      _selectedDay = date;
                    });
                    timelineBloc.add(GetTimeLineData(startDate: DateTime(date.year, date.month, 1),
                        endDate: DateTime(date.year, date.month + 1, 0),
                        idCompany: user.profileData.idCompany!,
                        idVendor: user.profileData.idVendor!));
                  },
                  locale: 'th',
                  daysOfWeekHeight: 45,
                  rowHeight: 40,
                  firstDay: DateTime.utc(2010, 01, 01),
                  lastDay: DateTime.utc(2055, 12, 31),
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          fontSize: 25,
                          color: Color(0xff007AFE),
                          fontWeight: FontWeight.w500),
                      titleCentered: true),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat:  CalendarFormat.month,
                  eventLoader: listOfDayEvents,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: events.map((event) {
                            Color markerColor;
                            if (event == 'ot') {
                              markerColor = const Color(0xff275F77);
                            }  else if (event == 'request_time') {
                              markerColor = const Color(0xffEEAC19);
                            } else if (event == 'absent') {
                              markerColor = const Color(0xffFF0019);
                            } else if (event == 'leave'){
                              markerColor = const Color(0xffFF6D1B);
                            } else if(event == "holiday"){
                              markerColor = const Color(0xff8300B2);
                            } else {
                              markerColor = Colors.grey;
                            }
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1.5),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: markerColor,
                                shape: BoxShape.circle,
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return Container();
                    },
                  ),
                  calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(fontSize: 16),
                    weekendTextStyle: TextStyle(fontSize: 16),
                    outsideDaysVisible: false,
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                      decoration: BoxDecoration(
                          color:  Color(0xffC4C4C4)
                      ),
                      weekdayStyle: TextStyle(fontSize: 16,color: Colors.white),
                      weekendStyle: TextStyle(fontSize: 16,color: Colors.white)),
                  onDaySelected: _onDaySelected,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffEAEDF2),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ValueListenableBuilder<List>(
                        valueListenable: ValueNotifier<List<String>>([
                          "วันหยุดประจำปี",
                          "ทำงานล่วงเวลา",
                          "ขอรับรองเวลาทำงาน",
                          "ขอลางาน",
                          "ขาดงาน",
                        ]),
                        builder: (context, value, _) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 30),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.transparent),
                                    borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(10)
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 5,
                                          child:Container(
                                            height: MediaQuery.of(context).size.height,
                                            decoration: BoxDecoration(
                                                color: value[index] == "ทำงานล่วงเวลา"
                                                        ? const Color(0xff275F77)
                                                        : (value[index] == "ขอลางาน"
                                                        ? const Color(0xffFF6D1B)
                                                        : (value[index] == "ขอรับรองเวลาทำงาน"
                                                        ? const Color(0xffEEAC19)
                                                        : (value[index] == "ขาดงาน"
                                                        ? const Color(0xffFF0019)
                                                        : const Color(0xff8300B2)))),
                                                borderRadius: const BorderRadius.horizontal(
                                                    left: Radius.circular(10)
                                                ),
                                                border: Border.all(
                                                    color: Colors.transparent
                                                )
                                            ),
                                          )
                                      ),
                                      Expanded(
                                        flex: 50,
                                        child: Center(child: Text('${value[index]}',style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                        ),)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ),
    );
  }
}
