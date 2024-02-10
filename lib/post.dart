import 'dart:io';

class Post {
  final String userImage;
  final String username;
  final File postImage;
  final String caption;

  Post(
      {this.userImage = '',
      this.username = 'sttbbandung',
      required this.postImage,
      this.caption = ''});
}
