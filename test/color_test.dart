import 'package:ecotags/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test color variables', () {
    expect(backgroundColor, Color.fromRGBO(5, 5, 34, 1));
    expect(primaryColor, Color(0xff90FF69));
    expect(secondaryTextColor, Color.fromRGBO(255, 255, 255, 1));
    expect(primaryTextColor, Color(0xff90FF69));
    expect(appColor, const Color.fromRGBO(5, 5, 34, 1));
    expect(secondaryColor, Color.fromARGB(255, 219, 236, 88));
    expect(extraColor, Color.fromRGBO(160, 147, 107, 1));
  });
}