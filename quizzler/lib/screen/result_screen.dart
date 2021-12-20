import 'package:flutter/cupertino.dart';
import 'package:quizzler/import.dart';

class Result extends StatelessWidget {
  final List<Question> question;
  final Map<int, dynamic> answer;
  Result({required this.question, required this.answer});
  @override
  Widget build(BuildContext context) {
    int correct = 0;

    this.answer.forEach((index, value) {
      if (question[index].correct_answer == value) {
        correct++;
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Color(0xff253445),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: SvgPicture.asset(
                        getEmoji(
                          (correct / question.length * 100).toInt(),
                        ),
                        alignment: Alignment.center,
                        
                        height: 150.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ReUsableListTile(
                      leading: 'Score',
                      trailing: '${(correct / question.length * 100).toStringAsFixed(1)}% / 100%',
                    ),
                    ReUsableListTile(
                      leading: 'Correct Answer',
                      trailing: '$correct / ${question.length}',
                    ),
                    ReUsableListTile(
                      leading: 'Incorrect Answer',
                      trailing:
                          '${question.length - correct} / ${question.length}',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff253445),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                width: double.infinity,
                height: 50.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff253445),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Answer(
                          answer: answer,
                          question: question,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Show Answers',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                width: double.infinity,
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUsableListTile extends StatelessWidget {
  final String leading;
  final String trailing;
  ReUsableListTile({required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        leading: Text(
          leading,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        trailing: Text(
          trailing,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
