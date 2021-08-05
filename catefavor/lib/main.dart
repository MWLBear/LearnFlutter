import 'package:flutter/material.dart';
import 'package:catefavor/ui/shared/app_them.dart';
import 'package:catefavor/core/router/router.dart';
import 'package:catefavor/ui/shared/size_fit.dart';
import 'package:provider/provider.dart';
import 'package:catefavor/core/viewmodel/meal_view_model.dart';
void main() {
  runApp(
      ChangeNotifierProvider(
        create: (ctx) => LZMealViewModel() ,
        child: MyApp(),
      )
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LZSizeFit.initialize();
    return MaterialApp(
      title: '美食广场',
      theme: APPTheme.lightThem,
      initialRoute: LZRouter.initialRoute,
      routes: LZRouter.routes,
      onGenerateRoute: LZRouter.generateRoute,
      onUnknownRoute: LZRouter.unknownRote,
    );
  }
}
