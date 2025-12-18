
// fetch subjects provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_providers.dart';

final fetchSubjectsProvider = FutureProvider<List<String>>((ref){
  return ref.watch(subjectRepoImplProvider).fetchSubjects();
});