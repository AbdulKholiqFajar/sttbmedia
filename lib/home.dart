import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/intl.dart';
import 'package:social_media_apps/bloc/Authentication/bloc/login_bloc.dart';
import 'package:social_media_apps/bloc/Post/bloc/post_bloc.dart';
import 'package:social_media_apps/env/env.dart';
import 'story.dart';
import 'post.dart';
import 'old_post.dart';
import 'about.dart';
import 'new_post.dart';

class HomePage extends StatefulWidget {
  final String? caption;
  final String? postImage;
  HomePage({Key? key, this.caption, this.postImage}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Story> _stories = [
    Story("assets/images/splash_screen.png", "Cerita Anda"),
    Story("assets/images/abdul1.jpg", "abdulkholiqfajar"),
    Story("assets/images/azis.jpeg", "azisbanonsanjaya"),
    Story("assets/images/gerry.jpeg", "Gerry Pratama Putra"),
  ];

  late List<Post> posts; // Declare the posts list variable
  late List<PostOld> postsOld; // Declare the posts list variable

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(GetPost());
    // Initialize the posts list within the initState
    posts = [
      Post(
        username: "sttbbandung",
        userImage: "assets/ava/sttb.png",
        postImage: File(widget.postImage ?? ''),
        caption: widget.caption ?? "", // Assign the value of widget.caption or an empty string
      ),
    ];

    postsOld = [
      PostOld(
        username: "sttbbandung",
        userImage: "assets/ava/sttb.png",
        postImage: "assets/post/post1.jpg",
        caption:
            " Selamat Hari Guru Nasional 2023 Sejalan dengan kurikulum merdeka, para guru adalah arsitek pembelajaran yang membawa inovasi dan kreativitas ke dalam setiap ruang kelas. Sebuah dedikasi yang tak terukur, sebuah ilmu yang tak ternilai ",
      ),
      PostOld(
        username: "bem_Sttbbandung",
        userImage: "assets/ava/avabem.jpg",
        postImage: "assets/post/post2.jpg",
        caption: "OPEN RECRUITMENT BADAN EKSEKUTIF MAHASISWA STT BANDUNG",
      ),
      PostOld(
        username: "futsalsttb",
        userImage: "assets/ava/avafutsal.jpg",
        postImage: "assets/post/post3.jpg",
        caption: "OPEN RECRUITMENT UKM FUTSAL STT BANDUNG",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEEEEEE),
        centerTitle: true,
        title: const Text(
          "STTB Social Hub",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPost(),
              ),
            );
          },
          icon: const Icon(
            Icons.loupe,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.info,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<LoginBloc>().add(ProsesLogout());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Cari informasi",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      context.read<PostBloc>().add(SearchPost(search: value));
                    } else {
                      context.read<PostBloc>().add(GetPost());
                    }
                  });
                },
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Stories",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Watch All",
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: _stories.map((story) {
                  return Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                            width: 3,
                            color: const Color(0xFF8e44ad),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(
                            2,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image(
                              image: AssetImage(story.imageUrl),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(story.name),
                    ],
                  );
                }).toList(),
              ),
            ),
            // posts
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoading) {
                  return const SizedBox(height: 80, child: CircularProgressIndicator());
                }
                if (state is PostLoaded == false) {
                  return Container();
                }
                var data = (state as PostLoaded).model;
                if (data!.isEmpty) {
                  return const SizedBox(height: 120, child: Center(child: Text("Data Informasi Kosong")));
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (ctx, i) {
                      var a = data[i];
                      var formattedDate = DateFormat('yMMMMd').format(a.createdAt!);
                      return Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                          '$baseUrl/DataInformasi/${a.image}',
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Center(child: Text("Image ?"));
                                          },
                                          fit: BoxFit.cover,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Text("STTB SOCIAL"),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.settings),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              child: Image.network(
                                '$baseUrl/DataInformasi/${a.image}',
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Text("Image Not Found, something wrong"));
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    IconButton(onPressed: () {}, icon: const Icon(Icons.heart_broken)),
                                    IconButton(onPressed: () {}, icon: const Icon(Icons.add_comment)),
                                    IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                                  ],
                                ),
                                IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              child: RichText(
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Liked By ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "Abdul Kholik Fajar,",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: " Azis Banon Sanjaya ,",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: " Gery Pratama Putra,",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: " And",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: " 9999 Lainnya",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // caption
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: RichText(
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "SOCIAL NAME ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: a.caption,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // post date
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              alignment: Alignment.topLeft,
                              child: Text(
                                formattedDate,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
