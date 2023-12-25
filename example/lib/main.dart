import 'dart:async';
// import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_fortune_wheel_example/common/constants.dart';
import 'package:flutter_fortune_wheel_example/common/theme.dart';
import 'package:flutter_fortune_wheel_example/widgets/fortune_wheel_background.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MyApp(),
      title: 'Wheel of Fortune',
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final StreamController<Fortune> _resultWheelController =
      StreamController<Fortune>.broadcast();

  final List<Fortune> _resultsHistory = <Fortune>[];
  final StreamController<bool> _fortuneWheelController =
      StreamController<bool>.broadcast();

  final BackgroundPainterController _painterController =
      BackgroundPainterController();

  final Wheel _wheel = Wheel(
    items: Constants.icons,
    isSpinByPriority: true,
    duration: const Duration(seconds: 10),
  );

  @override
  void initState() {
    super.initState();
    _painterController.playAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _resultWheelController.close();
    _fortuneWheelController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC3DBF8),
      body: Stack(
        children: [
          FortuneWheelBackground(
            painterController: _painterController,
            child: Center(child: _buildFortuneWheel()),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildResultIsChange(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFortuneWheel() {
    return Center(
        child:
            //// StreamBuilder<bool>(
            //   stream: _fortuneWheelController.stream,
            //   builder: (context, snapshot) {
            //     if (snapshot.data == false) {
            //       return const SizedBox.shrink();
            //     }
            FortuneWheel(
      key: const ValueKey<String>('ValueKeyFortunerWheel'),
      wheel: _wheel,
      onChanged: (Fortune item) {
        _resultWheelController.sink.add(item);
      },
      onResult: _onResult,
    )
        //   },
        // ),
        );
  }

  Future<void> _onResult(Fortune item) async {
    // _confettiController.play();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 200,
                width: double.infinity,
                child: Lottie.asset(
                  'assets/cong_example.json',
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Spin value:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: item.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          item.titleName?.replaceAll('\n', '') ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (item.icon != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: item.icon,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _painterController.playAnimation();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Color(0xFF1B5E20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    _resultsHistory.add(item);
  }

  Widget _buildResultIsChange() {
    return StreamBuilder<Fortune>(
      stream: _resultWheelController.stream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(
              top: kIsWeb ? 0 : 16.0, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  snapshot.data != null
                      ? snapshot.data!.titleName?.replaceAll('\n', '') ?? ''
                      : _wheel.items[0].titleName?.replaceAll('\n', '') ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: snapshot.data != null
                    ? snapshot.data!.icon ?? const SizedBox()
                    : _wheel.items[0].icon ?? const SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// A custom Path to paint stars.
  // Path _drawStar(Size size) {
  //   // Method to convert degree to radians
  //   double degToRad(double deg) => deg * (pi / 180.0);
  //
  //   const numberOfPoints = 5;
  //   final halfWidth = size.width / 2;
  //   final externalRadius = halfWidth;
  //   final internalRadius = halfWidth / 2.5;
  //   final degreesPerStep = degToRad(360 / numberOfPoints);
  //   final halfDegreesPerStep = degreesPerStep / 2;
  //   final path = Path();
  //   final fullAngle = degToRad(360);
  //   path.moveTo(size.width, halfWidth);
  //
  //   for (double step = 0; step < fullAngle; step += degreesPerStep) {
  //     path.lineTo(halfWidth + externalRadius * cos(step),
  //         halfWidth + externalRadius * sin(step));
  //     path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
  //         halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  //   }
  //   path.close();
  //   return path;
  // }
}
