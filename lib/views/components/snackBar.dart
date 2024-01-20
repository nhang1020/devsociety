import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

class MySnackBar {
  final BuildContext context;

  MySnackBar({required this.context});

  void showError(String content, bool isDarkMode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    isDarkMode ? Colors.black26 : Colors.red.withOpacity(.03),
              ),
              child: Text(
                content,
                style: TextStyle(color: Colors.red.shade200),
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(bottom: 60, left: 20, right: 20),
      ),
    );
  }

  void showWaiting(String content,
      {Duration duration = const Duration(milliseconds: 800)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: screen(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: myColor,
                    ),
                    child: Text(
                      content,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        duration: Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.black45,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
    );
  }
}
