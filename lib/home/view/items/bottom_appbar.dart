import 'package:flutter/material.dart';
import 'package:kbbi_app/services/data.dart';

import 'package:kbbi_app/utils/colors.dart';

class BottomAppbarContent extends StatelessWidget with PreferredSizeWidget {
  BottomAppbarContent({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: controller,
                maxLength: 150,
                cursorColor: HexColor.fromHex('#f28482'),
                cursorHeight: 20,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Teks',
                  counter: Offstage(),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Color(0xfff7ede2),
                  focusColor: Color(0xfff7ede2),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Color(0xfff7ede2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Color(0xfff7ede2)),
                  ),
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                KBBI().fetchMeaning(context, controller.text);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      HexColor.fromHex('#f7ede2'),),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      HexColor.fromHex('#000000'),),
              ),
              child: const Text('Cari Arti'),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(160);
}
