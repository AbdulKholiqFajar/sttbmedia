import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_apps/model/modelPost.dart';
import 'package:social_media_apps/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository? repository;
  PostBloc({required this.repository}) : super(PostInitial()) {
    on<GetPost>(getPost);
    on<AddPost>(addPost);
    on<SearchPost>(search);
  }
  List? data;
  void search(SearchPost event, Emitter emit) async {
    final query = event.search;
    var result = data!.where((item) => item['caption'].toLowerCase().contains(query.toLowerCase())).toList();
    print('Query: $result');
    emit(PostLoading());
    if (query.isNotEmpty) {
      emit(PostLoaded(model: modelPostFromJson(jsonEncode(result))));
    }
  }

  void getPost(GetPost event, Emitter emit) async {
    var response = await repository!.getPost();
    print("Get POST: $response");
    data = response;
    emit(PostLoading());
    if (data!.isNotEmpty) {
      emit(PostLoaded(model: modelPostFromJson(jsonEncode(data))));
    } else {
      emit(PostFailed(messageError: response.toString()));
    }
  }

  void addPost(AddPost event, Emitter emit) async {
    String caption = event.caption;
    File image = event.image;
    String createdAt = event.createdAt;
    print(image.path);
    var response = await repository!.addPost(caption: caption, image: image, createdAt: createdAt);
    print("ADD POST: $response");
    emit(AddPostLoading());
    if (response['status'] == 'success') {
      emit(AddPostSuccess(messageSuccess: response['message']));
    } else {
      emit(AddPostFailed(messageError: response['message']));
    }
  }
}
