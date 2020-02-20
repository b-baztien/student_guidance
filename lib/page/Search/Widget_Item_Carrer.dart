import 'package:flutter/material.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ItemCarrer extends StatefulWidget {
  final String carrer;

  const ItemCarrer({Key key, this.carrer}) : super(key: key);
  @override
  _ItemCarrerState createState() => _ItemCarrerState();
}

class _ItemCarrerState extends State<ItemCarrer> {
  Career carrerItem = new Career();
  List<Major> listMajor = new List<Major>();
  String img =
      'https://studentguidance-1565684067738.web.app/assets/img/no-photo-available.png';
  String des = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    // CareerService().getCareer(widget.carrer).then((carrerFromService) {
    //   MajorService()
    //       .getListMajor(carrerFromService.major)
    //       .then((listMajorFromService) {

    //     GetImageService()
    //         .getImage(carrerFromService.image)
    //         .then((imageFromService) {
    //       setState(() {
    //         carrerItem = carrerFromService;
    //         listMajor = listMajorFromService;

    //         des = carrerFromService.description;
    //         name = carrerFromService.careerName;
    //         img = imageFromService;
    //       });
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIdata.themeColor,
      appBar: AppBar(
        title: Text('ข้อมูลอาชีพ',
            style: TextStyle(
              fontFamily: UIdata.fontFamily,
              fontSize: 20,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
          ),
          Positioned(
            top: 75,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: 0,
            left: (MediaQuery.of(context).size.width / 2) - 75,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0, // has the effect of softening the shadow
                      spreadRadius: 1.0,
                      offset: Offset(
                        2.0,
                        2.0,
                      ),
                    )
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(img), fit: BoxFit.fill)),
              height: 150,
              width: 150,
            ),
          ),
          Positioned(
            top: 165,
            left: 25,
            right: 25,
            child: Container(
              height: (MediaQuery.of(context).size.height / 2),
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      des,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: UIdata.themeColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text(
                            "สาขาอาชีพที่เกี่ยวข้อง",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UIdata.fontFamily,
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: listMajor.length,
                      itemBuilder: (_, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(listMajor[index].majorName,
                              style: TextStyle(
                                  fontFamily: UIdata.fontFamily,
                                  fontSize: 16.0)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
