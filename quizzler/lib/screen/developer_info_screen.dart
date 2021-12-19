import 'package:quizzler/import.dart';

class DeveloperInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Developer Info'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.0),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              CircleAvatar(
                radius: 70.0,
                backgroundColor: Theme.of(context).primaryColor,
                backgroundImage: AssetImage('assets/img/Divit-Vaghani-min.jpg'),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Divit Vaghani',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6C7C8D),
                  fontSize: 23.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(
                    title: 'Github',
                    onPressed: () async {
                      String url = 'https://github.com/Divit-vaghani';
                      if (!await launch(url)) throw 'Err';
                    },
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  CustomOutlinedButton(
                    title: 'Contact',
                    onPressed: () async {
                      String url = 'mailto:divitvaghani@gmail.com';
                      if (!await launch(url)) throw 'Err';
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  CustomOutlinedButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Color(0xff6C7C8D),
          side: BorderSide(
            width: 1.0,
            color: Color(0xff6C7C8D),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xff6C7C8D),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
