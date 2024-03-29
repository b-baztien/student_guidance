import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/News/view_news.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/NewsService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:table_calendar/table_calendar.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  bool toggle;
  String _toDay;
  DateTime _toDayCalendar;
  bool _isVisibleDate;
  Set<DateTime> dateSet = new Set<DateTime>();
  final formattedDate = DateFormat('dd MMMM yyyy', 'th');
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
      DateTime first, DateTime last, CalendarFormat format) {}

  void _onDaySelected(DateTime day, List events) {
    print(events);
    setState(() {
      _toDayCalendar = day;
      _toDay = DateFormat('dd MMMM yyyy', 'th').format(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var myCalendarOn = FutureBuilder(
        future: UIdata.getPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<Map<DateTime, List>>(
              stream: NewsService().getAllMapNewsBySchoolName(
                snapshot.data.getString('schoolId'),
              ),
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
                  return SizedBox.shrink();
                }
              },
            );
          } else {
            return SizedBox.shrink();
          }
        });

    var myCalendarOff = SizedBox(
      key: ValueKey("first"),
      height: 5,
    );

    return SafeArea(
      child: FutureBuilder(
          future: UIdata.getPrefs(),
          builder: (context, futureSnapshot) {
            if (futureSnapshot.hasData) {
              return Scaffold(
                drawer: MyDrawer(
                  student: Student.fromJson(
                      jsonDecode(futureSnapshot.data.getString('student'))),
                  schoolId: futureSnapshot.data.getString('schoolId'),
                  login: Login.fromJson(
                      jsonDecode(futureSnapshot.data.getString('login'))),
                ),
                body: CustomScrollView(
                  slivers: <Widget>[
                    Container(
                      child: SliverAppBar(
                        backgroundColor: Colors.black,
                        pinned: true,
                        expandedHeight: 250,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: <Widget>[
                              StreamBuilder(
                                stream: NewsService().getLastedNewsBySchoolName(
                                    futureSnapshot.data.getString('schoolId')),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewNewsPage(news: snapshot.data),
                                        ),
                                      ),
                                      child: FutureBuilder(
                                        future: GetImageService()
                                            .getImage(snapshot.data.image),
                                        builder: (_, snap) {
                                          if (snap.hasData) {
                                            return Stack(
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snap.data),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'ข่าวล่าสุด',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'kanit',
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          snapshot.data.topic,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'kanit',
                                                              fontSize: 25,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          '- ' +
                                                              snapshot.data
                                                                  .teacherName,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'kanit',
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child: Image.asset(
                                                'assets/images/no-photo-available.png',
                                                width: size.width,
                                                height: size.height,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Image.asset(
                                        'assets/images/no-photo-available.png',
                                        width: size.width,
                                        height: size.height,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, left: 20),
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
                                visible: toggle,
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
                                  setState(() {
                                    toggle = !toggle;
                                    _isVisibleDate = !_isVisibleDate;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        AnimatedCrossFade(
                          sizeCurve: Curves.easeIn,
                          firstChild: myCalendarOff,
                          secondChild: myCalendarOn,
                          duration: const Duration(milliseconds: 300),
                          crossFadeState: toggle
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),
                        Divider(),
                      ]),
                    ),
                    StreamBuilder<List<News>>(
                      stream: NewsService().getAllNewsBySchoolNameAndDate(
                          futureSnapshot.data.getString('schoolId'),
                          _toDayCalendar),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data.isNotEmpty) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Column(children: <Widget>[
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewNewsPage(
                                                            news: snapshot
                                                                .data[index])));
                                          },
                                          title: Text(
                                            snapshot.data[index].topic,
                                            style:
                                                UIdata.textNewsTitleStyleDark,
                                          ),
                                          subtitle: Text(formattedDate.format(
                                              snapshot.data[index].startTime
                                                  .toDate())),
                                          trailing: FutureBuilder(
                                            future: GetImageService().getImage(
                                                snapshot.data[index].image),
                                            builder: (context, snapImg) {
                                              if (snapImg.hasData) {
                                                return Container(
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              snapImg.data),
                                                          fit: BoxFit.cover)),
                                                );
                                              } else {
                                                return Container(
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/news-photo.png'),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Divider(),
                                      ]),
                                    ),
                                childCount: snapshot.data.length),
                          );
                        } else {
                          return SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                              Center(
                                child: Image.asset(
                                    'assets/images/not-found-news.png'),
                              ),
                            ]),
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            } else {
              return Scaffold();
            }
          }),
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
