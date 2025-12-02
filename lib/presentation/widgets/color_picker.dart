import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// A reusable color picker widget for selecting note color tags.
///
/// Displays a horizontal list of color options that the user can select from.
class ColorPicker extends StatelessWidget {
  /// The currently selected color value.
  final int selectedColorValue;

  /// Callback when a color is selected.
  final ValueChanged<int> onColorSelected;

  /// List of colors to display (defaults to noteTagColors).
  final List<Color>? colors;

  /// Size of each color item.
  final double itemSize;

  /// Spacing between color items.
  final double spacing;

  const ColorPicker({
    super.key,
    required this.selectedColorValue,
    required this.onColorSelected,
    this.colors,
    this.itemSize = AppDimensions.colorPickerItemSize,
    this.spacing = AppDimensions.colorPickerSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final colorList = colors ?? AppColors.noteTagColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.selectColor,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimensions.paddingM),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: colorList.map((color) {
              final isSelected = color.value == selectedColorValue;
              return Padding(
                padding: EdgeInsets.only(right: spacing),
                child: _ColorItem(
                  color: color,
                  isSelected: isSelected,
                  size: itemSize,
                  onTap: () => onColorSelected(color.value),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Individual color item widget.
class _ColorItem extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final double size;
  final VoidCallback onTap;

  const _ColorItem({
    required this.color,
    required this.isSelected,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                size: size * 0.5,
                color: _getContrastColor(color),
              )
            : null,
      ),
    );
  }

  /// Returns a contrasting color (black or white) based on the background color.
  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

/// A dialog wrapper for the color picker.
class ColorPickerDialog extends StatefulWidget {
  /// Initial selected color value.
  final int initialColorValue;

  /// Title of the dialog.
  final String title;

  const ColorPickerDialog({
    super.key,
    required this.initialColorValue,
    this.title = AppStrings.selectColor,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late int _selectedColorValue;

  @override
  void initState() {
    super.initState();
    _selectedColorValue = widget.initialColorValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: ColorPicker(
        selectedColorValue: _selectedColorValue,
        onColorSelected: (colorValue) {
          setState(() {
            _selectedColorValue = colorValue;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_selectedColorValue),
          child: const Text('Select'),
        ),
      ],
    );
  }
}
