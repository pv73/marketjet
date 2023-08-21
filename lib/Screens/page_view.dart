import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  late PageController _controller;
  int _currPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currPage);

    Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currPage < 4) {
        _currPage++;
      } else {
        _currPage = 0;
      }

      _controller.animateToPage(_currPage,
          duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView(
              controller: _controller,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(21)),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(21)),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(21)),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(21)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
