// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   Map<String, dynamic>? _userData;
//   bool _checking = true;
//   AccessToken? _accessToken;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _checkfisLogin();
//   }

//   void _checkfisLogin() async {
//     final accessToken = await FacebookAuth.instance.accessToken;
//     setState(() {
//       _checking = false;
//     });
//     if (accessToken != null) {
//       print("${accessToken.toJson()}");
//       final userData = await FacebookAuth.instance.getUserData();
//       _accessToken = accessToken;
//       setState(() {
//         _userData = userData;
//       });
//     } else {
//       _login();
//     }
//   }

//   _login() async {
//     final LoginResult result = await FacebookAuth.instance.login();
//     if (result.status == LoginStatus.success) {
//       _accessToken = result.accessToken;
//       final userData = await FacebookAuth.instance.getUserData();
//       _userData = userData;
//     } else {
//       print(result.status);
//       print(result.message);
//     }
//   }

//   _logout() async {
//     await FacebookAuth.instance.logOut();
//     _accessToken = null;
//     _userData = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             _userData != null
//                 ? Text('Name: ${_userData!['name']}')
//                 : SizedBox(),
//             CupertinoButton(
//               child: Text(_userData != null ? "Log out" : "Log in"),
//               onPressed: () {
//                 _userData != null ? _logout() : _login();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
