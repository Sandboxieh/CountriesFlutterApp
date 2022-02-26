import 'package:countries_interview_application/controller/noteController.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty title returns error string', () {
    final result = NoteController.validateTitle('');
    expect(result, 'Title can\'t be empty');
  });

  test('non-empty title returns null', () {
    final result = NoteController.validateTitle('title');
    expect(result, null);
  });

  test('empty content returns error string', () {
    final result = NoteController.validateContent('');
    expect(result, 'Content can\'t be empty');
  });

  test('non-empty content returns null', () {
    final result = NoteController.validateContent('content');
    expect(result, null);
  });
}
