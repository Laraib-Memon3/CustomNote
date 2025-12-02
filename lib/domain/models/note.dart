import 'package:flutter/material.dart';

/// Note model representing a single note in the application.
///
/// Contains the note's title, content, timestamp, and color tag.
class Note {
  /// Unique identifier for the note.
  final String id;

  /// Title of the note.
  final String title;

  /// Content/body of the note.
  final String content;

  /// Timestamp when the note was created.
  final DateTime createdAt;

  /// Timestamp when the note was last modified.
  final DateTime updatedAt;

  /// Color tag for the note (stored as hex value).
  final int colorValue;

  /// Creates a new Note instance.
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.colorValue,
  });

  /// Returns the Color object from the stored hex value.
  Color get color => Color(colorValue);

  /// Creates a copy of this Note with the given fields replaced.
  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? colorValue,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  /// Converts the Note to a Map for serialization.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'colorValue': colorValue,
    };
  }

  /// Creates a Note from a Map (deserialization).
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      colorValue: map['colorValue'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.colorValue == colorValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        colorValue.hashCode;
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, createdAt: $createdAt, colorValue: $colorValue)';
  }
}
