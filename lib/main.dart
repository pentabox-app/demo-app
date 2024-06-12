import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/view_model/mian_view_model.dart';

import 'view/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
