import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/env/environment_config_reader.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class ShareServices {
  static ShareServices get instance => GetIt.I<ShareServices>();

  void copyToClipBoard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text)).then((value) {
      AppSnackBar.showSimpleToast(
          msg: Translate.of(context).copied_successfully);
    });
  }

  Future<bool?> launchURL({required String url}) async {
    final uri = Uri.parse(url);
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<bool?> launchURLInApp({required String url}) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);
      return launched;
    } else {
      return null;
      // throw 'Could not launch $url';
    }
  }

  Future<bool?> launchURLExternally({required String url}) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      return launched;
    } else {
      return null;
      // throw 'Could not launch $url';
    }
  }

  void launchWhatsApp(phone, BuildContext context) async {
    String message = Translate.of(context).Welcome;
    var whatsAppUrl =
        "https://api.whatsapp.com/send?phone=+$phone&text=$message";
    if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
      await launchUrl(Uri.parse(whatsAppUrl));
    } else {
      AppSnackBar.showSimpleToast(
          msg: Translate.of(context).something_went_wrong);
    }
  }

  void callPhone({required String phone}) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    await launchUrl(phoneLaunchUri);
  }

  void sendEmail({required String email}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailLaunchUri);
  }

  void onLink({required String link}) {
    launchURL(url: link);
  }

  void shareApp() {
    String appLink = FlutterEnvironmentConfigReader.instance.androidLink();
    if (Platform.isIOS) {
      appLink = FlutterEnvironmentConfigReader.instance.iosLink();
    }
    Share.share(appLink);
  }
}
