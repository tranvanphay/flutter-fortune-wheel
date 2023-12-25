import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/src/const.dart';

///A widget indicator, which is arrow spin result
class ArrowView extends StatelessWidget {
  const ArrowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: Constants.ANGLE_OF_THE_ARROW,
      child: ClipPath(
        clipper: _ArrowClipper(),
        child: Container(
          height: Constants.ARROW_SIZE,
          width: Constants.ARROW_SIZE,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black12, Colors.black],
            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, blurRadius: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset center = size.center(Offset.zero);
    Path path = Path()
      ..lineTo(center.dx, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(center.dx, size.height / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
