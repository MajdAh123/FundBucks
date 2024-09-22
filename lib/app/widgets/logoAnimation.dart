import 'package:app/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingLogoWidget extends StatefulWidget {
  const LoadingLogoWidget({super.key, this.width = 80});
  final double width;
  @override
  _LoadingLogoWidgetState createState() => _LoadingLogoWidgetState();
}

class _LoadingLogoWidgetState extends State<LoadingLogoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _opacityloading;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.1),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityloading = Tween<double>(begin: 0.8, end: 0.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  width: widget.width,
                  child: FadeTransition(
                    opacity: _opacityloading,
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: mainColor,
                      size: widget.width * 0.9,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                // alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: widget.width * 0.5,
                      child: SlideTransition(
                        position: _positionAnimation,
                        child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: Image.asset(
                            'assets/images/pngLogo.png',
                            width: widget.width * 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
