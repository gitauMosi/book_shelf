import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/providers/network_providers.dart';
import '../../../core/providers/app_providers.dart';
import 'onboarding_state.dart';
import 'subject_provider.dart';

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
      OnboardingNotifier.new,
    );

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    final pageController = PageController();

    // Proper disposal
    ref.onDispose(() {
      pageController.dispose();
    });

    _loadSubjects();

    return OnboardingState(
      currentPage: 0,
      selectedSubjects: const [],
      pageController: pageController,
      pages: _defaultPages,
      subjects: [],
    );
  }

  static final List<OnboardingPage> _defaultPages = [
    OnboardingPage(
      image: '🎓',
      title: 'Welcome to StudySync',
      description:
          'Your personal learning companion for academic success and organized study routines.',
    ),
    OnboardingPage(
      image: '📚',
      title: 'Select Your Subjects',
      description:
          'Choose the subjects you\'re studying to get personalized content and study plans.',
    ),
    OnboardingPage(
      image: '🎯',
      title: 'Set Your Goals',
      description:
          'Define your academic goals and track your progress with our smart analytics.',
    ),
  ];

  static final List<String> _defaultSubjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'Computer Science',
    'English',
    'History',
    'Geography',
    'Economics',
    'Business Studies',
    'Psychology',
    'Art',
    'Music',
    'Physical Education',
    'Foreign Languages',
  ];

  void _loadSubjects() {
    ref.listen<AsyncValue<bool>>(currentNetworkStatusProvider, (
      _,
      asyncIsConnected,
    ) {
      asyncIsConnected.when(
        data: (isConnected) async {
          try {
            if (isConnected) {
              final resp = await ref.read(fetchSubjectsProvider.future);
              updateSubjects(resp);
            } else {
              updateSubjects(_defaultSubjects);
            }
          } catch (e) {
            updateSubjects(_defaultSubjects);
          }
        },
        error: (error, stackTrace) {
          updateSubjects(_defaultSubjects);
        },
        loading: () {},
      );
    });
  }

  void updateSubjects(List<String> subjects) {
    state = state.copyWith(subjects: subjects);
  }

  void updateCurrentPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void toggleSubject(String subject) {
    final selected = [...state.selectedSubjects];

    if (selected.contains(subject)) {
      selected.remove(subject);
    } else {
      selected.add(subject);
    }

    state = state.copyWith(selectedSubjects: selected);
  }

  void clearSubjects() {
    state = state.copyWith(selectedSubjects: []);
  }

  void nextPage() {
    if (state.currentPage < state.pages.length - 1) {
      state.pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToEnd() {
    state.pageController.animateToPage(
      state.pages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void goToPage(int page) {
    state.pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<bool> saveFavouritesSubjects(List<String> values) async {
    try {
      await ref
          .watch(subjectRepoImplProvider)
          .saveFavouriteSubjectsInDb(values: values);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getFavouritesSubjects() async {
    try {
      final subjects = await ref
          .watch(subjectRepoImplProvider)
          .getFavouriteSubjectsFromDb();
      return subjects;
    } catch (e) {
      return [];
    }
  }
}
