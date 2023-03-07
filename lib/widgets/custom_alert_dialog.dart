import 'package:e_kart/screens/in_app_web_broweser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.btnName,
    required this.keyToRoute,
    required this.data,
  }) : super(key: key);

  final String title, description, btnName, keyToRoute,data;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                widget.description,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Divider(
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              highlightColor: Colors.grey[200],
              onTap: () {
                _routeToDest(widget.keyToRoute, widget.data);
              },
              child: Center(
                child: Text(
                  widget.btnName,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _routeToDest(keyToRoute, data) async {
    if(keyToRoute == "WA") {
      launchUrl(Uri.parse('https://wa.me/919791994490?text=$data'),
          mode: LaunchMode.externalApplication);

      // if (!await launchUrl(
      //     Uri.parse('https://wa.me/919791994490?text=$data '),
      //   mode: LaunchMode.externalApplication,
      // )) {
      //   throw Exception('Could not launch url : \nhttps://wa.me/919791994490?text=$data');
      // }
    }else if(keyToRoute == "INAPPWEB") {
        Get.to(()=> InAppWebBrowser(data));
    }
  }
}
