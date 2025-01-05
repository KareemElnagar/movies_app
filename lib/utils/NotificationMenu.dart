import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/utils/colors.dart';

class NotificationMenuModel {
  final String title;
  final String description;
  final String time;
  final bool isRead;

  NotificationMenuModel({
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
  });
}

class NotificationItem extends StatelessWidget {
  final NotificationMenuModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        FontAwesomeIcons.bell,
        color: notification.isRead ? Colors.white : AppColors.primary,
      ),
      title: Text(
        notification.title,
        style: TextStyle(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          color: AppColors.text,
        ),
      ),
      subtitle: Text(
        notification.description,
        style: TextStyle(
          color: AppColors.text,
        ),
      ),
      trailing: Text(
        notification.time,
        style: TextStyle(
          color: AppColors.text,
          fontSize: 12,
        ),
      ),
    );
  }
}
