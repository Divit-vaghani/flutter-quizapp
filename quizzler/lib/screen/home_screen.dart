import 'package:flutter/cupertino.dart';
import 'package:quizzler/import.dart';
import 'package:quizzler/screen/developer_info_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterTts _flutterTts = FlutterTts();

  bool isSpeakOn = LocalData.getAssist ?? false;

  Widget _buildList(int index) {
    Category category = categories[index];
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      onPressed: () async {
        isSpeakOn ? await _flutterTts.speak(category.name) : null;
        showDialog(
          barrierColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              category.name,
              textAlign: TextAlign.center,
            ),
            content: Options(
              category: category,
              isSpeakOn: isSpeakOn,
            ),
          ),
        );
      },
      elevation: 2.0,
      highlightElevation: 1.0,
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(
          category.name,
          style: TextStyle(
            color: Color(0xff6C7C8D),
          ),
        ),
        leading: Icon(
          category.icon,
          color: Color(0xff6C7C8D),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    print('Home Dispose was called');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          actions: [
            IconButton(
              tooltip: 'Assist Mode',
              splashRadius: 20.0,
              icon: Icon(
                isSpeakOn ? Icons.record_voice_over : Icons.voice_over_off,
              ),
              onPressed: () async {
                String engine = await _flutterTts.getDefaultEngine;

                if (engine.isNotEmpty) {
                  setState(() {
                    isSpeakOn = !isSpeakOn;
                    LocalData.setAssist(isSpeakOn);
                  });
                }
              },
            ),
            IconButton(
              tooltip: 'Developer Info',
              splashRadius: 20.0,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DeveloperInfo(),
                  ),
                );
              },
              icon: Icon(
                Icons.info_outlined,
              ),
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Quizzler',
          ),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) => _buildList(index),
        ),
      ),
    );
  }
}
