import 'package:flutter/material.dart';
import 'package:flutter_news/global.dart';
import 'package:flutter_news/store/index.dart';
import 'package:flutter_news/utils/auth.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(
      children: [
        Text('用户：${Global.profile.displayName}'),
        const Divider(),
        TextButton(
          onPressed: () {
            goLoginPage(context);
          },
          child: const Text('退出登录'),
        ),
        const Divider(),
        TextButton(
          onPressed: () {
            appState.switchGrayFilter();
          },
          child: Text('灰色切换 ${appState.isGrayFilter}'),
        ),
      ],
    );
  }
}
