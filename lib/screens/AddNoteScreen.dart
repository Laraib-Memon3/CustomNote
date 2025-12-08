import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String noteTitle = '';
  String noteContent = '';
  Color backgroundColor = const Color(0xFFFFF9C4); // light yellow

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.push_pin_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.color_lens_outlined, color: Colors.black),
            onPressed: () {
              // Example: toggle between yellow and white
              setState(() {
                backgroundColor = backgroundColor == const Color(0xFFFFF9C4)
                    ? Colors.white
                    : const Color(0xFFFFF9C4);
              });
            },
          ),
          IconButton(
            icon: const Text(
              'T',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            onPressed: _showCustomizationSheet,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title Field
            TextField(
              onChanged: (value) => setState(() => noteTitle = value),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 8),

            // Content Field
            Expanded(
              child: TextField(
                onChanged: (value) => setState(() => noteContent = value),
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: 'Start typing...',
                  border: InputBorder.none,
                ),
              ),
            ),

            // Formatting Toolbar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.format_bold, color: Colors.black),
                  Icon(Icons.format_italic, color: Colors.black),
                  Icon(Icons.format_list_bulleted, color: Colors.black),
                  Icon(Icons.format_list_numbered, color: Colors.black),
                  Icon(Icons.check_box_outlined, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomizationSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🎨 Note Color
              const Text(
                'Note color',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _colorCircle(Color(0xFFEF3C7), true),
                  _colorCircle(Color(0xFCE7F3), false),
                  _colorCircle(Color(0xFFF3F4F6), false),
                  _colorCircle(Color(0xFFEDE9FE), false),
                  _colorCircle(Color(0xFFDCFCE7), false),
                  _colorCircle(Color(0xFFDBEAFE), false),
                ],
              ),
              const SizedBox(height: 20),

              // 🔤 Font
              const Text('Font', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: const [
                  _fontOption('Sans', true),
                  _fontOption('Serif', false),
                  _fontOption('Mono', false),
                ],
              ),
              const SizedBox(height: 15),

              // 🔠 Text Size
              const Text(
                'Text size',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 08),
              Row(
                children: const [
                  _sizeOption('Small', false),
                  _sizeOption('Medium', true),
                  _sizeOption('Large', false),
                ],
              ),
              const SizedBox(height: 15),

              // ✅ Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _colorCircle(Color color, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: selected ? Border.all(color: Colors.black, width: 2) : null,
      ),
      child: selected
          ? const Icon(Icons.check, size: 18, color: Colors.black)
          : null,
    );
  }
}

class _sizeOption extends StatelessWidget {
  final String label;
  final bool selected;
  const _sizeOption(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? const Color(0xFF4F46E5) : Colors.black,
        ),
      ),
    );
  }
}

class _fontOption extends StatelessWidget {
  final String label;
  final bool selected;
  const _fontOption(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? const Color(0xFF4F46E5) : Colors.black,
        ),
      ),
    );
  }
}

class _colorOption extends StatelessWidget {
  final String label;
  final bool selected;
  const _colorOption(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? const Color(0xFF4F46E5) : Colors.black,
        ),
      ),
    );
  }
}
