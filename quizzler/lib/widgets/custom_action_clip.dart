import 'package:quizzler/import.dart';

class CustomActionChip extends StatelessWidget {
  final String name;
  final Color backGroundColor;
  final void Function() onPressed;
  CustomActionChip(
      {this.backGroundColor = Colors.blueGrey,
      required this.name,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      backgroundColor: backGroundColor,
      onPressed: onPressed,
    );
  }
}
