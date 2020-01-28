import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/service/NewsService.dart';
import 'package:table_calendar/table_calendar.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  CalendarController _calendarController;

  List _selectedEvents;
  AnimationController _animationController;
  bool toggle;
  String _toDay;
  DateTime _toDayCalendar;
  bool _isVisibleDate;
  Map<DateTime, List> _events;
  Map<DateTime, List> _eventsNews = new Map<DateTime, List>();
  Set<DateTime> dateSet = new Set<DateTime>();

  // @override
  // void initState() {
  //   super.initState();
  //   NewsService().getAllNewsBySchoolName('โรงเรียนทดสอบ').then((itemFromService){
  //     for(News news in itemFromService){
  //       dateSet.add(news.startTime.toDate());
  //     }
  //     for(DateTime datetime in dateSet){
  //       List<News> list = new List();
  //       for(News news in itemFromService){
  //           if(news.startTime.toDate() == datetime){
  //             list.add(news);
  //           }
  //       }

  //       _eventsNews[datetime] = list;
  //     }
  //     String getEventToday = DateFormat('dd/MM/yyyy').format(DateTime.now());
  //     print(getEventToday);
  //     _selectedEvents = _eventsNews[DateTime.now()] ?? [];
  //   });
  //   final _selectedDay = DateTime.now();
  //   _toDayCalendar = DateTime.now();
  //   _toDay = DateFormat('dd MMMM yyyy', 'th').format(_selectedDay);
  //   _calendarController = CalendarController();
  //   toggle = true;
  //   _visibleDate = true;

  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 300),
  //   );
  //   _animationController.forward();
  // }

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    _toDayCalendar = DateTime.now();
    _toDay = DateFormat('dd MMMM yyyy', 'th').format(_selectedDay);
    _calendarController = CalendarController();
    toggle = true;
    _isVisibleDate = true;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: $last');
  }

  void _onDaySelected(DateTime day, List events) {
    print(events);
    setState(() {
      _toDayCalendar = day;
      _toDay = DateFormat('dd MMMM yyyy', 'th').format(day);
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TableCalendar myCalendarOn = TableCalendar(
      locale: 'th_TH',
      calendarController: _calendarController,
      // events: _eventsNews,
      rowHeight: 50,
      initialCalendarFormat: CalendarFormat.week,
      initialSelectedDay: _toDayCalendar,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
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

    var myCalendarOf = SizedBox(
      key: ValueKey("first"),
      height: 5,
    );

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              title: myAppbar(),
              pinned: true,
              expandedHeight: 250,
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
              delegate: SliverChildListDelegate(<Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 10, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'ข่าว',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        child: Text(
                          _toDay,
                          style: TextStyle(fontSize: 18),
                        ),
                        visible: _isVisibleDate,
                      ),
                      IconButton(
                        icon: toggle
                            ? Icon(
                                FontAwesomeIcons.calendarAlt,
                                color: Colors.black,
                              )
                            : Icon(
                                FontAwesomeIcons.check,
                                color: Colors.green,
                              ),
                        onPressed: () {
                          if (toggle == true) {
                            print("calendar");
                          } else {
                            print("check");
                          }

                          setState(() {
                            toggle = !toggle;
                            _isVisibleDate = !_isVisibleDate;
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
              ]),
            ),
            StreamBuilder<List<News>>(
                stream: NewsService().getAllNewsBySchoolName('โรงเรียนทดสอบ'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                                title: Text(snapshot.data[index].topic),
                              ),
                          childCount: snapshot.data.length),
                    );
                  } else {
                    print('test ${snapshot.data}');
                    return SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        Center(
                          child: Text(
                            'ไม่พบข่าวสำหรับวันนี้',
                            style: TextStyle(fontSize: 15, color: Colors.brown),
                          ),
                        ),
                      ]),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget myAppbar() {
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
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
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
