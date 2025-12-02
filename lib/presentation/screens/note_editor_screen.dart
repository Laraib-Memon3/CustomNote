import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/models/note.dart';
import '../providers/notes_provider.dart';
import '../widgets/color_picker.dart';

/// Screen for creating and editing notes.
class NoteEditorScreen extends StatefulWidget {
  /// The ID of the note to edit (null for new notes).
  final String? noteId;

  const NoteEditorScreen({
    super.key,
    this.noteId,
  });

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _selectedColorValue;
  bool _isEditing = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _selectedColorValue = AppColors.noteTagColors[0].value;

    // Load existing note if editing
    if (widget.noteId != null) {
      _isEditing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadNote();
      });
    }
  }

  void _loadNote() {
    final note = context.read<NotesProvider>().getNoteById(widget.noteId!);
    if (note != null) {
      setState(() {
        _titleController.text = note.title;
        _contentController.text = note.content;
        _selectedColorValue = note.colorValue;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onTitleChanged(String value) {
    setState(() {
      _hasChanges = true;
    });
  }

  void _onContentChanged(String value) {
    setState(() {
      _hasChanges = true;
    });
  }

  void _onColorChanged(int colorValue) {
    setState(() {
      _selectedColorValue = colorValue;
      _hasChanges = true;
    });
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    final notesProvider = context.read<NotesProvider>();

    if (_isEditing && widget.noteId != null) {
      await notesProvider.updateNote(
        id: widget.noteId!,
        title: title,
        content: content,
        colorValue: _selectedColorValue,
      );
    } else {
      await notesProvider.addNote(
        title: title,
        content: content,
        colorValue: _selectedColorValue,
      );
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _onWillPop() async {
    if (_hasChanges) {
      final shouldDiscard = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppStrings.discardChanges),
          content: const Text(AppStrings.unsavedChanges),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(AppStrings.keepEditing),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(AppStrings.discard),
            ),
          ],
        ),
      );
      return shouldDiscard ?? false;
    }
    return true;
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ColorPicker(
              selectedColorValue: _selectedColorValue,
              onColorSelected: (colorValue) {
                _onColorChanged(colorValue);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: AppDimensions.paddingL),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(_isEditing ? AppStrings.editNote : AppStrings.newNote),
      centerTitle: true,
      actions: [
        // Color picker button
        IconButton(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(_selectedColorValue),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          onPressed: _showColorPicker,
          tooltip: AppStrings.selectColor,
        ),
        // Save button
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: _saveNote,
          tooltip: AppStrings.saveNote,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(_selectedColorValue),
            width: 4,
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title field
            TextField(
              controller: _titleController,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: InputDecoration(
                hintText: AppStrings.titleHint,
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.5),
                    ),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onChanged: _onTitleChanged,
            ),
            const Divider(),
            // Content field
            TextField(
              controller: _contentController,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: AppStrings.contentHint,
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.5),
                    ),
              ),
              maxLines: null,
              minLines: 20,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              onChanged: _onContentChanged,
            ),
          ],
        ),
      ),
    );
  }
}
