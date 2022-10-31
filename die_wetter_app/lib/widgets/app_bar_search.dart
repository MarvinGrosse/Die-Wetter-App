import 'package:die_wetter_app/pages/home_screen/home_provider.dart';
import 'package:die_wetter_app/services/cities_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  const AppBarSearch({
    super.key,
  });

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _AppBarSearchState extends State<AppBarSearch> {
  @override
  void initState() {
    isSearch = false;
    super.initState();
  }

  bool isSearch = false;
  final _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 95,
      title: isSearch
          ? AppBarTextField(
              textController: _searchTextController,
              callback: () {
                setState(() {
                  isSearch = false;
                });
              },
            )
          : const AppBarTitle(),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => setState(() {
            isSearch = !isSearch;
            _searchTextController.clear();
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

typedef ResetTextStateCallback = Function();

class AppBarTextField extends ConsumerWidget {
  const AppBarTextField(
      {super.key, required this.textController, required this.callback});

  final TextEditingController textController;

  final ResetTextStateCallback callback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggetionsServiceProvider = ref.read(citiesProvider);

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        controller: textController,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
          ),
          hintText: 'Search...',
          filled: true,
          fillColor: Color.fromARGB(116, 255, 255, 255),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return suggetionsServiceProvider.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return Container(
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
          //height: 56,
          child: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            dense: true,
            title: Text(suggestion.name!),
            subtitle: Text(suggestion.country!),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        ref.read(homeProvider.notifier).addLocation(suggestion);
        callback();
      },
    );
  }
}
