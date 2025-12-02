import '../models/note.dart';

/// Abstract repository interface for note operations.
///
/// Defines the contract that any note storage implementation must follow.
abstract class NoteRepository {
  /// Retrieves all notes.
  Future<List<Note>> getAllNotes();

  /// Retrieves a single note by its ID.
  Future<Note?> getNoteById(String id);

  /// Adds a new note.
  Future<void> addNote(Note note);

  /// Updates an existing note.
  Future<void> updateNote(Note note);

  /// Deletes a note by its ID.
  Future<void> deleteNote(String id);

  /// Searches notes by title or content.
  Future<List<Note>> searchNotes(String query);
}
