import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class EditProfile extends StatelessWidget {
  static String tag = 'edit-profile';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: EditStudentProfile(),
    );
  }
}

class EditStudentProfile extends StatelessWidget {
  final String _fullName = 'องอาจ ใจทมิฬ';

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.1,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/studying.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://gazettereview.com/wp-content/uploads/2017/03/teacher1.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.lime,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Kanit',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w200,
    );
    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildDetailInfo(String detail) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        detail,
        style: TextStyle(
          fontFamily: 'Kanit',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildInputText(String value, String labelText, String hintText) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: TextFormField(
        initialValue: value,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print('โทร'),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    'โทร',
                    style: TextStyle(
                      fontFamily: ('Kanit'),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print('Message'),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'ส่งอีเมล์',
                      style: TextStyle(
                          fontFamily: 'Kanit', fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('แก้ไขข้อมูลส่วนตัว'),
          leading: IconButton(
            icon: UIdata.actionIcon,
            onPressed: () {
              Navigator.pushNamed(context, UIdata.homeTag);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  _buildCoverImage(screenSize),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: screenSize.height / 5),
                          _buildProfileImage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 600),
                      SizedBox(height: 15.0),
                      _buildDetailInfo('แก้ไขข้อมูล'),
                      _buildSeparator(screenSize),
                      _buildInputText('องอาจ', 'ชื่อ', 'กรุณากรอกชื่อ'),
                      _buildInputText('ใจทมิฬ', 'นามสกุล', 'กรุณากรอกนามสกุล'),
                      _buildInputText('081-2345678', 'เบอร์โทรศัพท์',
                          'กรุณากรอกชืเบอร์โทรศัพท์'),
                      _buildInputText(
                          'ggg@ggg.com', 'อีเมล์', 'กรุณากรอกอีเมล์'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildDetailItem('เบอร์โทรศัพท์', '081-2345678'),
                          _buildDetailItem('อีเมล์', 'ggg@ggg.com'),
                        ],
                      ),
                      _buildButtons(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
