import 'package:flutter/material.dart';

Widget getText() {
  return Text("《定风波》 苏轼 \n莫听穿林打叶声，何妨吟啸且徐行。\n竹杖芒鞋轻胜马，谁怕？一蓑烟雨任平生。",
    textAlign: TextAlign.center,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    // textScaleFactor: 1.25,
    style: TextStyle(
        fontSize: 20,
        color: Colors.purple
    ),
  );
}

Widget getSpanText(){
  return Text.rich(
    TextSpan(
        children: [
          TextSpan(text: "《定风波》",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)),
          TextSpan(text: "苏轼",style: TextStyle(fontSize: 18,color: Colors.redAccent)),
          TextSpan(text: "\n莫听穿林打叶声，何妨吟啸且徐行。\n竹杖芒鞋轻胜马，谁怕？一蓑烟雨任平生。")
        ]
    ),
    style: TextStyle(fontSize: 20,color: Colors.purple),
    textAlign: TextAlign.center,
  );
}

Widget getButton(){
  return Column(
    children: [
      FloatingActionButton(child: Text("FloatingActionButton"),onPressed: (){
        print("FloatingActionButton");
      }),
      RaisedButton(onPressed: (){
        print("RaisedButton");
      },child: Text("RaisedButton")),
      ElevatedButton(child: Text("ElevatedButton"),onPressed: (){
        print("ElevatedButton");
      }),

      FlatButton(onPressed: (){
        print("FlatButton");
      }, child: Text("FlatButton")),
      TextButton(onPressed: (){
        print("TextButton");
      }, child: Text("TextButton")),
      OutlineButton(onPressed: (){
        print("OutlineButton");

      },child: Text("OutlineButton")),
      OutlinedButton(onPressed: (){
        print("OutlinedButton");
      }, child: Text("OutlinedButton")),

      RaisedButton(onPressed: (){
        print("同意协议");
      },
        child: Text("同意协议",style: TextStyle(color: Colors.white)),
        color: Colors.orange,
        highlightColor: Colors.orange[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      ElevatedButton(
          onPressed: (){
            print("同意协议");
          },
          child: Text("同意协议"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange[700]),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            elevation: MaterialStateProperty.all(0),
            // overlayColor: MaterialStateProperty.all(Colors.orange[700])
          )
      )
    ],
  );
}

Widget getNetImage() {
  return Center(
    child: Container(
      child: Image.network(
        "http://img0.dili360.com/ga/M01/48/3C/wKgBy1kj49qAMVd7ADKmuZ9jug8377.tub.jpg",
        alignment: Alignment.topCenter,
        repeat: ImageRepeat.repeatY,
        color: Colors.red,
        colorBlendMode: BlendMode.colorDodge,
      ),
      width: 300,
      height: 300,
      color: Colors.yellow,
    ),
  );
}

Widget getLocationImage() {
  return Center(
    child: Container(
      width: 300,
      height: 300,
      color: Colors.yellow,
      child: Image.asset("images/1.png"),
    ),
  );
}

Widget getCircleIconImage(){
  return ListView(
    children: [
      CircleAvatar(
        radius: 100,
        backgroundImage: NetworkImage(
            "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg"),
        child: Container(
          child: Text("兵长利威尔"),
          alignment: Alignment(0, .5),
          width: 200,
          height: 200,
        ),
      ),
      Center(
        child: ClipOval(
          child: Image.network(
              "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg",
              width: 200,
              height: 200),
        ),
      ),

      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
              "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg",
              width: 200,
              height: 200),
        ),
      )
    ],
  );
}

Widget getTextField(){
  return  Container(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFieldDemo()
      ],
    ),
  );
}
class TextFieldDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TextFiedDemoState();
  }
}
class _TextFiedDemoState extends State<TextFieldDemo>{

  final textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = "Hello World";
    textEditingController.addListener(() {
      print("textEditingController:${textEditingController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          icon: Icon(Icons.people),
          labelText: "username",
          hintText: '请输入用户名',
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white
      ),
      onChanged: (value){
        print("onChanged:$value");
      },
      onSubmitted: (value){
        print("onSubmitted:$value");
      },
    );
  }
}

Widget getForm(){
  return FormDemo();
}
class FormDemo extends StatefulWidget {
  @override
  _FromDemoState createState() => _FromDemoState();
}
class _FromDemoState extends State<FormDemo>{
  final registerFormKey = GlobalKey<FormState>();
  String? username, password;
  void registerForm(){
    registerFormKey.currentState?.save();
    registerFormKey.currentState?.validate();
    print("username:$username password:$password");
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.people),
                  labelText: "用户名或者手机号"
              ),
              onSaved: (value){
                this.username = value;
              },
              validator: (value){
                if (value!.isEmpty){
                  return "账号不能为空";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "密码"
              ),
              onSaved: (value){
                this.password = value;
              },
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: registerForm,
                child: Text("注册"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))

                ),
              ),
            )
          ],
        )
    );
  }
}