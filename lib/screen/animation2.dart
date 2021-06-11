import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'Splash_Screen1.dart';

class AnimatedImage2 extends StatefulWidget {
  @override
  _AnimatedImage2State createState() => _AnimatedImage2State();
}

class _AnimatedImage2State extends State<AnimatedImage2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);
  late Animation<Offset> _animation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0, 0.03),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/Directions1.svg',
          width: MediaQuery.of(context).size.width,
          height: 435,
        ),
        SlideTransition(
          position: _animation,
          child: SvgPicture.asset(
            'assets/Directions2.svg',
            width: MediaQuery.of(context).size.width,
            height: 430,
          ),
        ),
      ],
    );
  }
}
