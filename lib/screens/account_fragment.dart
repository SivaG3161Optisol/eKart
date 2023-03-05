import 'package:flutter/cupertino.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

    );
  }
}
