import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:table_calendar/table_calendar.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin{
CalendarController _calendarController;
List _selectedEvents;
AnimationController _animationController;
bool toggle;
Color _colorIcCalendar = Colors.black;
bool _visibleDate;
Map<DateTime, List> _events;
@override
void initState() {
  super.initState();
  final _selectedDay = DateTime.now();
  _calendarController = CalendarController();
  toggle = true;
  _visibleDate = true;
  _events = {
    _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
    _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
    _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
    _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
    _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
    _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
    _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
    _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
    _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
    _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
    _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
    _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
    _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
    _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
    _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
  };
  _selectedEvents = _events[_selectedDay] ?? [];
  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
}
void _onDaySelected(DateTime day, List events) {
  print(events);
  setState(() {
    _selectedEvents = events;
  });
}

@override
void dispose() {
  _animationController.dispose();
  _calendarController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    var  myCalendarOn = TableCalendar(
      key: ValueKey("second"),
      rowHeight: 50,
      calendarController: _calendarController,
      locale:'th_TH',
      events: _events,

      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(

        weekendStyle: TextStyle().copyWith(color: Colors.deepOrangeAccent),
        holidayStyle: TextStyle().copyWith(color: Colors.deepOrangeAccent),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle().copyWith(color: Colors.blue),
        weekendStyle: TextStyle().copyWith(color: Colors.deepOrangeAccent),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,

      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.green[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
          markersBuilder: (context, date, events, holidays){
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }
            return children;
          },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
    );


   var myCalendarOf = SizedBox(key: ValueKey("first"),height: 5,);



    return SafeArea(
      child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(

           title: myAppbar(),
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(

            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
               Padding(
                 padding: EdgeInsets.only(top: 10,right: 10,left: 20),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text('ข่าว',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                     Visibility(

                       child: Text('17 มกราคม 2020'),
                       visible: _visibleDate,

                     ),
                     IconButton(
                       icon:  Icon(FontAwesomeIcons.calendarAlt,color: _colorIcCalendar,),
                       onPressed: () {
                       print("calendar");
                       setState(() {
                         toggle = !toggle;
                         _visibleDate = !_visibleDate;
                         if(toggle == true){
                           _colorIcCalendar = Colors.black;
                         }else{
                           _colorIcCalendar = Colors.red;
                         }
                       });
                       },
                     ),
                   ],
                 ),
               ),
                AnimatedSizeAndFade(
                  vsync: this,
                  child: toggle ? myCalendarOf : myCalendarOn,
                  fadeDuration: const Duration(milliseconds: 300),
                  sizeDuration: const Duration(milliseconds: 600),
                ),

              ]
            ),
          )
        ],
      ),
      ),
    );
  }


  Widget myAppbar(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(FontAwesomeIcons.alignLeft),
      ),
    );
  }

Widget _buildEventsMarker(DateTime date, List events) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: _calendarController.isSelected(date)
          ? Colors.brown[500]
          : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
    ),
    width: 16.0,
    height: 16.0,
    child: Center(
      child: Text(
        '${events.length}',
        style: TextStyle().copyWith(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    ),
  );
}
}
