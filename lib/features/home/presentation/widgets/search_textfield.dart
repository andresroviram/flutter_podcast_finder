import 'package:flutter/material.dart';
import '../../../../../../components/glass_widgets.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(12),
        opacity: 0.38,
        blur: 18,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 48,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Search podcasts...',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              fillColor: Colors.transparent,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}
