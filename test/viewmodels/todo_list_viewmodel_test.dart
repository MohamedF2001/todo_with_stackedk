import 'package:flutter_test/flutter_test.dart';
import 'package:todo_test/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TodoListViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
