import 'package:flutter/material.dart';

/// Home screen, displays [Note] grid or list.
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

/// [State] of [HomeScreen].
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Container(
        child: Text("Signed in successfully!"),
      );
}
