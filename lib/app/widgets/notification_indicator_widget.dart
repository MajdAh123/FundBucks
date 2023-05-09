import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationIndicatorWidget extends StatefulWidget {
  final bool hasNotification;
  const NotificationIndicatorWidget({
    Key? key,
    this.hasNotification = false,
  }) : super(key: key);

  @override
  State<NotificationIndicatorWidget> createState() =>
      _NotificationIndicatorWidgetState();
}

class _NotificationIndicatorWidgetState
    extends State<NotificationIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // _colorAnimationBigCircle = ColorTween(
    //   begin: Colors.transparent,
    //   end: Colors.orange.shade700,
    // ).animate(_animationController);

    _scaleAnimation =
        Tween<double>(begin: 3, end: 5.5).animate(_animationController);

    _animationController.addStatusListener((status) {
      // print(_animationController.value);
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/notification'),
      child: Stack(
        children: [
          widget.hasNotification
              ? Positioned(
                  right: 0,
                  top: 1.h,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    // duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.withOpacity(.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (widget.hasNotification) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                        // setState(() {});
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          widget.hasNotification
              ? Positioned(
                  right: 2.5.w,
                  top: 3.5.h,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: AnimatedContainer(
                          width: 5.w,
                          height: 5.h,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              focalRadius: .2,
                              transform: GradientRotation(90),
                              colors: [
                                Colors.orange
                                    .withOpacity(_animationController.value),
                                // Colors.transparent,
                                Colors.orange
                                    .withOpacity(_animationController.value)
                              ],
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (widget.hasNotification) {
                                _animationController.forward();
                              } else {
                                _animationController.reverse();
                              }
                              // setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
          Align(
            alignment: Alignment.center,
            child: Assets.images.svg.bell.svg(
              // color: isSelected ? mainColor : unselectedBottomBarItemColor,
              color: Colors.white,
              width: 26.w,
              height: 26.h,
            ),
          )
        ],
      ),
    );
  }
}
