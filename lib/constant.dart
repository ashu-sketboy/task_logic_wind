import 'package:flutter/material.dart';

enum Status {
  Success,
  Loading,
  NetworkError,
  Error,
}

const circularLoading = Center(
    child: CircularProgressIndicator(
  backgroundColor: Colors.grey,
  valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(36, 59, 124, 1)),
));
