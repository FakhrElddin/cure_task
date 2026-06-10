import 'package:cure_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_styles.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(color: AppColors.primaryColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message, style: AppStyles.semiBold18Text),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    bool barrierDismissible = true,
    String? title,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);

            posAction?.call();
          },
          child: Text(posActionName, style: AppStyles.semiBold18Text),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName, style: AppStyles.semiBold18Text),
        ),
      );
    }
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          content: Text(message, style: AppStyles.semiBold18Text),
          title: Text(title ?? '', style: AppStyles.semiBold18Text),
          actions: actions,
        );
      },
    );
  }
}
