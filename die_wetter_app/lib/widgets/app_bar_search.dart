import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  const AppBarSearch({super.key, this.onChanged});

  final TextChangeCallback onChanged;

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _AppBarSearchState extends State<AppBarSearch> {
  bool isSearch = false;
  var _text = '';
  final _searchTextController = TextEditingController();

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _searchTextController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 95,
      title: isSearch
          ? AppBarTextField(textController: _searchTextController)
          : const AppBarTitle(),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => setState(() {
            isSearch = !isSearch;
          }),
          icon: Icon(isSearch ? Icons.close : Icons.search),
        )
      ],
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Die Wetter App');
  }
}

typedef TextChangeCallback = void Function(dynamic)?;

class AppBarTextField extends StatelessWidget {
  const AppBarTextField(
      {super.key, required this.textController, this.error, this.onChanged});

  final TextEditingController textController;

  final String? error;

  final TextChangeCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        onChanged: onChanged,
        controller: textController,
        decoration: InputDecoration(
            errorText: error,
            prefixIcon: const Icon(
              Icons.search,
            ),
            hintText: 'Search...',
            filled: true,
            fillColor: const Color.fromARGB(116, 255, 255, 255),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
      suggestionsCallback: (pattern) async {
        return ['Stuttgart', 'Pforzheim', 'Reutlingen'];
      },
      hideOnEmpty: true,
      itemBuilder: (context, suggestion) {
        return Text(suggestion);
      },
      onSuggestionSelected: (suggestion) {
        //Provider add und validieren
      },
    );

    /*
    TextField(
      onChanged: onChanged,
      controller: textController,
      decoration: InputDecoration(
          errorText: error,
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: 'Search...',
          filled: true,
          fillColor: const Color.fromARGB(116, 255, 255, 255),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
    );
    */
  }
}
