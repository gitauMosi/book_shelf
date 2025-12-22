import '../../core/constants/db_constants.dart';
import '../../core/services/app_client.dart';
import '../../core/services/db_client.dart';
import '../../domain/repositories/subjects_repository.dart';

class SubjectRepositoryImpl extends SubjectsRepository {
  final ApiClient apiClient;
  final DbClient dbClient;

  SubjectRepositoryImpl({required this.apiClient, required this.dbClient});
  @override
  Future<List<String>> fetchSubjects() async {
    try {
      final response = await apiClient.get(path: '/subjects');
      if (response.statusCode == 200) {
        final data = response.data["results"] as List<dynamic>;
        List<String> subjects = data
            .map((subject) => subject["name"].toString())
            .toList();
        await saveSubjectsInDb(subjects);
        return subjects;
      } else {
        throw Exception('Failed to load subjects: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> saveSubjectsInDb(List<String> value) async {
    try {
      await dbClient.addList(key: DbConstantsKeys.subjectsKey, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> fetchSubjectsFromDb() async {
    try {
      List<dynamic> subject = dbClient.getList(
        key: DbConstantsKeys.subjectsKey,
      );
      return subject as List<String>;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveFavouriteSubjectsInDb({required List<String> values}) async {
    try {
      await dbClient.addList(
        key: DbConstantsKeys.favouriteSubjectsKey,
        value: values,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getFavouriteSubjectsFromDb() async {
    try {
      List<dynamic> subject = dbClient.getList(
        key: DbConstantsKeys.subjectsKey,
      );
      return subject as List<String>;
    } catch (e) {
      rethrow;
    }
  }
}
