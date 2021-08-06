import 'package:flutter/material.dart';
import 'package:catefavor/core/extension/int_extension.dart';
class LZOperationItem extends StatelessWidget {
  final Widget _icon;
  final String _title;
  final Color titleColor ;
  LZOperationItem(this._icon,this._title,{this.titleColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      width: 80.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon,
          SizedBox(width: 3.px,),
          Text(_title)
        ],
      ),
    );
  }
}
