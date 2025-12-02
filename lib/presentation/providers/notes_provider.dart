import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/app_constants.dart';
import '../../data/services/local_storage_service.dart';
import '../../domain/models/note.dart';

/// Provider for managing notes state and operations.
class NotesProvider extends ChangeNotifier {
  /// Local storage service instance.
  final LocalStorageService _storageService = LocalStorageService();

  /// UUID generator for creating note IDs.
  final Uuid _uuid = const Uuid();

  /// List of all notes.
  List<Note> _notes = [];

  /// Currently selected note for editing.
  Note? _selectedNote;

  /// Loading state indicator.
  bool _isLoading = false;

  /// Search query string.
  String _searchQuery = '';

  /// Gets the list of all notes.
  List<Note> get notes => _notes;

  /// Gets the currently selected note.
  Note? get selectedNote => _selectedNote;

  /// Gets the loading state.
  bool get isLoading => _isLoading;

  /// Gets the search query.
  String get searchQuery => _searchQuery;

  /// Gets filtered notes based on search query.
  List<Note> get filteredNotes {
    if (_searchQuery.isEmpty) return _notes;
    final query = _searchQuery.toLowerCase();
    return _notes.where((note) {
      return note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);
    }).toList();
  }

  /// Loads all notes from storage.
  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notes = await _storageService.getAllNotes();
    } catch (e) {
      debugPrint('Error loading notes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new note.
  Future<void> addNote({
    required String title,
    required String content,
    int? colorValue,
  }) async {
    final now = DateTime.now();
    final note = Note(
      id: _uuid.v4(),
      title: title.isEmpty ? 'Untitled' : title,
      content: content,
      createdAt: now,
      updatedAt: now,
      colorValue: colorValue ?? AppColors.noteTagColors[0].value,
    );

    await _storageService.addNote(note);
    await loadNotes();
  }

  /// Updates an existing note.
  Future<void> updateNote({
    required String id,
    String? title,
    String? content,
    int? colorValue,
  }) async {
    final existingNote = await _storageService.getNoteById(id);
    if (existingNote == null) return;

    final updatedNote = existingNote.copyWith(
      title: title ?? existingNote.title,
      content: content ?? existingNote.content,
      colorValue: colorValue ?? existingNote.colorValue,
      updatedAt: DateTime.now(),
    );

    await _storageService.updateNote(updatedNote);
    await loadNotes();
  }

  /// Deletes a note by ID.
  Future<void> deleteNote(String id) async {
    await _storageService.deleteNote(id);
    if (_selectedNote?.id == id) {
      _selectedNote = null;
    }
    await loadNotes();
  }

  /// Sets the currently selected note.
  void selectNote(Note? note) {
    _selectedNote = note;
    notifyListeners();
  }

  /// Sets the search query.
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Clears the search query.
  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  /// Gets a note by its ID.
  Note? getNoteById(String id) {
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }
}
