import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/RecommendMajor.dart';
import 'package:student_guidance/model/StudentFavorite.dart';
import 'package:student_guidance/model/Tcas.dart';
import 'package:student_guidance/page/search-new/itemCareer-new.dart';
import 'package:student_guidance/service/CareerService.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/StudentFavoriteService.dart';
import 'package:student_guidance/service/StudentReccommendService.dart';
import 'package:student_guidance/service/TcasService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:student_guidance/widgets/swiper_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemMajorNew extends StatefulWidget {
  final String universityName;
  final String facultyName;
  final DocumentSnapshot major;
  final DocumentSnapshot listTcas;
  final List<StudentFavorite> listFavorite;

  const ItemMajorNew(
      {Key key,
      this.universityName,
      this.facultyName,
      this.major,
      this.listTcas,
      this.listFavorite})
      : super(key: key);

  @override
  _ItemMajorNewState createState() => _ItemMajorNewState();
}

class _ItemMajorNewState extends State<ItemMajorNew>
    with SingleTickerProviderStateMixin {
  bool _isFollow;

  @override
  void initState() {
    super.initState();
    StudentFavorite favorite = widget.listFavorite.singleWhere(
        (favorite) =>
            favorite.university == widget.universityName &&
            favorite.faculty == widget.facultyName &&
            favorite.major == Major.fromJson(widget.major.data).majorName,
        orElse: () => null);
    _isFollow = favorite != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final Major itemMajor = Major.fromJson(widget.major.data);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: ShaderMask(
              shaderCallback: (bound) => RadialGradient(
                      radius: 4.0,
                      colors: [Colors.yellow, Colors.white],
                      center: Alignment.topLeft,
                      tileMode: TileMode.clamp)
                  .createShader(bound),
              child: Shimmer.fromColors(
                  child: Text(
                    UIdata.txItemMajorTitle,
                    style: UIdata.textTitleStyle,
                  ),
                  baseColor: Colors.greenAccent,
                  highlightColor: Colors.red,
                  period: const Duration(milliseconds: 3000))),
          leading: ShaderMask(
              shaderCallback: (bound) => RadialGradient(
                      radius: 5.0,
                      colors: [Colors.greenAccent, Colors.blueAccent],
                      center: Alignment.topLeft,
                      tileMode: TileMode.clamp)
                  .createShader(bound),
              child: Shimmer.fromColors(
                child: IconButton(
                  icon: UIdata.backIcon,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                baseColor: Colors.greenAccent,
                highlightColor: Colors.blueAccent,
                period: const Duration(milliseconds: 3000),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itemMajor.majorName,
                      style: UIdata.textTitleStyleDark27,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.facultyName,
                              style: UIdata.textTitleStyleDark,
                            ),
                            AutoSizeText(
                              widget.universityName,
                              style: UIdata.textTitleStyleDarkUninersity,
                              minFontSize: 8,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        //Favorite button
                        FlatButton.icon(
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: _isFollow ? Colors.green : Colors.red,
                              width: 2,
                            ),
                          ),
                          color: _isFollow ? Colors.green : Colors.white,
                          icon: Icon(
                            _isFollow
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: Colors.red,
                            size: 25,
                          ),
                          label: Text(
                            _isFollow ? 'กำลังติดตาม' : 'ติดตามสาขา',
                            style: TextStyle(
                                fontSize: 14,
                                color: _isFollow ? Colors.white : Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            setState(() {
                              StudentFavorite favorite = StudentFavorite();
                              favorite.university = widget.universityName;
                              favorite.faculty = widget.facultyName;
                              favorite.major =
                                  Major.fromJson(widget.major.data).majorName;

                              _isFollow = !_isFollow;
                              _isFollow
                                  ? StudentFavoriteService()
                                      .addStudentFavorite(favorite)
                                  : StudentFavoriteService()
                                      .deleteStudentFavorite(favorite);
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    itemMajor.albumImage != null
                        ? itemListImage(itemMajor.albumImage)
                        : SizedBox(
                            height: 1,
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'รายละเอียดสาขา',
                          style: UIdata.textMajorTitleStyle18Orange,
                        ),
                        Text(
                          itemMajor.detail,
                          style: UIdata.textMajorDetailStyle15Grey,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ระดับปริญญา',
                              style: UIdata.textMajorTitleStyle18Orange,
                            ),
                            Text(
                              '- ' + itemMajor.degree,
                              style: UIdata.textMajorDetailStyle15Grey,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'วุฒิการศึกษา',
                              style: UIdata.textMajorTitleStyle18Orange,
                            ),
                            Text(
                              '- ' + itemMajor.certificate,
                              style: UIdata.textMajorDetailStyle15Grey,
                            )
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'เพิ่มเติมเกี่ยวกับสาขา',
                              style: UIdata.textMajorTitleStyle18Orange,
                            ),
                            InkWell(
                              onTap: () => launch(
                                  itemMajor.url.startsWith('https://') ||
                                          itemMajor.url.startsWith('http://')
                                      ? itemMajor.url
                                      : 'http://${itemMajor.url}'),
                              child: Text(
                                itemMajor.url,
                                style: TextStyle(
                                    color: Color(0xff939191), fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xffEBEBEB),
                thickness: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'การรับสมัคร',
                      style: UIdata.textMajorTitleStyle18Dark,
                    ),
                    FutureBuilder<List<DocumentSnapshot>>(
                        future: TcasService()
                            .getListTcasByMajorRef(widget.major.reference),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Tcas> listTcas = snapshot.data
                                .map((snap) => Tcas.fromJson(snap.data))
                                .toList();

                            return DefaultTabController(
                              length: listTcas.length,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: TabBar(
                                      indicatorColor: Color(0xffFF9211),
                                      labelColor: Color(0xffFF9211),
                                      unselectedLabelColor: Color(0xff939191),
                                      isScrollable: true,
                                      tabs: listTcas
                                          .map((tcas) => Tab(
                                                text: 'รอบ ${tcas.round}',
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 250.0,
                                    child: TabBarView(
                                        children: listTcas.map(
                                      (tcas) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('ข้อมูลการรับเข้า',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xffFF9211),
                                                    )),
                                                Center(
                                                  child: Text(
                                                    tcas.startDate != null
                                                        ? ('เริ่มรับสมัคร ' +
                                                            DateFormat(
                                                                    'dd MMMM',
                                                                    'th')
                                                                .format(tcas
                                                                    .startDate
                                                                    .toDate()) +
                                                            ' - ' +
                                                            DateFormat(
                                                                    'dd MMMM yyyy',
                                                                    'th')
                                                                .format(
                                                              tcas.endDate
                                                                  .toDate(),
                                                            ))
                                                        : 'เริ่มรับสมัคร : รออัพเดทข้อมูล เร็วๆ นี้',
                                                    style: UIdata
                                                        .textMajorDetailStyle15Grey,
                                                  ),
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'รับสมัคร',
                                                          style: UIdata
                                                              .textMajorTitleStyle18Orange,
                                                        ),
                                                        Text(
                                                            tcas.startDate !=
                                                                    null
                                                                ? DateFormat(
                                                                            'dd MMM',
                                                                            'th')
                                                                        .format(tcas
                                                                            .startDate
                                                                            .toDate()) +
                                                                    ' - ' +
                                                                    DateFormat(
                                                                            'dd MMM yyyy',
                                                                            'th')
                                                                        .format(tcas
                                                                            .endDate
                                                                            .toDate())
                                                                : 'รออัพเดทข้อมูล เร็วๆ นี้',
                                                            style: UIdata
                                                                .textMajorDetailStyle15Grey),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 1,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xffEBEBEB)),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'จำนวนที่รับ',
                                                          style: UIdata
                                                              .textMajorTitleStyle18Orange,
                                                        ),
                                                        Text(
                                                            tcas.entranceAmount
                                                                    .toString() +
                                                                ' ที่นั่ง',
                                                            style: UIdata
                                                                .textMajorDetailStyle15Grey),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                Text(
                                                  'ข้อมูลเพิ่มเติม',
                                                  style: UIdata
                                                      .textMajorTitleStyle18Orange,
                                                ),
                                                tcas.url == null
                                                    ? Text(
                                                        'รออัพเดทขอมูลเร็วๆ นี้',
                                                        style: UIdata
                                                            .textMajorDetailStyle15Grey,
                                                      )
                                                    : InkWell(
                                                        onTap: () => launch(tcas
                                                                    .url
                                                                    .startsWith(
                                                                        'https://') ||
                                                                tcas.url
                                                                    .startsWith(
                                                                        'http://')
                                                            ? tcas.url
                                                            : 'http://${tcas.url}'),
                                                        child: Text(tcas.url,
                                                            style: UIdata
                                                                .textMajorDetailStyle15Grey),
                                                      )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'ยังไม่เปิดรับสมัคร',
                                  style: UIdata.textMajorTitleStyle18Red,
                                ),
                                Image.asset(
                                  'assets/images/tcas-not-found.png',
                                  fit: BoxFit.cover,
                                  height: 130,
                                ),
                              ],
                            );
                          }
                        })
                  ],
                ),
              ),
              Divider(
                color: Color(0xffEBEBEB),
                thickness: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'อาชีพที่น่าสนใจในสาขานี้',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: itemMajor.listCareerName.map((career) {
                          return FutureBuilder<DocumentSnapshot>(
                            future:
                                CareerService().getCareerByCarrerName(career),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Career itemCareer =
                                    Career.fromJson(snapshot.data.data);
                                return careerItem(itemCareer, snapshot.data);
                              } else {
                                return Text(' - ไม่พบอาชีพที่เกี่ยวข้อง');
                              }
                            },
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget careerItem(Career career, DocumentSnapshot docCareer) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemCarrerNew(career: docCareer)));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: FutureBuilder(
            future: GetImageService().getImage(career.image),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data),
                      radius: 40,
                    ),
                    AutoSizeText(
                      career.careerName,
                      maxLines: 2,
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/career.jpg'),
                      radius: 40,
                    ),
                    Text(career.careerName),
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget itemListImage(List<dynamic> listImg) {
    return FutureBuilder(
      future: GetImageService().getListImage(listImg),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 150,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Swiper(
                autoplayDelay: Duration(seconds: 10).inMilliseconds,
                duration: Duration(seconds: 2).inMilliseconds,
                autoplay: snapshot.data.length == 1 ? false : true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data[index]),
                              fit: BoxFit.cover)));
                },
                itemCount: snapshot.data.length,
                pagination: SwiperPagination(
                  builder: CustomePaginationBuilder(
                      activeSize: Size(15, 25),
                      size: Size(10, 20),
                      color: Colors.grey.shade300,
                      activeColor: Colors.green),
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 1,
          );
        }
      },
    );
  }
}
