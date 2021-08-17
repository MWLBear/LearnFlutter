import 'package:flutter/material.dart';
import 'package:catefavor/ui/shared/app_them.dart';
import 'package:catefavor/core/router/router.dart';
import 'package:catefavor/ui/shared/size_fit.dart';
import 'package:provider/provider.dart';
import 'package:catefavor/core/viewmodel/meal_view_model.dart';
import 'package:catefavor/core/viewmodel/favor_view_model.dart';
import 'package:catefavor/core/viewmodel/filter_view_model.dart';
import 'package:catefavor/core/user_default/sputils.dart';

void main() {

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => LZFilterViewModel()),
          ChangeNotifierProxyProvider<LZFilterViewModel,LZMealViewModel>(
              create: (ctx) => LZMealViewModel(),
              update: (ctx,filterVM,mealVM){
                mealVM!.updateFilters(filterVM);
                return mealVM;
              }),
          ChangeNotifierProxyProvider<LZFilterViewModel,LZFavorViewModel>(
              create: (ctx) => LZFavorViewModel(),
              update: (ctx,filterVM,favorVM){
                favorVM!.updateFilters(filterVM);
                return favorVM;
              }),

        ],
        child: MyApp() ,
      )
  );
  loadAsync();
}

void loadAsync() async {
  await SpUtils.getInstance(); //等待Sp初始化完成
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LZSizeFit.initialize();
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: '美食广场',
      theme: APPTheme.lightThem,
      initialRoute: LZRouter.initialRoute,
      routes: LZRouter.routes,
      onGenerateRoute: LZRouter.generateRoute,
      onUnknownRoute: LZRouter.unknownRote,
    );
  }
}
