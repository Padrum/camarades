import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final Future<Object> backgroundFunction;
  final Widget nextPage;
  const LoadingPage({Key key, this.backgroundFunction, this.nextPage})
      : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Widget _toShow;
  Widget get _nextpage => this.widget.nextPage;
  Widget get _loadingPage => Opacity(
        opacity: 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

  // double _opacity = 0;

  @override
  void initState() {
    _toShow = _loadingPage;
    widget.backgroundFunction.then(
      (nul) {
        setState(() {
          _toShow = _nextpage;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _toShow;
  }
}
