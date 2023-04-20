import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
    final RadioGroupController groupcon = RadioGroupController();
    List<String> li = ['yes','no'];
    @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(),
      body: Center(
        child: Container(
          width: 500,
          alignment: Alignment.center,
          child: Center(
            child: RadioGroup(
              indexOfDefault: 0,
              values: li,
            controller: groupcon,
            
            ),
          )
        ),
      ),
    );
  }
}