import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service_impl.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late GetCurrentTabataServiceImpl sut;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    sut = GetCurrentTabataServiceImpl(firestore);
  });

  test('get when firestore not return any data should return null', () async {
    const userId = "userId";

    // firestore.doc('collection$userId').set({});

    var result = await sut.get(userId);

    expectLater(result, null);
  });

  test('get when firestore return some data should return tabata', () async {
    const userId = "userId";

    firestore.doc('tabatas/$userId').set({
      'seriesTime': '00:00',
      'seriesQuantity': '0',
      'restTime': '00:00',
      'cycleQuantity': '0',
      'timeBetweenCycles': '00:00',
    });

    var result = await sut.get(userId);

    expectLater(result == null, false);
  });
}
