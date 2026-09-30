import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/slider_model.dart';
import 'slide_card.dart';

/// Swipeable banners from GET sliders, with dots.
class SliderBanner extends StatefulWidget {
  final List<SliderModel> sliders;

  const SliderBanner({super.key, required this.sliders});

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.sliders.isEmpty) return const SizedBox();
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            itemCount: widget.sliders.length,
            onPageChanged: (index) => setState(() => _current = index),
            itemBuilder: (_, index) => SlideCard(slider: widget.sliders[index]),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.sliders.length, (index) {
            final isActive = index == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 10 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryPink : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}
