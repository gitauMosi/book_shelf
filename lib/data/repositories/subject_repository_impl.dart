import '../../core/services/app_client.dart';
import '../../domain/repositories/subjects_repository.dart';

class SubjectRepositoryImpl extends SubjectsRepository {
  final ApiClient apiClient;

  SubjectRepositoryImpl({required this.apiClient});
  @override
  Future<List<String>> fetchSubjects() async {
    try {
      final response = await apiClient.get(path: '/subjects');
      if (response.statusCode == 200) {
        final data = response.data["results"] as List<dynamic>;
        return data.map((subject) => subject["name"].toString()).toList();
      } else {
        throw Exception('Failed to load subjects: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
