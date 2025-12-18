import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/subject_utils.dart';
import '../providers/onboarding_notifier.dart';
import '../providers/onboarding_state.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value:
                  (state.currentPage + 1) /
                  (state.pages.length + (state.currentPage == 1 ? 1 : 0)),
              backgroundColor: Colors.grey[100],
              color: const Color(0xFF46BD61),
              minHeight: 2,
            ),

            Expanded(
              child: PageView.builder(
                controller: state.pageController,
                onPageChanged: notifier.updateCurrentPage,
                itemCount:
                    state.pages.length + (state.currentPage >= 1 ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == 1) {
                    return _buildSubjectsPage(state, notifier, context);
                  }
                  final pageIndex = index > 1 ? index - 1 : index;
                  return _buildOnboardingPage(
                    state.pages[pageIndex],
                    state.currentPage,
                    context,
                  );
                },
              ),
            ),

            // Navigation
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: state.currentPage == 1
                  ? _buildSubjectSelectionButtons(state, notifier, context)
                  : _buildNavigationButtons(state, notifier, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(
    OnboardingPage page,
    int currentPage,
    BuildContext context,
  ) {
    return Container(
      color: page.color.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated emoji/image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: page.color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(page.image, style: const TextStyle(fontSize: 60)),
            ),
          ),

          const SizedBox(height: 48),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              page.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              page.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 48),

          // Dots indicator
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(onboardingProvider);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(state.pages.length, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == state.currentPage
                          ? const Color(0xFF46BD61)
                          : Colors.grey[300],
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsPage(
    OnboardingState state,
    OnboardingNotifier notifier,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Title
            Text(
              'Select Your Subjects',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 32,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              'Choose all subjects you\'re currently studying. You can update this later.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            // Subject grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: state.subjects.length,
              itemBuilder: (context, index) {
                final subject = state.subjects[index];
                final isSelected = state.selectedSubjects.contains(subject);

                return GestureDetector(
                  onTap: () => notifier.toggleSubject(subject),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF46BD61).withOpacity(0.1)
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF46BD61)
                            : Colors.grey[200]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              getSubjectIcon(subject),
                              size: 32,
                              color: isSelected
                                  ? const Color(0xFF46BD61)
                                  : Colors.grey[600],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Text(
                                subject.length > 10
                                    ? '${subject.substring(0, 10)}...'
                                    : subject,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF46BD61)
                                      : Colors.grey[700],
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        if (isSelected)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFF46BD61),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(
    OnboardingState state,
    OnboardingNotifier notifier,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Skip button
        TextButton(
          onPressed: state.currentPage == state.pages.length - 1
              ? null
              : notifier.skipToEnd,
          child: Text(
            'Skip',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ),

        // Next button
        ElevatedButton(
          onPressed: () {
            if (state.currentPage < state.pages.length - 1) {
              notifier.nextPage();
            } else {
              // Navigate to home screen
              Navigator.pushReplacementNamed(context, AppRoutes.main);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF46BD61),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text(
            state.currentPage == state.pages.length - 1
                ? 'Get Started'
                : 'Next',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectSelectionButtons(
    OnboardingState state,
    OnboardingNotifier notifier,
    BuildContext context,
  ) {
    return Column(
      children: [
        // Selected count
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF46BD61).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: const Color(0xFF46BD61),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${state.selectedSubjects.length} subjects selected',
                style: const TextStyle(
                  color: Color(0xFF46BD61),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Continue button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.selectedSubjects.isNotEmpty
                ? notifier.nextPage
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF46BD61),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              elevation: 0,
            ),
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
