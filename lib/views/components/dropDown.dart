import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class MyDropdown extends StatelessWidget {
  String? selectted;
  MyDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectted,
  });

  List<DropdownMenuItem<dynamic>> items;
  Function(dynamic value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(right: 20),
        width: screen(context).width,
        // / (screen(context).width < 768 ? 1 : 2),
        child: DropdownButtonFormField(
            menuMaxHeight: 300,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(Icons.circle, color: myColor, size: 10),
            ),
            isExpanded: true,
            padding: EdgeInsets.zero,
            icon: Icon(UniconsLine.angle_down, color: myColor),
            iconSize: 30,
            borderRadius: BorderRadius.circular(10),
            value: items.isEmpty
                ? null
                : selectted != null
                    ? selectted
                    : items.first.value!,

            // dropdownColor: themeModeColor,
            isDense: true,
            onChanged: (value) {
              onChanged(value!);
            },
            items: items),
      ),
    );
  }
}
