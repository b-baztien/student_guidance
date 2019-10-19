import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class FavoriteHearth extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;
  final bool snapToEnd;

  FavoriteHearth(this.isOn, {this.snapToEnd, this.onToggle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onToggle,
        child: Container(
          child: FlareActor(
            'assets/animates/Heart_Follow.flr',
            snapToEnd: snapToEnd,
            animation: isOn ? 'Follow2' : 'UnFollow',
          ),
        ));
  }
}
