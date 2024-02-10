part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostFailed extends PostState {
  final String? messageError;

  PostFailed({required this.messageError});
}

final class PostLoaded extends PostState {
  final List<ModelPost>? model;

  PostLoaded({required this.model});
}

final class AddPostLoading extends PostState {}

final class AddPostFailed extends PostState {
  final String? messageError;

  AddPostFailed({required this.messageError});
}

final class AddPostSuccess extends PostState {
  final String? messageSuccess;

  AddPostSuccess({required this.messageSuccess});
}
