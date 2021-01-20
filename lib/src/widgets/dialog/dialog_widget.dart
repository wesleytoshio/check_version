import 'package:check_version/src/locales/dialog_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogWidget {
  BuildContext context;

  VoidCallback dismissAction;

  VoidCallback onUpdate;

  String title;

  EdgeInsetsGeometry titlePadding;

  TextStyle titleTextStyle = new TextStyle();

  TextStyle contentTextStyle = new TextStyle();

  DialogLocale dialogLocale;

  bool canDismissible;

  DialogWidget({
    this.context,
    this.dismissAction,
    this.onUpdate,
    this.title: 'Update Available',
    this.titlePadding,
    this.titleTextStyle,
    this.contentTextStyle,
    this.dialogLocale,
    this.canDismissible = true,
  }) : assert(context != null);

  show() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        _getCupertinoDialog;
        break;
      case TargetPlatform.android:
        _getDialog;
        break;
      default:
        print('This platform is not supported');
    }
  }

  get _getDialog {
    showDialog(
      context: context,
      barrierDismissible: canDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: titleTextStyle,
          contentTextStyle: contentTextStyle,
          title: Text(title),
          content: Text(dialogLocale.locale.message),
          actions: actions(),
        );
      },
    );
  }

  get _getCupertinoDialog {
    showCupertinoDialog(
      context: context,
      barrierDismissible: canDismissible,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: titleTextStyle,
          ),
          content: Text(dialogLocale.locale.message),
          actions: actions(),
        );
      },
    );
  }

  List<Widget> actions() => [
        Visibility(
          visible: canDismissible,
          child: FlatButton(
            child: Text(dialogLocale.locale.dismissText.toUpperCase()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        FlatButton(
          child: Text(dialogLocale.locale.updateText.toUpperCase()),
          onPressed: onUpdate,
        )
      ];
}
