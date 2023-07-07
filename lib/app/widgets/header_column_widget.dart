import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class HeaderColumnWidget extends StatefulWidget {
  final String title;
  final String value;
  final bool isRight;
  final double textWidth;
  const HeaderColumnWidget({
    super.key,
    required this.title,
    required this.value,
    required this.textWidth,
    this.isRight = true,
  });

  @override
  State<HeaderColumnWidget> createState() => _HeaderColumnWidgetState();
}

class _HeaderColumnWidgetState extends State<HeaderColumnWidget> {
  var tooltipController = JustTheController();

  @override
  void initState() {
    tooltipController = JustTheController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            widget.isRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 12.sp,
              //fontFamily: FontFamily.inter,
              fontWeight: FontWeight.w500,
              color: strokeColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          JustTheTooltip(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.value,
                style: TextStyle(
                  fontSize: widget.textWidth,
                  //fontFamily: FontFamily.inter,
                  fontWeight: FontWeight.w700,
                  color: mainColor,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            controller: tooltipController,
            child: InkWell(
              onTap: () => tooltipController.showTooltip(),
              child: Text(
                widget.value,
                style: TextStyle(
                  fontSize: widget.textWidth,
                  //fontFamily: FontFamily.inter,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
                textDirection:
                    !widget.isRight ? TextDirection.ltr : TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
