import 'package:flutter/material.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/widgets/alert.dart';

class TriviaPage extends StatefulWidget {
  final String pageTitle;
  const TriviaPage({Key? key, required this.pageTitle}) : super(key: key);

  @override
  _TriviaPageState createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  int? _selectedOption;
  bool _answered = false;
  final String question = "Aşağıdaki ifadelerden hangisi yanlıştır?";
  final List<String> _options = [
    "Stateless Widget kullanarak elementler üzerinde dinamik değişiklikler yapılabilir.",
    "Stateless Widget önceden atanmış olan verileri kullanır.",
    "Stateful Widget, widget'ın yenilenmesini sağlar.",
    "Her şey bir Widget'tır.",
  ];
  final List<bool> _isCorrect = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            for (int i = 0; i < _options.length; i++)
              InkWell(
                onTap: !_answered
                    ? () {
                  showSnackbar(context, "Stateles widgetı sadece üzerindeki verileri değiştirmeyeceğin sayfalar için kullanmalısın!");
                  setState(() {
                    _selectedOption = i;
                    _answered = true;
                  });
                }
                    : null,
                child: buildTile(_options[i], i),
              ),
          ],
        ),
      ),
    );
  }

  Container buildTile(String option, int index) {
    Color? tileColor;
    if (_answered) {
      if (_selectedOption == index && !_isCorrect[index]) {
        tileColor = AppColors.red;
      } else if (_isCorrect[index]) {
        tileColor = AppColors.green;
      }
    }

    return Container(
      margin: (index < _options.length - 1) ? const EdgeInsets.only(bottom: 10) : null,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: tileColor ?? AppColors.grey,
        borderRadius: (index == 0)
            ? const BorderRadius.only(topRight: Radius.circular(100))
            : (index == _options.length - 1)
            ? const BorderRadius.only(bottomLeft: Radius.circular(100))
            : null,
      ),
      child: Text(
        option,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
