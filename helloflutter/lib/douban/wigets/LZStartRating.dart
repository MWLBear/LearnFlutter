import 'package:flutter/material.dart';

class LZStartRating extends StatefulWidget {

  final double? rating;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;
  final double maxRating;
  final Widget? unselectedImage;
  final Widget? selectedImage;

  LZStartRating({
    @required this.rating ,
    this.maxRating = 10.0,
    this.size = 30.0,
    this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = const Color(0xffe0aa46),
    this.count = 5,
    Widget? unselectedImage ,
    Widget? selectedImage ,
}) : unselectedImage = unselectedImage ?? Icon(Icons.star,size: size,color: unselectedColor,),
        selectedImage = selectedImage ?? Icon(Icons.star,size: size,color: selectedColor,);

  @override
  _LZStartRatingState createState() => _LZStartRatingState();
}

class _LZStartRatingState extends State<LZStartRating> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Row(children: getUnSelectedImage(),mainAxisSize: MainAxisSize.min,),
          Row(children: getSelectedImage(),mainAxisSize: MainAxisSize.min,),
        ],
      ),
    );
  }

  List<Widget> getUnSelectedImage() {
    return List.generate(widget.count, (index) => widget.unselectedImage!);
  }
  List<Widget> getSelectedImage(){
    double onValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating! / onValue).floor();
    double leftValue = widget.rating! - entireCount * onValue;
    double leftRatio = leftValue / onValue;

    List<Widget> selectedImages = [];
    for(int i = 0; i < entireCount; i++){
      selectedImages.add(widget.selectedImage!);
    }
    Widget leftStar = ClipRect(
      clipper: MyRectClipper(width: leftRatio * widget.size),
      child: widget.selectedImage,
    );
    selectedImages.add(leftStar);
    return selectedImages;
  }
}


class MyRectClipper extends CustomClipper<Rect> {
  final double? width;
  MyRectClipper({ @required this.width});
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width!, size.height);
  }
  @override
  bool shouldReclip( MyRectClipper oldClipper) {
    // TODO: implement shouldReclip
    return width != oldClipper.width;
  }
}
