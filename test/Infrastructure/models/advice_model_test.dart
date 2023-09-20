import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:api_name/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tAdviceModel = AdviceModel("test", 1);

  test("model should be subclass of advice-entity", () {
    //assert
    expect(tAdviceModel, isA<AdviceEntity>());
  });

  group("from Json factory", () {
    test("should return a valid model if the JSON advice is correct", () {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("advice.json"));
      //act
      final result = AdviceModel.fromJson(jsonMap);
      //assert
      expect(result, tAdviceModel);
    });
  });
}
