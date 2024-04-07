import 'package:flutter_test/flutter_test.dart';
import 'package:hw4/utils/string_validator.dart';

void main() {
  test('Validate Email Address', () {
    //null input
    expect(validateEmailAddress(null), "Something went wrong");

    //valid email
    expect(validateEmailAddress("dat@gmail.com"), isNull);

    //invalid email
    expect(validateEmailAddress("3@gmailcom"), "Invalid email format");
    expect(validateEmailAddress("dat.com"), "Invalid email format");
  });

  test('Validate password', () {
    //null input
    expect(validatePassword(null), "Something went wrong");

    //correct password
    expect(validatePassword("password123"), isNull);

    //incorrect password length
    expect(
        validatePassword("abc"), "Password must contain at least 6 characters");
  });

  test("Validate non-empty message", () {
    //null input
    expect(validateNonEmptyMessage(null), "This field must not be empty");

    //empty string
    expect(validateNonEmptyMessage(""), "This field must not be empty");

    //non empty string
    expect(validateNonEmptyMessage("message"), isNull);
  });
}
