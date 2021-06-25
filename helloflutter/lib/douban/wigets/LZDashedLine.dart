import 'package:flutter/material.dart';
class LZDashedLine extends StatelessWidget{
  final Axis? axis;
  final double dashedWidth;
  final double dashedHeight;
  final int? count;
  final Color color;
  LZDashedLine({
    @required this.axis,
    @required this.count,
    this.dashedWidth = 1,
    this.dashedHeight = 1,
    this.color =  Colors.black12
});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: this.axis!,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(this.count!, (int index) {
        return SizedBox(
          width: dashedWidth,
          height: dashedHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
          ),
        );
      }),
    );
  }
}