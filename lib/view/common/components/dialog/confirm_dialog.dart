import 'package:flutter/material.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// トップレベル関数として定義する
showConfirmDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  @required ValueChanged onConfirmed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ConfirmDialog(
      title: title,
      content: content,
      onConfirmed: onConfirmed,
    ),
  );
}

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final ValueChanged<bool> onConfirmed;
  ConfirmDialog({this.title, this.content, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text(S.of(context).yes),
          onPressed: () => _onButtonPressed(context, true),
        ),
        FlatButton(
          child: Text(S.of(context).no),
          onPressed: () => _onButtonPressed(context, false),
        ),
      ],
    );
  }

  _onButtonPressed(BuildContext context, bool isConfirmed) {
    Navigator.pop(context);
    onConfirmed(isConfirmed);
  }
}
