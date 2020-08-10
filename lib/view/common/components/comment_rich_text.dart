import 'package:flutter/material.dart';

// style
import 'package:insta_clone/style.dart';

class CommentRichText extends StatefulWidget {
  final String name;
  final String content;
  CommentRichText({@required this.name, @required this.content});

  @override
  _CommentRichTextState createState() => _CommentRichTextState();
}

class _CommentRichTextState extends State<CommentRichText> {
  int _maxLines = 2;
  bool _isShortening = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        _maxLines = _isShortening ? 100 : 2;
        _isShortening = !_isShortening;
      }),
      child: RichText(
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: widget.name, style: commentNameTextStyle),
            TextSpan(text: ' '),
            TextSpan(text: widget.content, style: commentContentTextStyle),
          ],
        ),
      ),
    );
  }
}
