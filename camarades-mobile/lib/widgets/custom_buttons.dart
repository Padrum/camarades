import 'package:flutter/material.dart';

class CustomBlueButton extends RaisedButton {
  const CustomBlueButton({@required this.onPressed, this.child})
      : super(onPressed: onPressed, child: child);
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 40,
      child: RaisedButton(
        color: Colors.lightBlue,
        textColor: Colors.white,
        onPressed: this.onPressed,
        child: this.child,
      ),
    );
  }
}

class CustomWhiteButton extends RaisedButton {
  const CustomWhiteButton({@required this.onPressed, this.child})
      : super(onPressed: onPressed, child: child);
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 40,
      child: RaisedButton(
        color: Colors.white,
        textColor: Colors.lightBlue,
        onPressed: this.onPressed,
        child: this.child,
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 90.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
