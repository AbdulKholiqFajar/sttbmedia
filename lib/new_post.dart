import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:social_media_apps/bloc/Post/bloc/post_bloc.dart';
import 'home.dart';
import 'post.dart';
import 'dart:async';
import 'dart:io';

// class NewPost extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _NewPost();
//   }
// }

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController caption = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imageFile;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  void submit() {
    String createdAt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (_formKey.currentState!.validate()) {
      context.read<PostBloc>().add(AddPost(caption: caption.text, image: _imageFile!, createdAt: createdAt));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post Feed Social Hub",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: WillPopScope(
        onWillPop: ()async {
          context.read<PostBloc>().add(GetPost());
          return true;
        },
        child: BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is AddPostLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 80,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                },
              );
            }
            if (state is AddPostSuccess) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 80,
                      child: Center(child: Text(state.messageSuccess!)),
                    ),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
                  );
                },
              );
            }
            if (state is AddPostFailed) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 80,
                      child: Center(child: Text(state.messageError!)),
                    ),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
                  );
                },
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    InkWell(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.6), width: 2), borderRadius: BorderRadius.circular(6.0)),
                        alignment: Alignment.center,
                        child: _imageFile == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.image_outlined, color: Colors.grey.withOpacity(0.7), size: 100), Text("Pilih Foto Anda")],
                              )
                            : Image.file(
                                _imageFile!,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: caption,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: "Enter your caption",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your caption';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                        child: Text('ADD POST'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
