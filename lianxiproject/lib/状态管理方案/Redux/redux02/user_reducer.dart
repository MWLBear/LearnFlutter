import 'user.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


final UserReducer = combineReducers<User>([
  TypedReducer<User,AddUserAction>(_add),
  TypedReducer<User,UpdateUserAction>(_update),

]);

User _add(User user,AddUserAction action){
  // action.user.name = "小名";
  user = action.user;
  return user;
}

class AddUserAction {
  User user;
  AddUserAction(this.user);
}


User _update(User user,UpdateUserAction action){
  // action.user.name = "匿名";
  user =  action.user;
  return user;
}

class UpdateUserAction {
  User user;
  UpdateUserAction(this.user);
}