
part of 'post_bloc.dart'; //even类是 post_bloc 的一部分

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class PostFetched extends PostEvent {}
