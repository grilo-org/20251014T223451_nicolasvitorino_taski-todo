import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: widget.controller,
        onChanged: (text) {
          setState(() {});
          widget.onChanged(text);
        },
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset('assets/search.jpg', width: 20, height: 20),
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Image.asset('assets/clear.jpg'),
                  onPressed: () {
                    widget.controller.clear();
                    widget.onChanged('');
                    setState(() {});
                  },
                )
              : null,
          hintText: "Search tasks...",
          hintStyle: const TextStyle(color: Color(0xFF8D9CB8)),
          filled: true,
          fillColor: const Color.fromARGB(255, 245, 247, 249),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
