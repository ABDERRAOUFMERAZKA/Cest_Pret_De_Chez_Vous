import 'package:flutter/material.dart';

class ShowDialogPopup {
  static Future<void> showErrorPopup(
      BuildContext context, String errorMessage) async {
    return await showDialog<void>(
      context: context,
      builder: (context) => _ErrorDialog(errorMessage),
    );
  }

  static Future<void> showSuccessPopup(
      BuildContext context, String successMessage) async {
    return await showDialog<void>(
      context: context,
      builder: (context) => _SuccessDialog(successMessage),
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  final errorMessage;

  _ErrorDialog(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error!"),
      content: Text(errorMessage),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final successMessage;

  _SuccessDialog(this.successMessage);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success!"),
      content: Text(successMessage),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
