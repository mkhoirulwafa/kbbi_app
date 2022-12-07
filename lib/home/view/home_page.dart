import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kbbi_app/home/home.dart';
import 'package:kbbi_app/home/view/items/bottom_appbar.dart';
import 'package:kbbi_app/utils/colors.dart';

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
    return Scaffold(
      backgroundColor: HexColor.fromHex('#f7ede2'),
      appBar: AppBar(
        title: const Text(
          'KBBI',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: HexColor.fromHex('#f28482'),
        foregroundColor: HexColor.fromHex('#000000'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        bottom: BottomAppbarContent(),
      ),
      body: const Center(child: HomeContent()),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final meanings = context.select((HomeCubit cubit) => cubit.state);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        if (meanings.isEmpty)
          const CircularProgressIndicator(
            color: Color(0xfff28482),
          )
        else
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: meanings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    meanings[index],
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ),
        const SizedBox(
          height: 20,
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
