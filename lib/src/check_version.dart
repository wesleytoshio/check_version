import 'dart:convert';

import 'package:check_version/src/locales/dialog_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'model/version_status.dart';
import 'widgets/dialog/dialog_widget.dart';

class CheckVersion {
  BuildContext context;

  String playStoreId;

  String appStoreId;

  Function(VersionStatus) callback;

  String title;

  EdgeInsetsGeometry titlePadding;

  TextStyle titleTextStyle;

  EdgeInsetsGeometry contentPadding;

  TextStyle contentTextStyle;

  String locale;

  bool barrierDismissible;

  CheckVersion({
    this.playStoreId,
    this.appStoreId,
    @required this.context,
    this.callback,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.contentPadding,
    this.contentTextStyle,
    this.locale,
    this.barrierDismissible = true,
  }) : assert(context != null);

  run() async {
    DialogLocale _dialogLocale = new DialogLocale();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    VersionStatus versionStatus = VersionStatus(
      currentVersion: packageInfo.version,
      packageName: packageInfo.packageName,
    );
    await _checkVersion(versionStatus);
    print('Needed update: ${versionStatus.hasUpdate}');
    print('Current version: ${versionStatus.currentVersion}');
    print('Available version: ${versionStatus.storeVersion}');
    if (versionStatus.hasUpdate) {
      _dialogLocale.set(locale, packageInfo.appName,
          versionStatus.currentVersion, versionStatus.storeVersion);
      DialogWidget(
        context: context,
        title: title,
        titlePadding: titlePadding,
        titleTextStyle: titleTextStyle,
        contentTextStyle: contentTextStyle,
        barrierDismissible: barrierDismissible,
        dialogLocale: _dialogLocale,
        onUpdate: () {
          _launchStore(versionStatus.storeURL);
        },
        onDismiss: () => callback(versionStatus),
      ).show();
    }
  }

  _checkVersion(VersionStatus versionStatus) async {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        versionStatus.storeURL = '$APP_STORE${versionStatus.packageName}';
        await _getAppStoreVersion(versionStatus);
        break;
      case TargetPlatform.android:
        versionStatus.storeURL = '$PLAY_STORE${versionStatus.packageName}';
        await _getplayStoreVersion(versionStatus);
        break;
      default:
        print('This platform is not supported');
    }
    return versionStatus;
  }

  Future<VersionStatus> _getplayStoreVersion(
      VersionStatus versionStatus) async {
    final response = await http.get(versionStatus.storeURL);
    if (response.statusCode != 200) {
      print('$NOT_FOUND_TEXT Play Store.');
      return null;
    }
    final doc = parse(response.body);
    final els = doc.getElementsByClassName('hAyfc');
    final versionElement = els.firstWhere(
      (elm) => elm.querySelector('.BgcNfc').text == 'Current Version',
    );
    versionStatus.storeVersion = versionElement.querySelector('.htlgb').text;
    return versionStatus;
  }

  Future<VersionStatus> _getAppStoreVersion(VersionStatus versionStatus) async {
    final response = await http.get(versionStatus.storeURL);
    if (response.statusCode != 200) {
      print('$NOT_FOUND_TEXT App Store.');
      return null;
    }
    final jsonObject = json.decode(response.body);
    versionStatus.storeVersion = jsonObject['results'][0]['version'];
    versionStatus.storeURL = jsonObject['results'][0]['trackViewUrl'];
    return versionStatus;
  }

  void _launchStore(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch appStoreLink';
    }
  }
}
