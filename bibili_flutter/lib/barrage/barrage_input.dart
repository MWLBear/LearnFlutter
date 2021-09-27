import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:flutter/material.dart';

///弹幕输入界面
class BarrageInput extends StatelessWidget {
  final VoidCallback onTabClose;
  const BarrageInput({Key? key, required this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              onTabClose();
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.transparent,
            ),
          )),
          SafeArea(
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  hiSpace(width: 5),
                  _buildInput(textEditingController, context),
                  _buildSendBtn(textEditingController, context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildInput(
      TextEditingController textEditingController, BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          autofocus: true,
          controller: textEditingController,
          onSubmitted: (value) {
            _send(value, context);
          },
          cursorColor: primary,
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              hintText: "发个友善的弹幕见证当下"),
        ),
      ),
    );
  }

  _buildSendBtn(
      TextEditingController textEditingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = textEditingController.text.trim();
        _send(text, context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.send_rounded,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _send(String value, BuildContext context) {
    if (value.isNotEmpty) {
      onTabClose();
      Navigator.pop(context, value);
    }
  }
}
