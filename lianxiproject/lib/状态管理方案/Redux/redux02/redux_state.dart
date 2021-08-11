import 'user.dart';
import 'book.dart';
import 'user_reducer.dart';
import 'book_reducer.dart';

class LZReduxState {
  User user;
  Book book;
  LZReduxState(this.user,this.book);
}

LZReduxState getReduce(LZReduxState state,action){
  return LZReduxState(
      UserReducer(state.user,action),
      BookReducer(state.book,action));
}
