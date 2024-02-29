import 'package:devsociety/controllers/AuthController.dart';
import 'package:devsociety/provider/ThemeProvider.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/components/textField.dart';
import 'package:devsociety/views/screens/auth/signup_screen.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  late InAppWebViewController inApp;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: screen(context).height - 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: 80,
                      height: 50,
                      child: LangDropDown(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {
                          themeProvider.themeMode == ThemeMode.dark
                              ? themeProvider.toggleTheme(false, 0, context)
                              : themeProvider.toggleTheme(true, 0, context);
                        },
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? UniconsLine.moonset
                              : UniconsLine.brightness_low,
                          size: 30,
                          color: myColor,
                        ),
                      ),
                    ),
                  ],
                ),
                isSmallScreen(context)
                    ? Column(
                        children: [
                          Logo(),
                          formContent(themeProvider),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Logo(),
                          SizedBox(width: 40),
                          formContent(themeProvider),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${lang(context).idonthaveaccount}?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ));
                        },
                        child: Text(
                          lang(context).signup,
                          style: TextStyle(color: myColor),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formContent(ThemeProvider themeProvider) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text.rich(
              TextSpan(
                text: "Sign",
                style: GoogleFonts.aDLaMDisplay(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                children: [
                  TextSpan(text: " In", style: TextStyle(color: myColor)),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: MyTextField(
              controller: _userName,
              hintText:
                  "Email ${lang(context).or} ${lang(context).username.toLowerCase()}",
              labelText: lang(context).username,
              isEmail: true,
              prefixIcon: Icon(UniconsLine.user),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: MyTextField(
              controller: _password,
              hintText:
                  "${lang(context).enter} ${lang(context).password.toLowerCase()}",
              labelText: lang(context).password,
              isPassword: true,
              prefixIcon: Icon(UniconsLine.key_skeleton),
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(height: 30),
          MyButton(
            width: 150,
            icon: _loading
                ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: 24,
                    duration: Duration(milliseconds: 700),
                  )
                : Text(
                    lang(context).login,
                    style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17),
                  ),
            isGradient: !_loading,
            duration: Duration(milliseconds: 300),
            textColor: Colors.white,
            color: _loading ? myColor.withOpacity(.1) : null,
            boxShadows: [
              BoxShadow(
                color:
                    themeProvider.isDarkMode ? Colors.black26 : Colors.black12,
                blurRadius: 15,
                offset: Offset(3, 15),
              )
            ],
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                setState(() {
                  _loading = true;
                });
                AuthController(context: context)
                    .login(_userName.text, _password.text)
                    .then((value) {
                  setState(() {
                    _loading = false;
                  });
                });
              }
            },
          ),
          SizedBox(height: 30),
          Text(
            lang(context).other,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 55,
                height: 55,
                radius: 50,
                onPressed: () async {
                  await AuthController(context: context).googleLogin();
                },
                icon: Icon(
                  UniconsLine.google,
                  size: 35,
                  color: myColor,
                ),
                boxShadows: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 15,
                    offset: Offset(3, 10),
                  )
                ],
              ),
              // SizedBox(width: 20),
              // MyButton(
              //   color: Theme.of(context).scaffoldBackgroundColor,
              //   width: 55,
              //   height: 55,
              //   radius: 50,
              //   onPressed: () {},
              //   icon: Icon(
              //     UniconsLine.facebook_f,
              //     size: 35,
              //     color: myColor,
              //   ),
              //   boxShadows: [
              //     BoxShadow(
              //       color: Theme.of(context).shadowColor,
              //       blurRadius: 15,
              //       offset: Offset(3, 10),
              //     )
              //   ],
              // ),
              SizedBox(width: 20),
              MyButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 55,
                height: 55,
                radius: 50,
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        body: InAppWebView(
                          initialUrlRequest: URLRequest(
                              url: WebUri("https://github.com/login")),
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            inApp = controller;
                          },
                          onLoadResource: (controller, resource) {
                            if (resource.url
                                .toString()
                                .startsWith('https://github.com/login')) {
                              // Xử lý response ở đây
                              print(
                                  'Received response from the web: ${resource}');
                            }
                          },
                          onLoadStart:
                              (InAppWebViewController controller, url) {},
                          onLoadStop:
                              (InAppWebViewController controller, url) {},
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  UniconsLine.github,
                  size: 40,
                  color: myColor,
                ),
                boxShadows: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 15,
                    offset: Offset(3, 10),
                  )
                ],
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                AuthController(context: context).googleLogout();
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
