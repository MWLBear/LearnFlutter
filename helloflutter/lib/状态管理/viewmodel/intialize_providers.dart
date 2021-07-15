
import 'package:provider/single_child_widget.dart';
import 'counter_view_model.dart';
import 'user_view_model.dart';
import '../model/user_info.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (ctx)=>HYCounterViewModel()),
  ChangeNotifierProvider(create: (ctx)=>HYUserViewModel(UserInfo("lz",20,"apple.com")))
];