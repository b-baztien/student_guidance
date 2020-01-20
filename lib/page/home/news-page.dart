import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:student_guidance/service/NewsService.dart';
import 'package:table_calendar/table_calendar.dart';
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin{
CalendarController _calendarController;
List _selectedEvents;
List<String> testList = ['xasdasd','asdasdasdasdasd','adxfkppllplpl'];
AnimationController _animationController;
bool toggle;
String _toDay;
bool _visibleDate;
Map<DateTime, List> _events;
@override
void initState() {
  super.initState();
  new NewsService().getAllNews();
  final _selectedDay = DateTime.now();
  _toDay = DateFormat('dd MMMM yyyy','th').format(_selectedDay);
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
    duration: const Duration(milliseconds: 300),

  );
  _animationController.forward();
}


void _onDaySelected(DateTime day, List events) {
  print(events);
  setState(() {
    _toDay = DateFormat('dd MMMM yyyy','th').format(day);
    _selectedEvents = events;
  });
}
void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
  print('CALLBACK: ${last}');
}


@override
void dispose() {
  _animationController.dispose();
  _calendarController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var  myCalendarOn = TableCalendar(
      locale: 'th_TH',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      rowHeight: 50,
      initialCalendarFormat: CalendarFormat.week,

      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },

      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
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
            color: Colors.green,
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
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

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
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
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );

   var myCalendarOf = SizedBox(key: ValueKey("first"),height: 5,);



    return SafeArea(
      child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
           title: myAppbar(),
            pinned: true,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/Rectangle.png',
                      width: size.width,
                      height: size.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],

              ),

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
                       child: Text(_toDay,style: TextStyle(fontSize: 18),),
                       visible: _visibleDate,

                     ),
                     IconButton(
                       icon:  toggle ? Icon(FontAwesomeIcons.calendarAlt,color: Colors.black,) :Icon(FontAwesomeIcons.check,color: Colors.green,) ,
                       onPressed: () {
                         if(toggle == true){
                           print("calendar");
                         }else{
                           print("check");
                         }

                       setState(() {
                         toggle = !toggle;
                         _visibleDate = !_visibleDate;

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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context,index)=>
              ListTile(
                title: Text("${_selectedEvents[index]}"),
              ),
              childCount: _selectedEvents.length
            ),

          )

        ],
      ),
      ),
    );
  }
Widget _buildEventList() {
  return ListView(
    children: _selectedEvents.map((event) => Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(event.toString()),
        onTap: () => print('$event tapped!'),
      ),
    ))
        .toList(),
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


Widget _buildHolidaysMarker() {
  return Icon(
    Icons.add_box,
    size: 20.0,
    color: Colors.blueGrey[800],
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
