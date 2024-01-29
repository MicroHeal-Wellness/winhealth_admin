import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/activity.dart';
import '../../models/user_model.dart';
import 'activity_items_forms/digestion.dart';
import 'activity_items_forms/food.dart';
import 'activity_items_forms/sleep.dart';
import 'activity_items_forms/stool.dart';
import 'activity_items_forms/stress.dart';
import 'activity_items_forms/water.dart';


class ActivityItemForm extends StatelessWidget {
  final ActivityItem? activityItem;
  final bool allowUpdate;
  final UserModel currentUser;
  final Function(Map<String, dynamic> value) onChange;

  const ActivityItemForm(
      {Key? key,
      this.activityItem,
      required this.currentUser,
      required this.onChange,
      required this.allowUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (activityItem?.activityType! == 'sleep') {
      return ActivityItemSleep(
        activityItem: activityItem,
        onChange: allowUpdate
            ? onChange
            : (value) {
                Fluttertoast.showToast(msg: "Not Allowed to change/add data!");
              },
      );
    }
    if (activityItem?.activityType! == 'water') {
      return ActivityItemWater(
        activityItem: activityItem,
        onChange: allowUpdate
            ? onChange
            : (value) {
                Fluttertoast.showToast(msg: "Not Allowed to change/add data!");
              },
      );
    }
    if (activityItem?.activityType! == 'stress') {
      return ActivityItemStress(
        activityItem: activityItem,
        onChange: allowUpdate
            ? onChange
            : (value) {
                Fluttertoast.showToast(msg: "Not Allowed to change/add data!");
              },
      );
    }
    if (activityItem?.activityType! == 'stool') {
      return ActivityItemStool(
        activityItem: activityItem,
        allowUpdate: allowUpdate,
        onChange: allowUpdate
            ? onChange
            : (value) {
                Fluttertoast.showToast(msg: "Not Allowed to change/add data!");
              },
      );
    }
    if (activityItem?.activityType! == 'food') {
      return ActivityItemFoodForm(
        activityItem: activityItem,
        onChange: allowUpdate
            ? onChange
            : (value) {
                Fluttertoast.showToast(msg: "Not Allowed to change/add data!");
              },
        currentUser: currentUser,
      );
    }
    if (activityItem?.activityType! == 'digestion') {
      return ActivityItemDigestion(
        activityItem: activityItem,
        onChange: allowUpdate
            ? onChange
            : (value) {
                Fluttertoast.showToast(msg: "Not Allowed to change/add data!");
              },
      );
    }

    return Container();
  }
}
