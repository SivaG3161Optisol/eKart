import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../res/colours.dart';

class UnorderedList extends StatelessWidget {
  UnorderedList(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    var first10 = texts.take(8);
    for (var text in first10) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("⚈ "),
        Expanded(
          child: Text(
              text.trim(),
            style: TextStyle(color: Colours.bodyColor, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

List<String> myFuc(String descName) {

  var splittedData = descName.toString().trim().split('.').where((s) => !s.isEmpty).toList();

  return splittedData;

}
