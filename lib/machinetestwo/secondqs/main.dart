import 'package:firebasepro/machinetestwo/secondqs/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("_taskBox");
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}
