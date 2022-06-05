import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service_impl.dart';
import '../../fixtures/tabata_model_fixture.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late SetCurrentTabataServiceImpl sut;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    sut = SetCurrentTabataServiceImpl(firestore);
  });

  test('set when set tabata should set on firestore document', () async {
    var userId = 'userId';
    var tabataModel = TabataModelFixture.fixture();

    sut.set(tabataModel, userId);

    var snapshot = await firestore.doc('tabatas/$userId').get();

    expect(snapshot.data(), tabataModel.toJson());
  });
}
