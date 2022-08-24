import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:devtailor_task_richardas/appcolors.dart';
import 'package:devtailor_task_richardas/signupform.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const SignupPageBackground(),
              Center(
                child: CustomScrollView(
                  scrollBehavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: kIsWeb ? 80 : 30,),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 300,
                              minWidth: 300,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/devtailor_logo.svg',
                                  width: 200,
                                  height: 58,
                                ),
                                const SizedBox(height: 40,),
                                const Text(
                                  "Let's get started",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 24,),
                                const SignupForm(),
                                const SizedBox(height: 20,),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      'Log In',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 80,),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              'Customer support',
                              style: TextStyle(
                                fontSize: 14,
                                // fontWeight: FontWeight.w400,
                                color: AppColors.blueAccent,
                              ),
                            ),
                          ),
                          SizedBox(height: kIsWeb ? 50 : 30,),
                        ],
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
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    this.offset = const Offset(0, 0),
    required this.radius,
    required this.color,
  });

  final Offset offset;
  double radius;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SignupPageBackground extends StatelessWidget {
  const SignupPageBackground({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width < 1200) {
      return Container();
    }
    return Stack(
      children: [
        // Left bubbles.
        CustomPaint(
          painter: CirclePainter(offset: Offset(0, size.height / 2 - 200), radius: 50, color: Colors.green.shade600),
        ),
        CustomPaint(
          painter: CirclePainter(offset: Offset(0, size.height / 2 + 200), radius: 300, color: AppColors.blueAccent.withOpacity(0.3)),
        ),
        // // Top bubbles.
        CustomPaint(
          painter: CirclePainter(offset: Offset(size.width / 2 + 100, 0), radius: 20, color: Colors.green.shade600),
        ),
        CustomPaint(
          painter: CirclePainter(offset: Offset(size.width / 2 + 250, 0), radius: 120, color: Colors.blueAccent.withOpacity(0.4)),
        ),
        // Bottom right bubbles.
        CustomPaint(
          painter: CirclePainter(offset: Offset(size.width - 130, size.height / 5 * 3), radius: 100, color: Colors.green.shade400),
        ),
        CustomPaint(
          painter: CirclePainter(offset: Offset(size.width, size.height / 5 * 3 + 300), radius: 200, color: AppColors.blueAccent.withOpacity(0.3)),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 120,
              sigmaY: 120,
            ),
            child: Container(),
          ),
        ),
      ],
    );
  }
}
