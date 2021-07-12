import 'package:flutter/material.dart';
import 'package:linkz_frontend/colors.dart';

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
      home: MobileHome(),
    );
  }
}

class MobileHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AspectRatio(
            aspectRatio: 1.0 / 2.0,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20)),
                height: MediaQuery.of(context).size.height * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  height: 30,
                                  width: 170,
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                )),
          ),
        ),
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [LinkWidget(), LinkWidget()],
      //   ),
      // ),
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

class LinkWidget extends StatefulWidget {
  const LinkWidget({Key? key}) : super(key: key);

  @override
  _LinkWidgetState createState() => _LinkWidgetState();
}

class _LinkWidgetState extends State<LinkWidget> {
  bool isActive = false;
  bool isFavourite = false;
  String titleText = 'Title here.';
  String url = 'Url here.';
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Flexible(
      fit: FlexFit.loose,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.drag_indicator),
              Container(
                margin: const EdgeInsets.only(right: 5),
                height: 100,
                width: 2,
                color: Colors.grey,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: EditableTextField(
                            maxLines: 2,
                            textStyle: textTheme.subtitle1!
                                .copyWith(fontWeight: FontWeight.w600),
                            text: titleText,
                            hint: 'Enter Title Here',
                            onPressed: (value) {
                              setState(() {
                                titleText = value;
                              });
                            },
                            key: Key('Url'),
                          ),
                        ),
                        Switch(
                            activeColor: kRussianViolet,
                            value: isActive,
                            onChanged: (value) {
                              setState(() {
                                isActive = value;
                              });
                            })
                      ],
                    ),
                    EditableTextField(
                      text: url,
                      hint: 'Enter Url Here',
                      maxLines: 1,
                      onPressed: (value) {
                        setState(() {
                          url = value;
                        });
                      },
                      key: Key('Url'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                            },
                            icon: isFavourite
                                ? Icon(Icons.star, color: Colors.yellowAccent)
                                : Icon(Icons.star_border_outlined)),
                        IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                            icon: Icon(Icons.analytics_outlined)),
                        IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                            icon: Icon(Icons.analytics_outlined)),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditableTextField extends StatefulWidget {
  final String text;
  final Function(String) onPressed;
  final String hint;
  final int maxLines;

  final TextStyle? textStyle;
  const EditableTextField(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.hint,
      required this.maxLines,
      this.textStyle})
      : super(key: key);

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  late TextEditingController _controller;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEditing) {
          widget.onPressed(_controller.value.text);
        }
        setState(() {
          isEditing = !isEditing;
        });
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            isEditing
                ? Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: widget.hint),
                      controller: _controller,
                      onSubmitted: (value) {
                        setState(() {
                          isEditing = false;
                        });
                        widget.onPressed(value);
                      },
                      autocorrect: false,
                    ),
                  )
                : Expanded(
                    child: Text(
                      widget.text,
                      maxLines: widget.maxLines,
                      overflow: TextOverflow.ellipsis,
                      style: widget.textStyle,
                    ),
                  ),
            Visibility(
              maintainSize: false,
              visible: isEditing,
              child: IconButton(
                  onPressed: () {
                    widget.onPressed.call(_controller.text);
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  icon: Icon(Icons.check)),
            )
          ]),
    );
  }
}
