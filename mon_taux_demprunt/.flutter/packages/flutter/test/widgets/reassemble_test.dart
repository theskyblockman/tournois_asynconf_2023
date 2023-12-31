// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgetsWithLeakTracking('reassemble does not crash', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Text('Hello World'),
    ));
    await tester.pump();
    tester.binding.reassembleApplication();
    await tester.pump();
  });
}
