import 'package:flutter/material.dart';
import 'package:flutter_nevis_cli/src/component/app_bar_Component/AppBarComponent.dart';
import 'package:flutter_nevis_cli/src/core/routes/AppRouter.dart';
import 'package:flutter_nevis_cli/src/features/features_main/presentation/widget/ListCommandsWidget.dart';
import 'package:flutter_nevis_cli/src/features/features_main/presentation/widget/TerminalWidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarComponent(
          title: Text("فلاتر نویس",style: TextStyle(fontFamily: "VazirMatnBlack"),),
          actions: [
            TextButton(
              onPressed: () {
                AppRouter.pushNamed(context, AppRouter.settingPage);
              },
              child: Text("تنطیمات",style: TextStyle(fontFamily: "VazirMatnRegular"),),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5, // میتونی نسبت دلخواه بدی
              child: ListCommandsWidget(),
            ),
            Expanded(
              flex: 3,
              child: TerminalWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
