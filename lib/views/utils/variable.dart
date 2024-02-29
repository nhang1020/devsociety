import 'package:devsociety/provider/LocaleProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:diacritic/diacritic.dart';

Color myColor = Color(0xff6666ff);
AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;
final List<String> topics = [
  "IMAGE",
  "TEXT",
  "VIDEO",
  "QNA",
];

//func
Size screen(BuildContext context) {
  return MediaQuery.of(context).size;
}

formatTime(DateTime time) {
  String formattedTime = DateFormat('hh:mm').format(time);
  return formattedTime;
}

bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).copyWith().size.width < 760;
}

String displayTime(BuildContext context, DateTime time) {
  bool isEn = Provider.of<LocaleProvider>(context).isEn;
  var diff = time.difference(DateTime.now());
  if (diff.inHours.abs() < 24) {
    if (diff.abs().inHours < 1) {
      return "${diff.inMinutes.abs()} ${isEn && diff.abs().inMinutes > 1 ? lang(context).minute + 's' : lang(context).minute}";
    }
    return "${diff.abs().inHours} ${isEn && diff.abs().inHours > 1 ? lang(context).hour + 's' : lang(context).hour}";
  } else if (diff.abs().inDays < 7) {
    return "${diff.abs().inDays} ${isEn && diff.abs().inHours > 1 ? lang(context).day + 's' : lang(context).day} ${lang(context).ago}";
  }

  return isEn
      ? DateFormat('MMM dd').format(time)
      : "${time.day} tháng ${time.month}";
}

String convertThousandNumber(number) {
  try {
    return NumberFormat.decimalPattern().format(number);
  } catch (e) {
    print(e);
    return "0";
  }
}

String roundedQuanlity(BuildContext context, number) {
  try {
    double num = double.parse(number.toString());
    switch (num) {
      case >= 1000 && < 1000000:
        return "${(num / 1000).toStringAsFixed(1)} ${lang(context).kilo}";
      case >= 1000000 && < 1000000000:
        return "${(num / 1000000).toStringAsFixed(1)} ${lang(context).milion}";
      case >= 1000000000:
        return "${(num / 1000000000).toStringAsFixed(1)} ${lang(context).bilion}";
      default:
        return "${num.toStringAsFixed(0)}";
    }
  } catch (e) {
    print(e);
    return "0";
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: color ?? myColor.withOpacity(.7),
        size: 30,
      ),
    );
  }
}

String formatString(String text) => removeDiacritics(text).toLowerCase();
List stringToList(String string) {
  try {
    return string.split(', ');
  } catch (e) {
    return [];
  }
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
