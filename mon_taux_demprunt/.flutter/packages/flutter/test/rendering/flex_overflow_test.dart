// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgetsWithLeakTracking('Flex overflow indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: Column(
          children: <Widget>[
            SizedBox(width: 200.0, height: 200.0),
          ],
        ),
      ),
    );

    expect(find.byType(Column), isNot(paints..rect()));

    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          height: 100.0,
          child: Column(
            children: <Widget>[
              SizedBox(width: 200.0, height: 200.0),
            ],
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNotNull);

    expect(find.byType(Column), paints..rect());

    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          height: 0.0,
          child: Column(
            children: <Widget>[
              SizedBox(width: 200.0, height: 200.0),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Column), isNot(paints..rect()));
  });
}
