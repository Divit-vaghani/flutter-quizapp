import 'package:flutter/cupertino.dart';
import 'package:quizzler/import.dart';

class Options extends StatefulWidget {
  final Category category;
  final bool isSpeakOn;

  Options({required this.category, required this.isSpeakOn});
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  late int _noOfQuestion;
  late String _difficulty;
  late bool processing;
  FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    _noOfQuestion = 10;
    _difficulty = 'Easy';
    processing = false;
    super.initState();
  }

  _selectedQuestion(int question) async {
    widget.isSpeakOn ? await _flutterTts.speak(question.toString()) : null;
    setState(() {
      _noOfQuestion = question;
    });
  }

  _selectedDifficulty(String difficulty) async {
    widget.isSpeakOn ? await _flutterTts.speak(difficulty) : null;
    setState(() {
      _difficulty = difficulty;
    });
  }

  _startQuiz() async {
    print('tap on start quiz');
    if (this.mounted) {
      setState(() {
        processing = true;
      });
    }

    try {
      List<Question> question =
          await getQuestions(widget.category, _noOfQuestion, _difficulty);
      if (question.length < 1) {
        Fluttertoast.showToast(
          backgroundColor: Theme.of(context).primaryColor,
          msg: 'No Question Available',
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.pop(context);
      } else {
        Navigator.pop(context);

        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Quiz(
              category: widget.category,
              question: question,
            ),
          ),
        );
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        backgroundColor: Theme.of(context).primaryColor,
        msg: 'Can\'t reach Server',
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
    } catch (err) {
      if (this.mounted) {
        Fluttertoast.showToast(
          backgroundColor: Theme.of(context).primaryColor,
          msg: 'Unexpected Err',
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    print('Options Dispose was called');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Select Total No of Question'),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            children: [
              CustomActionChip(
                name: '10',
                backGroundColor: _noOfQuestion == 10
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                onPressed: () => _selectedQuestion(10),
              ),
              CustomActionChip(
                name: '20',
                onPressed: () => _selectedQuestion(20),
                backGroundColor: _noOfQuestion == 20
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              CustomActionChip(
                name: '30',
                onPressed: () => _selectedQuestion(30),
                backGroundColor: _noOfQuestion == 30
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              CustomActionChip(
                name: '40',
                onPressed: () => _selectedQuestion(40),
                backGroundColor: _noOfQuestion == 40
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text('Select Difficulty'),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            children: [
              CustomActionChip(
                name: 'Easy',
                onPressed: () => _selectedDifficulty('Easy'),
                backGroundColor: _difficulty == 'Easy'
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              CustomActionChip(
                name: 'Medium',
                onPressed: () => _selectedDifficulty('Medium'),
                backGroundColor: _difficulty == 'Medium'
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              CustomActionChip(
                name: 'Hard',
                onPressed: () => _selectedDifficulty('Hard'),
                backGroundColor: _difficulty == 'Hard'
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          processing
              ? CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )
              : Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text(
                      'Start Quiz',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      _startQuiz();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
