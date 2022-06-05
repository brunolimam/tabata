import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabata/data/repositories/tabata/get_current_tabata_repository_impl.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case_impl.dart';

import '../../../data/fixtures/tabata_model_fixture.dart';
import 'get_current_tabata_use_case_impl_test.mocks.dart';

@GenerateMocks([GetCurrentTabataRepositoryImpl])
void main() {
  late MockGetCurrentTabataRepositoryImpl getCurrentTabataRepository;
  late GetCurrentTabataUseCaseImpl sut;

  setUp(() {
    getCurrentTabataRepository = MockGetCurrentTabataRepositoryImpl();
    sut = GetCurrentTabataUseCaseImpl(getCurrentTabataRepository);
  });

  test('execute when repository return null should return default tabata',
      () async {
    when(getCurrentTabataRepository.get()).thenAnswer((_) async => null);

    var result = await sut.execute();
    expect(result, const Tabata.defaultValue());
  });

  test('execute when repository return tabata should return tabata', () async {
    var tabata = TabataModelFixture.fixture();
    when(getCurrentTabataRepository.get())
        .thenAnswer((_) async => TabataModelFixture.fixture());

    var result = await sut.execute();
    expect(result, tabata);
  });
}
