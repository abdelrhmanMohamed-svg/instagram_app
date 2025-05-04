import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ig_app/pages/videoPage.dart';
import 'package:ig_app/widgets/button_card.dart';
import 'package:ig_app/widgets/category_info.dart';
import 'package:ig_app/widgets/custom_text.dart';
import 'package:ig_app/widgets/user_info.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.info});
  final Map info;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List img = [
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300"
  ];
  List followers = [];
  List posts = [];
  List reels = [];
// get followers numbers from the info map
  Future<void> getFollowersNumber() async {
    final username = widget.info["username"];
    final uri =
        "https://instagram-social-api.p.rapidapi.com/v1/followers?username_or_id_or_url=$username";
    final url = Uri.parse(uri);
    final response = await http.get(url, headers: {
      'x-rapidapi-key': '5c0bfa62bbmshdaea25c6eaf7ffap1ba07ajsna32bcef359c2',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    final json = jsonDecode(response.body) as Map;
    final result = json["data"]["items"] as List;
    setState(() {
      followers = result;
    });
  }

//get posts
  Future<void> getPosts() async {
    // get posts
    final username = widget.info["username"];
    final uri =
        "https://instagram-social-api.p.rapidapi.com/v1/posts?username_or_id_or_url=$username";
    final url = Uri.parse(uri);
    final response = await http.get(url, headers: {
      'x-rapidapi-key': '5c0bfa62bbmshdaea25c6eaf7ffap1ba07ajsna32bcef359c2',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    final json = jsonDecode(response.body) as Map;
    final result = json["data"]["items"] as List;
    setState(() {
      posts = result;
    });
  }

  Future<void> getReels() async {
    // get reels
    final username = widget.info["username"];
    final uri =
        "https://instagram-social-api.p.rapidapi.com/v1/reels?username_or_id_or_url=$username";
    final url = Uri.parse(uri);
    final response = await http.get(url, headers: {
      'x-rapidapi-key': '5c0bfa62bbmshdaea25c6eaf7ffap1ba07ajsna32bcef359c2',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    final json = jsonDecode(response.body) as Map;
    final result = json["data"]["items"] as List;
    setState(() {
      reels = result;
    });
  }

  @override
  void initState() {
    getFollowersNumber();
    getPosts();
    getReels();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.info;
    final category = info["category"];

    final username = info["username"];
    final profileImg = info["profile_pic_url_hd"];
    return Scaffold(
      appBar: AppBar(
        title: CustomText(txt: username),
        leadingWidth: 24,
        centerTitle: false,
        actions: [
          SizedBox(
            width: 20,
          ),
          Icon(Icons.notifications_none),
          SizedBox(width: 20),
          Icon(Icons.more_horiz),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          // User Info
          Column(
            children: [
              SizedBox(height: 20),
              UserInfo(
                userImg: profileImg,
                followerNumber: followers.length.toString(),
              ),  
              CategoryInfo(
                category: category,
                img: [
                  followers[0]["profile_pic_url"] ??
                      "https://picsum.photos/200/300 ",
                  followers[1]["profile_pic_url"] ??
                      "https://picsum.photos/200/300 ",
                  followers[4]["profile_pic_url"] ??
                      "https://picsum.photos/200/300 ",
                ],
              ),
              SizedBox(height: 20),
              ButtonCard(),
            ],
          ),
          SizedBox(height: 20),
          // tab bar
          TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              dragStartBehavior: DragStartBehavior.down,
              controller: _tabController,
              tabs: [
                Icon(Icons.grid_on),
                Icon(Icons.video_library_outlined),
                Icon(Icons.person_add_alt),
              ]),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                //posts
                GridView.builder(  // posts
                  
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.9 / 1.1,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(posts[index]["thumbnail_url"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                GridView.builder( //reels
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.9 / 1.6,
                    ),
                    itemCount: reels.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Videopage(videoUrl: reels[index]['video_url'], profilePic: profileImg, Username:username,caption: reels[index]['~'],),)),
                      child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(reels[index]['thumbnail_url']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    )),
                Icon(Icons.person_add_alt),
             
              ],
            ),
          ),
        ],
      ),
    );
  }
}
