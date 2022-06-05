import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabata/data/repositories/tabata/set_current_tabata_repository_impl.dart';
import 'package:tabata/domain/usecases/tabata/set_current_tabata_use_case_impl.dart';

import '../../../data/fixtures/tabata_model_fixture.dart';
import 'set_current_tabata_use_case_impl_test.mocks.dart';

@GenerateMocks([SetCurrentTabataRepositoryImpl])
void main() {
  late MockSetCurrentTabataRepositoryImpl repository;
  late SetCurrentTabataUseCaseImpl sut;

  setUp(() {
    repository = MockSetCurrentTabataRepositoryImpl();
    sut = SetCurrentTabataUseCaseImpl(repository);
  });

  test('execute should call set on repository', () {
    var tabata = TabataModelFixture.fixture();

    when(repository.set(tabata)).thenAnswer((_) async => {});

    sut.execute(tabata);

    verify(repository.set(tabata)).called(1);
  });
}
