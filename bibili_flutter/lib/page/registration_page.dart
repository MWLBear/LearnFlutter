import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/dao/login_dao.dart';
import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:bibili_flutter/util/string_util.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:bibili_flutter/widget/appbar.dart';
import 'package:bibili_flutter/widget/login_button.dart';
import 'package:bibili_flutter/widget/login_effect.dart';
import 'package:bibili_flutter/widget/login_input.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登陆", () {
        HiNavigator.getInstance().onJump(RouteStatus.login);
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              '用户名',
              '请输入用户名',
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              '确认密码',
              '请输入确认密码',
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              '慕课网ID',
              '请输入你的慕课网用户ID',
              keyboardType: TextInputType.number,
              onChanged: (text) {
                imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              '课程订单号',
              '请输入课程订单号后四位',
              lineStretch: true,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: LoginButton("注册",
                  enable: loginEnable, onPressed: checkParams),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result =
          await LoginDao.registration(userName!, password!, imoocId!, orderId!);
      print(result);
      if (result['code'] == 0) {
        showToast('注册成功');
        //回到登录页
        HiNavigator.getInstance().onJump(RouteStatus.login);
      } else {
        print(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "两次密码不一致";
    } else if (orderId?.length != 4) {
      tips = "请输入订单的后四位";
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    send();
  }
}
