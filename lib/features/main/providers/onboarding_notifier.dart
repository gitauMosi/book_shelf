import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<void> _loadSubjects() async {
    try {
      final resp = await ref.read(fetchSubjectsProvider.future);
      updateSubjects(resp);
    } catch (e) {
      updateSubjects(_defaultSubjects);
      throw Exception('Failed to load subjects');
    }
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
}
