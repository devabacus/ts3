
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

// Эндпоинт для управления записями TestData
class TestDataEndpoint extends Endpoint {
  
  /// Создает новую запись TestData в базе данных.
  Future<TestData> createTestData(Session session, TestData testData) async {
    final testNew2 = testData.copyWith(title3: "stas");

    await TestData.db.insertRow(session, testNew2);
    return testNew2;
  }

  /// Возвращает список всех записей.
  Future<List<TestData>> listTestDatas(Session session) async {
    return await TestData.db.find(
      session,
      orderBy: (t) => t.title3,
    );
  }

  /// Обновляет существующую запись.
  Future<TestData> updateTestData(Session session, TestData testData) async {
    await TestData.db.updateRow(session, testData);
    return testData;
  }

  /// Удаляет запись.
  Future<bool> deleteTestData(Session session, TestData testData) async {
    final result = await TestData.db.deleteRow(session, testData);
    return result.id == testData.id;
  }
}
