import 'package:flutter/material.dart';

class PageBuilder<T> extends StatelessWidget {
  const PageBuilder({super.key, required this.title, required this.possibilities, required this.onChoiceMade, required this.nextPage});

  final String title;
  final Map<String, T> possibilities;
  final void Function(T selected) onChoiceMade;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center),
                Card(
                    color: const Color(0xffc5f08b),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                          spacing: 30,
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            for(final possibility in possibilities.keys)
                              TextButton(
                                  onPressed: () {
                                    debugPrint('Pressed $possibility');
                                    onChoiceMade(possibilities[possibility] as T);
                                    nextPage();
                                  },
                                  child: Text(possibility,
                                      style: Theme.of(context).textTheme
                                          .displaySmall?.copyWith(color: Theme.of(context)
                                          .textButtonTheme.style?.textStyle?.resolve({})?.color))
                              )]),
                    ))
              ]),
        ),
      ),
    );
  }
}
