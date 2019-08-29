import 'package:student_guidance/model/University.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/page/Views/view-education-detail2.dart';
import 'package:student_guidance/styleguide.dart';

class EdicationWidget extends StatelessWidget {
  final String educationName;

  const EdicationWidget({Key key, this.educationName}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (){
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context,_,__) => ViewEducationDetailScreen(name : educationName)
        )
        );
      },
     
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CharacterCardBackgroundClipper(),
              child: Hero(
                  tag: "background-${educationName}",
                  child: Container(
                      height: 0.6 * screenHeight,
                  width: 0.9 * screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:[Colors.green.shade200, Colors.greenAccent.shade400],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  ),
                ),
              ),
            ),
              Align(
            alignment: Alignment(0, -0.5),
            child: Hero(
              tag: "image_name",
              child: Image.asset('assets/images/maejo.png',
                height: screenHeight * 0.35,
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 48, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: "Education",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      child: Text(
                          educationName,
                        style: AppTheme.heading,
                      ),
                    ),
                  ),
                ),
                Text(
                  "แตะดูรายละเอียดเพิ่มเติม",
                  style: AppTheme.subHeading,
                ),
              ],
            ),
          ),


        ],
          ) ,      
      );

  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 30;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(
        size.width + 1, size.height - 1, size.width, size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(
        size.width - 1, 0, size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}