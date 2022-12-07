import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kbbi_app/home/home.dart';
import 'package:kbbi_app/l10n/l10n.dart';
import 'package:web_scraper/web_scraper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Center(child: HomeContent()),
    );
  }
}

class HomeContent extends StatelessWidget {
  HomeContent({super.key});

  final TextEditingController controller = TextEditingController();
  final webScraper = WebScraper('https://kbbi.kemdikbud.go.id');

  Future<void> fetchProducts(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (await webScraper.loadWebPage('/entri/${controller.text}')) {
      final results = webScraper.getElementTitle('ol > li').isEmpty
          ? webScraper.getElementTitle('ul.adjusted-par > li')
          : webScraper.getElementTitle('ol > li');
      debugPrint(results.toString());
      context.read<HomeCubit>().setResult(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((HomeCubit cubit) => cubit.state);
    var word = '';
    var titleVisible = false;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Masukkan Teks',
              contentPadding: EdgeInsets.all(10),
            ),
            onChanged: (value) {
              word = value;
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            titleVisible = !titleVisible;
            fetchProducts(context);
          },
          child: const Text('Cari Arti'),
        ),
        const SizedBox(
          height: 20,
        ),
        if (titleVisible)
          Text(
            'Arti dari $word',
            style: const TextStyle(
              fontSize: 20,
            ),
          )
        else
          const SizedBox(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: count.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Text(count[index], style: theme.textTheme.bodyMedium),
            );
          },
        ),
      ],
    );
  }
}

// TODO(mkhoirulwafa): Manipulate result response with more explanative
class ResultText extends StatelessWidget {
  const ResultText({super.key, required this.word});
  final String word;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [Text(word.substring(0))],
      ),
    );
  }
}
