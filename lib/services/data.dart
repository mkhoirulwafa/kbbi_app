import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kbbi_app/modules/home/cubit/home_cubit.dart';
import 'package:web_scraper/web_scraper.dart';

class KBBI {
  final webScraper = WebScraper('https://kbbi.kemdikbud.go.id');

  Future<void> fetchMeaning(BuildContext context, String text) async {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<HomeCubit>().setResult([]);

    if (await webScraper.loadWebPage('/entri/$text')) {
      final results = webScraper.getElementTitle('ol > li').isEmpty
          ? webScraper.getElementTitle('ul.adjusted-par > li')
          : webScraper.getElementTitle('ol > li');
      context.read<HomeCubit>().setResult(results);
    }
  }
}
