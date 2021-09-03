import 'package:bibili_flutter/db/hi_cache.dart';
import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/dao/login_dao.dart';
import 'package:bibili_flutter/page/registration_page.dart';
import 'package:bibili_flutter/util/string_util.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:bibili_flutter/widget/appbar.dart';
import 'package:bibili_flutter/widget/login_button.dart';
import 'package:bibili_flutter/widget/login_effect.dart';
import 'package:bibili_flutter/widget/login_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const userNameK = "bili_username";
  static const passwordK = "bili_password";
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? passWord;
  final nameController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cacheName = HiCache.getInstance().get(userNameK);
    final cachePwd = HiCache.getInstance().get(passwordK);

    if (cacheName != null && cachePwd != null) {
      nameController.text = cacheName;
      pwdController.text = cachePwd;
      userName = cacheName;
      passWord = cachePwd;
      setState(() {
        loginEnable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登陆', '注册', () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegistrationPage(
              onJumpToLogin: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            );
          }),
        );
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              '用户名',
              '请输入用户',
              controller: nameController,
              onChanged: (text) {
                userName = text;
                checkInPut();
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              controller: pwdController,
              obscureText: true,
              onChanged: (text) {
                passWord = text;
                checkInPut();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                '登陆',
                enable: loginEnable,
                onPressed: send,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInPut() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(passWord)) {
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
      var result = await LoginDao.login(userName!, passWord!);
      if (result["code"] == 0) {
        print('登录成功');
        showToast('登录成功');
        HiCache.getInstance().setString(userNameK, userName!);
        HiCache.getInstance().setString(passwordK, passWord!);
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
}
