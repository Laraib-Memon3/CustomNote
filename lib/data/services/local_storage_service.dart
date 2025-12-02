import 'package:uuid/uuid.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/models/note.dart';
import '../../domain/repositories/note_repository.dart';

/// Dummy local storage service for notes.
///
/// This is a temporary in-memory implementation that can be replaced
/// with a real database (SQLite, Hive, etc.) in production.
class LocalStorageService implements NoteRepository {
  /// In-memory storage for notes.
  final List<Note> _notes = [];

  /// UUID generator for creating unique note IDs.
  final Uuid _uuid = const Uuid();

  /// Singleton instance.
  static final LocalStorageService _instance = LocalStorageService._internal();

  /// Private constructor for singleton pattern.
  LocalStorageService._internal() {
    // Initialize with some sample notes for demonstration
    _initializeSampleNotes();
  }

  /// Factory constructor to return the singleton instance.
  factory LocalStorageService() => _instance;

  /// Initializes sample notes for demonstration purposes.
  void _initializeSampleNotes() {
    final now = DateTime.now();

    _notes.addAll([
      Note(
        id: _uuid.v4(),
        title: 'Welcome to CustomNote',
        content: 'This is your first note. Tap to edit or create new notes using the + button.',
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
        colorValue: AppColors.noteTagColors[0].value,
      ),
      Note(
        id: _uuid.v4(),
        title: 'Shopping List',
        content: '• Milk\n• Eggs\n• Bread\n• Butter\n• Fresh vegetables',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(hours: 12)),
        colorValue: AppColors.noteTagColors[2].value,
      ),
      Note(
        id: _uuid.v4(),
        title: 'Meeting Notes',
        content: 'Discussed project timeline and deliverables. Next meeting scheduled for Friday.',
        createdAt: now.subtract(const Duration(hours: 5)),
        updatedAt: now.subtract(const Duration(hours: 5)),
        colorValue: AppColors.noteTagColors[4].value,
      ),
    ]);
  }

  @override
  Future<List<Note>> getAllNotes() async {
    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 100));
    // Return notes sorted by update time (newest first)
    final sortedNotes = List<Note>.from(_notes)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return sortedNotes;
  }

  @override
  Future<Note?> getNoteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _notes.add(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _notes.removeWhere((note) => note.id == id);
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (query.isEmpty) return getAllNotes();

    final lowercaseQuery = query.toLowerCase();
    final results = _notes.where((note) {
      return note.title.toLowerCase().contains(lowercaseQuery) ||
          note.content.toLowerCase().contains(lowercaseQuery);
    }).toList();

    results.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return results;
  }

  /// Generates a new unique ID for notes.
  String generateId() => _uuid.v4();

  /// Clears all notes (useful for testing).
  Future<void> clearAllNotes() async {
    await Future.delayed(const Duration(milliseconds: 50));
    _notes.clear();
  }
}
