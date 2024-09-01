import 'package:flutter/material.dart';
import 'package:github_demo/Providers/user_provider.dart';
import 'package:github_demo/presentation/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ));
