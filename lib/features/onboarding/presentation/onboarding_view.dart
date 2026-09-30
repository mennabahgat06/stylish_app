import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../data/models/onboarding_item.dart';
import 'get_started_view.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/page_indicator.dart';

/// 3 intro pages with Skip / Prev / Next.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  final List<OnboardingItem> _pages = OnboardingItem.pages;
  int _currentPage = 0;

  bool get _isLastPage => _currentPage == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToGetStarted() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GetStartedView()),
    );
  }

  void _next() {
    if (_isLastPage) return _goToGetStarted();
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void _previous() {
    _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _goToGetStarted,
                  child: const Text('Skip',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (_, index) => OnboardingPage(item: _pages[index]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage > 0
                      ? TextButton(
                          onPressed: _previous,
                          child: const Text('Prev', style: TextStyle(color: AppColors.textMuted)),
                        )
                      : const SizedBox(width: 64),
                  PageIndicator(count: _pages.length, currentIndex: _currentPage),
                  TextButton(
                    onPressed: _next,
                    child: Text(
                      _isLastPage ? 'Get Started' : 'Next',
                      style: const TextStyle(
                          color: AppColors.primaryPink, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
