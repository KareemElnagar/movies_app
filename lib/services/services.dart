import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/show_details_model.dart';
import '../models/show_models.dart';

part 'show_services.dart';

abstract class Services {
  void init();

  void dispose();
}

class ServiceResult<T> {
  @required
  bool? status;

  T? data;
  String? message;

  ServiceResult({ this.data,  this.message,  this.status});
}