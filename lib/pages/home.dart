import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ig_app/pages/user_profile.dart';
import 'package:ig_app/widgets/custom_text.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final TextEditingController controller = TextEditingController();
  Map info = {};
  bool isLoading = false;
  Future<void> getInfo(String id) async {
    setState(() {
      isLoading = true;
    });
    // getInfo method to fetch user info
    final uri =
        'https://instagram-social-api.p.rapidapi.com/v1/info?username_or_id_or_url=$id';
    final url = Uri.parse(uri);
    final response = await http.get(url, headers: {
      'x-rapidapi-key': '5c0bfa62bbmshdaea25c6eaf7ffap1ba07ajsna32bcef359c2',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    final json = jsonDecode(response.body) as Map;
    final result = json["data"] as Map;
    setState(() {
      info = result;
      isLoading = false;
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("succesfully")));
      navigateToUserProfile(info);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("bad")));
    }
    print(info);
  }

// navigate to user profile page with the fetched info
  void navigateToUserProfile(Map info) {
    final route = MaterialPageRoute(
      builder: (context) => UserProfile(info: info),
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Ionicons.logo_instagram,
                size: 100,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CustomText(txt: "Enter UserName :"),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "UserName",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(controller.text.isEmpty || controller.text=="") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter a username"),
                        ),
                      );
                      return;
                    }
                    getInfo(controller.text);
                  },
                  child: Center(
                    child: isLoading? CupertinoActivityIndicator(color: Colors.black,): CustomText(
                      txt: "Enter",
                      color: Colors.black,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
