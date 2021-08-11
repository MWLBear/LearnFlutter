import 'user.dart';
import 'book.dart';
import 'user_reducer.dart';
import 'book_reducer.dart';

/// 定义一个state
class LZReduxState {
  User user;
  Book book;
  LZReduxState(this.user,this.book);
}

/// 定义action，将action放到各自的reducer类里去定义


/// 定义reducer
LZReduxState getReduce(LZReduxState state,action){
  return LZReduxState(
      UserReducer(state.user,action),
      BookReducer(state.book,action));
}
