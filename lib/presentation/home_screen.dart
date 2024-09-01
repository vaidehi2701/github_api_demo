import 'package:flutter/material.dart';
import 'package:github_demo/Models/user_model.dart';
import 'package:github_demo/presentation/followers_list.dart';
import 'package:github_demo/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset("assets/github.png"),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Github",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 150,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.1)),
                  child: TextField(
                    onChanged: (value) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setMessage(null);
                    },
                    controller: _controller,
                    enabled: !Provider.of<UserProvider>(context, listen: false)
                        .isLoading(),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        errorText:
                            Provider.of<UserProvider>(context, listen: false)
                                .getMessage(),
                        border: InputBorder.none,
                        hintText: "Github username",
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Provider.of<UserProvider>(context, listen: false)
                            .isLoading()
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            'Find My Followers',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  onPressed: () {
                    if (_controller.text == '') {
                      Provider.of<UserProvider>(context, listen: false)
                          .setMessage('Please Enter your username');
                    } else {
                      Provider.of<UserProvider>(context, listen: false)
                          .fetchUser(_controller.text)
                          .then((value) {
                        if (value == true) {
                          UserModel userData =
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUSer();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowersList(
                                        user: userData,
                                      )));
                        }
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
