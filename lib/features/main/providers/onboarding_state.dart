import 'package:flutter/material.dart';

class OnboardingPage {
  final String image;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
  });
}

class OnboardingState {
  final int currentPage;
  final List<String> selectedSubjects;
  final PageController pageController;
  final List<OnboardingPage> pages;
  final List<String> subjects;

  OnboardingState({
    required this.currentPage,
    required this.selectedSubjects,
    required this.pageController,
    required this.pages,
    required this.subjects,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<String>? selectedSubjects,
    PageController? pageController,
    List<OnboardingPage>? pages,
    List<String>? subjects,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      selectedSubjects: selectedSubjects ?? this.selectedSubjects,
      pageController: pageController ?? this.pageController,
      pages: pages ?? this.pages,
      subjects: subjects ?? this.subjects,
    );
  }
}