import 'package:redux/redux.dart';
import 'book.dart';

//可以使用combineReducers，将action和函数绑定起来,减少getReduce里面的代码量



final BookReducer = combineReducers<Book>([
  TypedReducer<Book,AddBookAction>(_add),
  TypedReducer<Book,UpdateBookAction>(_update)

]);

Book _add(Book book, AddBookAction addBookAction){
  book = addBookAction.book;
  return book;
}

class AddBookAction{
  Book book;
  AddBookAction(this.book);
}

 Book _update(Book book,UpdateBookAction updateBookAction){
  //updateBookAction.book.name = "暂无书名";
  book = updateBookAction.book;
  return book;
}
class UpdateBookAction{
  Book book;
  UpdateBookAction(this.book);
}