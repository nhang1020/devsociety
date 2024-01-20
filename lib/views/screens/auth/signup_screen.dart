import 'package:devsociety/controllers/AuthController.dart';
import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/ThemeProvider.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/components/textField.dart';
import 'package:devsociety/views/screens/auth/login_screen.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: screen(context).height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
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
                        "${lang(context).ihavealreadyaccount}?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        child: Text(
                          lang(context).signin,
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

  String? error;
  Widget formContent(ThemeProvider themeProvider) {
    return Form(
      key: _formKey2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 30),
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
                  TextSpan(text: " Up", style: TextStyle(color: myColor)),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 300,
            child: MyTextField(
              controller: _firstName,
              hintText: "${lang(context).enter} ${lang(context).firstname}",
              labelText: lang(context).firstname,
              maxLenght: 30,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: MyTextField(
              controller: _lastName,
              hintText: "${lang(context).enter} ${lang(context).lastname}",
              labelText: lang(context).lastname,
              maxLenght: 30,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: MyTextField(
              controller: _userName,
              hintText: "${lang(context).enter} email",
              labelText: "Email",
              prefixIcon: Icon(UniconsLine.user),
              isEmail: true,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: MyTextField(
              controller: _password,
              hintText: "${lang(context).enter} ${lang(context).password}",
              labelText: lang(context).password,
              isPassword: true,
              prefixIcon: Icon(UniconsLine.key_skeleton),
              onChanged: (value) {
                setState(() {
                  error = value != _confirmPassword.text
                      ? lang(context).confirmationpasswordincorrect
                      : null;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: MyTextField(
              controller: _confirmPassword,
              hintText: "${lang(context).confirm} ${lang(context).password}",
              labelText:
                  "${lang(context).confirm} ${lang(context).password.toLowerCase()}",
              isPassword: true,
              prefixIcon: Icon(UniconsLine.key_skeleton),
              onChanged: (value) {
                setState(() {
                  error = value != _password.text
                      ? lang(context).confirmationpasswordincorrect
                      : null;
                });
              },
              error: error,
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
                    lang(context).signup,
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
              if (_formKey2.currentState?.validate() ?? false) {
                setState(() {
                  _loading = true;
                });
                AuthController(context: context)
                    .signup(User(
                        firstname: _firstName.text,
                        lastname: _lastName.text,
                        email: _userName.text,
                        password: _password.text))
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
                onPressed: () {},
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
              SizedBox(width: 20),
              MyButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 55,
                height: 55,
                radius: 50,
                onPressed: () {},
                icon: Icon(
                  UniconsLine.facebook_f,
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
              SizedBox(width: 20),
              MyButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 55,
                height: 55,
                radius: 50,
                padding: EdgeInsets.zero,
                onPressed: () {},
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
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
