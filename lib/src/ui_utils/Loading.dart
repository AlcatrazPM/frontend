import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final Widget child;
  final Widget loading;
  final LoadingController controller;

  Loading({this.child, this.loading, this.controller});

  @override
  _LoadingState createState() => _LoadingState();
}

class LoadingController {
  Function _notify = (){};
  bool _isLoading;

  get isLoading => _isLoading;

  LoadingController({bool isLoading = false}) {
    this._isLoading = isLoading;
  }

  void setLoading() {
    _isLoading = true;
    _notify();
  }

  void setDone() {
    _isLoading = false;
    _notify();
  }
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller._notify = () {
        setState(() {});
      };
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller != null && widget.controller.isLoading) {
      if (widget.loading == null) return CircularProgressIndicator();
      return widget.loading;
    }
    return widget.child;
  }

  @override
  void dispose() {
    widget.controller._notify = (){};
    super.dispose();
  }
}
