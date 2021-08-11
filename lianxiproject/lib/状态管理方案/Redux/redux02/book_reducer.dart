import 'package:redux/redux.dart';
import 'book.dart';

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