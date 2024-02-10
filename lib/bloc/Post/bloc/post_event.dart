part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPost extends PostEvent {}
class SearchPost extends PostEvent {
final String search;

const  SearchPost({required this.search});

@override
  List<Object> get props => [search];
}

class AddPost extends PostEvent {
  final String caption;
  final File image;
  final String createdAt;

  const AddPost({required this.caption, required this.image, required this.createdAt});
  @override
  List<Object> get props => [caption, image, createdAt];
}
