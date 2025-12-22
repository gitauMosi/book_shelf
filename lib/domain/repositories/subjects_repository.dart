abstract class SubjectsRepository {
  Future<List<String>> fetchSubjects();
  Future<List<String>> fetchSubjectsFromDb();
  Future<void> saveFavouriteSubjectsInDb({required List<String> values});
  Future<List<String>> getFavouriteSubjectsFromDb();
}
