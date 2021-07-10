import 'package:flutter/material.dart';
import 'package:linkz_frontend/colors.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: customLightTheme,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        //defaultScale: true,
        // maxWidth: 1200,
        minWidth: 480,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Text('data'),
                    Text('data'),
                    Text('data'),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: ListView(
                children: [
                  Container(
                    child: Text('Header'),
                    height: 40,
                  ),
                  LinkWidget(),
                  LinkWidget(),
                  LinkWidget(),
                ],
              )),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 700,
                    width: 300,
                    color: Colors.black,
                  ),
                  TextButton(onPressed: () {}, child: Text('Mobile View'))
                ],
              ))
        ],
      ),
    );
  }
}

class LinkWidget extends StatelessWidget {
  const LinkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('Title'), TextField()],
        ),
      ),
    );
  }
}
