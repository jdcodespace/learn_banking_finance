import 'package:flutter/material.dart';

import '../../utils/color.dart';

class ProgressLoadingDialog extends StatelessWidget {
  final Widget? child;
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Animation<Color>? valueColor;

  const ProgressLoadingDialog({
    Key? key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.6,
    this.color = Colors.black,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall!) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity!,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: CColor.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(30),
              height: 100,
              width: 100,
              child: const Padding(
                padding: EdgeInsets.all(9.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
          )
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
