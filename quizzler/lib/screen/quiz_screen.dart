import 'package:flutter/cupertino.dart';
import 'package:quizzler/import.dart';

class Quiz extends StatefulWidget {
  final List<Question> question;
  final Category category;
  Quiz({
    required this.category,
    required this.question,
  });

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};

  @override
  Widget build(BuildContext context) {
    Question question = widget.question[_currentIndex];

    final List<dynamic> options = question.incorrect_answer;

    if (!options.contains(question.correct_answer)) {
      options.add(question.correct_answer);
      options.shuffle();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.category.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        '${_currentIndex + 1}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color : Color(0xff6C7C8D),
                        ),
                      ),
                      alignment: Alignment.center,
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Text(
                        HtmlUnescape().convert(
                          widget.question[_currentIndex].question,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...options.map((e) => RadioListTile(
                            activeColor: Color(0xff6C7C8D),
                            title: Text(
                              HtmlUnescape().convert(e),
                              style: TextStyle(
                                color: Color(0xff6C7C8D),
                              ),
                            ),
                            groupValue: _answers[_currentIndex],
                            value: e.toString(),
                            onChanged: (value) {
                              setState(() {
                                _answers[_currentIndex] = value;
                              });
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff253445),
                    ),
                    onPressed: () async {
                      _submit();
                    },
                    child: Text(
                      _currentIndex == (widget.question.length - 1)
                          ? 'Submit'
                          : 'Next',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  width: double.infinity,
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_answers[_currentIndex] == null) {
      Fluttertoast.showToast(
        backgroundColor: Theme.of(context).primaryColor,
        msg: 'Please select the answer',
        gravity: ToastGravity.BOTTOM,
      );
    } else if (_currentIndex < (widget.question.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => Result(
              answer: _answers,
              question: widget.question,
            ),
          ));
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            'All your current progress will be lost',
          ),
          actions: [
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
