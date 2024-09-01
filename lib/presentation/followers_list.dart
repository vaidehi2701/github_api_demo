import 'package:flutter/material.dart';
import 'package:github_demo/Models/user_model.dart';
import 'package:github_demo/Requests/api_repo.dart';
import 'dart:convert';

// ignore: must_be_immutable
class FollowersList extends StatefulWidget {
  UserModel user;

  FollowersList({super.key, required this.user});

  @override
  State<FollowersList> createState() => _FollowersListState();
}

class _FollowersListState extends State<FollowersList> {
  List<UserModel>? users;

  @override
  void initState() {
    super.initState();

    ApiRepo(widget.user.login).fetchFollowers().then((following) {
      Iterable list = json.decode(following.body);
      setState(() {
        users = list.map((model) => UserModel.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(widget.user.avatarUrl),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.user.login,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 600,
                  child: users != null
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: users!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              users![index].avatarUrl),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        users![index].login.length > 20
                                            ? users![index]
                                                .login
                                                .substring(0, 15)
                                            : users![index].login,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'Followers',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : const Align(child: Text('Data is loading ...')),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
