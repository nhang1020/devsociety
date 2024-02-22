import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Loading(),
    );
  }
}

showLoadingDialog(BuildContext context, {bool turn = false, Widget? childTo}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        if (childTo != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => childTo));
        }
        return turn;
      },
      child: LoadingWidget(),
    ),
  );
}
