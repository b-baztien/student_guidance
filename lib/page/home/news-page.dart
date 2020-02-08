import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/service/NewsService.dart';
import 'package:student_guidance/utils/OvalRighBorberClipper.dart';
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

  myDrawer() {
    return ClipPath(
      clipper: OvalRighBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 40),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.grey.shade800,
                        ),
                        onPressed: () {}),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange])),
                    child: CircleAvatar(
                      radius: 40,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "school",
                    style: TextStyle(color: Colors.purple, fontSize: 15),
                  ),
                  Text(
                    "status",
                    style: TextStyle(color: Colors.orange, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildRow(
                      Icons.account_circle, "แก้ไขข้อมูลส่วนตัว", Colors.blue),
                  _buildDivider(),
                  _buildRow(Icons.add_to_photos, "เพิ่มข้อมูลการสอบ TCAS",
                      Colors.green),
                  _buildDivider(),
                  _buildRow(Icons.add_to_photos, "เพิ่มข้อมูลหลังการจบการศึกษา",
                      Colors.green),
                  _buildDivider(),
                  _buildRow(Icons.vpn_key, "แก้ไขข้อมูลส่วนตัว", Colors.yellow),
                  _buildDivider(),
                  _buildRow(
                      Icons.favorite, "แก้ไขข้อมูลส่วนตัว", Colors.red[300]),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.deepOrange,
    );
  }

  Widget _buildRow(IconData icon, String title, Color colors) {
    final TextStyle textStyle =
        TextStyle(color: Colors.black, fontFamily: 'kanit', fontSize: 15);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Icon(icon, color: colors),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Future<String> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString('schoolId');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var myCalendarOn = FutureBuilder(
        future: _getPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<Map<DateTime, List>>(
              stream: NewsService().getAllMapNewsBySchoolName(snapshot.data),
              builder: (context, snapshot) {
                print(snapshot.hasData);
                if (snapshot.hasData) {
                  return TableCalendar(
                    locale: 'th_TH',
                    calendarController: _calendarController,
                    events: snapshot.data,
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
                      weekendStyle:
                          TextStyle().copyWith(color: Colors.blue[600]),
                    ),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonVisible: false,
                    ),
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, _) {
                        return FadeTransition(
                          opacity: Tween(begin: 0.0, end: 1.0)
                              .animate(_animationController),
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
                } else {
                  return Text('');
                }
              },
            );
          } else {
            return Text('');
          }
        });

    var myCalendarOf = SizedBox(
      key: ValueKey("first"),
      height: 5,
    );

    return SafeArea(
      child: Scaffold(
        drawer: myDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
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
            FutureBuilder(
              future: _getPrefs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StreamBuilder<List<News>>(
                    stream: NewsService().getAllNewsBySchoolNameAndDate(
                        snapshot.data, _toDayCalendar),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.isNotEmpty) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => ListTile(
                                    title: Text(snapshot.data[index].topic),
                                  ),
                              childCount: snapshot.data.length),
                        );
                      } else {
                        return SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            Center(
                              child: Text(
                                'ไม่พบข่าวสำหรับวันนี้',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.brown),
                              ),
                            ),
                          ]),
                        );
                      }
                    },
                  );
                }
                return SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    Center(
                      child: Text(
                        'กำลังโหลด...',
                        style: TextStyle(fontSize: 15, color: Colors.brown),
                      ),
                    ),
                  ]),
                );
              },
            )
          ],
        ),
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
