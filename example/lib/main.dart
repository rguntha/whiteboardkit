import 'package:flutter/material.dart';
import 'package:whiteboardkit/toolbox_options.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DrawingController controller;
  DrawingController renderController;
  DrawingController pasteController;

  @override
  void initState() {
    controller = DrawingController(toolbox: true, readonly: false);
    renderController = DrawingController(toolbox: false, readonly: true);
    pasteController = DrawingController(toolbox: false, readonly: true);
    controller.onChange().listen((draw){
      renderController.streamController.add(draw);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Whiteboard(
              title: "Main Whiteboard",
              style: WhiteboardStyle(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: controller,
            ),
          ),
          Expanded(
            child: Whiteboard(
              title: "Mirror Whiteboard",
              style: WhiteboardStyle(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: renderController,
            ),
          ),
          Row(
            children: [
              TextButton(onPressed: (){
                pasteController.streamController.add(WhiteboardDraw.fromJson(controller.draw.toJson()));
              }, child: Text('Paste')),
              TextButton(onPressed: (){
                pasteController.wipe();
              }, child: Text('Clear')),
            ],
          ),
          Expanded(
            child: Whiteboard(
              title: "Paste Whiteboard",
              style: WhiteboardStyle(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: pasteController,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
