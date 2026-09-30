import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import 'get_started_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = const [
    {
      'title': 'Choose Products',
      'desc': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      'icon': 'shop',
    },
    {
      'title': 'Make Payment',
      'desc': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      'icon': 'payment',
    },
    {
      'title': 'Get Your Order',
      'desc': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      'icon': 'delivery',
    },
  ];

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
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const GetStartedView()),
                  ),
                  child: const Text('Skip', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.pink.shade50,
                          child: Icon(
                            index == 0
                                ? Icons.shopping_bag_outlined
                                : index == 1
                                    ? Icons.credit_card_outlined
                                    : Icons.local_shipping_outlined,
                            size: 80,
                            color: AppColors.primaryPink,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          _pages[index]['title']!,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _pages[index]['desc']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.5),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage > 0
                      ? TextButton(
                          onPressed: () => _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ),
                          child: const Text('Prev', style: TextStyle(color: AppColors.textMuted)),
                        )
                      : const SizedBox(width: 48),
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? AppColors.textBlack : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const GetStartedView()),
                        );
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                      style: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold),
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