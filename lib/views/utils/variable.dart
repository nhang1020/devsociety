import 'package:devsociety/provider/LocaleProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

Color myColor = Color(0xff6666ff);
AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;
Size screen(BuildContext context) {
  return MediaQuery.of(context).size;
}

bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).copyWith().size.width < 760;
}

class LangDropDown extends StatelessWidget {
  const LangDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final _langProvider = Provider.of<LocaleProvider>(context, listen: false);
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      borderRadius: BorderRadius.circular(10),
      padding: EdgeInsets.zero,
      icon: Icon(UniconsLine.angle_down, color: myColor),
      isDense: true,
      value: _langProvider.locale,
      items: [
        DropdownMenuItem(
          child: Image.asset("assets/icons/unitedkingdom.png", width: 50),
          value: "en",
        ),
        DropdownMenuItem(
          child: Image.asset("assets/icons/vietnam.png", width: 50),
          value: "vi",
        ),
      ],
      onChanged: (value) {
        // Provider.of<LocaleProvider>(context, listen: false)
        //     .toggleLocale(value!);
      },
    );
  }
}

class ToggleLanguage extends StatefulWidget {
  const ToggleLanguage({super.key});

  @override
  State<ToggleLanguage> createState() => _ToggleLanguageState();
}

class _ToggleLanguageState extends State<ToggleLanguage> {
  List<bool> _isSelecteds = [true, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset("assets/icons/unitedkingdom.png", width: 50),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset("assets/icons/vietnam.png", width: 50),
        ),
      ],
      selectedColor: myColor,
      fillColor: myColor,
      isSelected: _isSelecteds,
      borderRadius: BorderRadius.circular(15),
      onPressed: (newIndex) {
        setState(() {
          for (int index = 0; index < _isSelecteds.length; index++) {
            if (index == newIndex) {
              _isSelecteds[index] = true;
            } else {
              _isSelecteds[index] = false;
            }
          }
        });
      },
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/devlogo.png",
          width: isSmallScreen(context) ? 100 : 200,
          color: myColor,
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Text(
              "dev",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: isSmallScreen(context) ? 20 : 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 12,
                ),
              ),
            ),
            Text(
              "SOCIETY",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: isSmallScreen(context) ? 10 : 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}