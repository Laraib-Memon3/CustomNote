import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../providers/notes_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/note_card.dart';
import 'note_editor_screen.dart';

/// Main home screen displaying the list of notes.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load notes when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesProvider>().loadNotes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        context.read<NotesProvider>().clearSearch();
      }
    });
  }

  void _onSearchChanged(String query) {
    context.read<NotesProvider>().setSearchQuery(query);
  }

  void _navigateToEditor({String? noteId}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(noteId: noteId),
      ),
    );
  }

  void _showDeleteDialog(String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.deleteNote),
        content: const Text(AppStrings.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () {
              context.read<NotesProvider>().deleteNote(noteId);
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching ? _buildSearchAppBar() : _buildNormalAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEditor(),
        tooltip: AppStrings.newNote,
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildNormalAppBar() {
    return CustomAppBar(
      title: AppStrings.appName,
      showSearch: true,
      showThemeToggle: true,
      onSearchTap: _toggleSearch,
    );
  }

  PreferredSizeWidget _buildSearchAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _toggleSearch,
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: AppStrings.searchNotes,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor?.withOpacity(0.6),
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
        onChanged: _onSearchChanged,
      ),
      actions: [
        if (_searchController.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _onSearchChanged('');
            },
          ),
      ],
    );
  }

  Widget _buildBody() {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, child) {
        if (notesProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final notes = notesProvider.filteredNotes;

        if (notes.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteCard(
              note: note,
              onTap: () => _navigateToEditor(noteId: note.id),
              onLongPress: () => _showDeleteDialog(note.id),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final isSearching = context.read<NotesProvider>().searchQuery.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearching ? Icons.search_off : Icons.note_add_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            Text(
              isSearching ? AppStrings.noNotesFound : AppStrings.noNotes,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
