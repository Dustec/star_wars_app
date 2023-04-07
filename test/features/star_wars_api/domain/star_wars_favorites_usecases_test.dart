import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_character.dart';

import 'package:star_wars_app/features/star_wars_api/domain/star_wars_favorites_usecases.dart';
import 'package:star_wars_app/features/star_wars_api/domain/star_wars_repository.dart';
import 'package:star_wars_app/features/user_favorites/domain/sources/user_favs_source.dart';

import 'star_wars_favorites_usecases_test.mocks.dart';

@GenerateMocks(<Type>[
  UserFavSource,
  StarWarsRepository,
])
void main() {
  group('StarWarsFavoritesUseCasesTest', () {
    const charactersStubList = [
      StarWarsCharacter(
        name: 'name',
        url: 'url-1',
        homeWorld: 'homeWorld',
        birthYear: 'birthYear',
      ),
    ];

    final MockUserFavSource dbSource = MockUserFavSource();
    final MockStarWarsRepository remoteRepo = MockStarWarsRepository();

    StarWarsFavoritesUseCasesImp buildUseCases() =>
        StarWarsFavoritesUseCasesImp(
          favDbSource: dbSource,
          remoteRepo: remoteRepo,
        );

    setUp(() {
      reset(dbSource);
      reset(remoteRepo);
    });

    test('saveFavorites', () {
      final StarWarsFavoritesUseCasesImp useCases = buildUseCases();

      useCases.saveFavorite('url');

      verify(dbSource.saveFavorite('url')).called(1);
      verifyZeroInteractions(remoteRepo);
    });

    test('removeFavorites', () {
      final StarWarsFavoritesUseCasesImp useCases = buildUseCases();

      useCases.removeFavorite('url');

      verify(dbSource.removeFavorite('url')).called(1);
      verifyZeroInteractions(remoteRepo);
    });

    test('getFavoritePeople', () {
      when(dbSource.getFavorites()).thenReturn(['url-1']);

      final StarWarsFavoritesUseCasesImp useCases = buildUseCases();

      final result = useCases.getFavoritePeople(characters: charactersStubList);

      expect(result[0].isFavorite, true);
    });
  });
}
