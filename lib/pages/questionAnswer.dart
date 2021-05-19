import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/answer.dart';

class QuestionAnswerPage extends StatefulWidget {
  @override
  _QuestionAnswerPageState createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  // Text editing controller for text field
  TextEditingController _questionFieldController = TextEditingController();

  // Store the current answer object
  String? _url;
  String? _gifText;
  bool _problem = false;
  //Problem catcher

  //Handler of getting yes or non response process
  Future _handlerGetAnswer() async {
    String questionText = _questionFieldController.text.replaceAll(' ', '');

    if (questionText == null ||
        questionText.length == 0 ||
        questionText[questionText.length - 1] != '?') {
      AlertDialog(
        title: Text("!!ALERT!!"),
        content: Text("Please ask a valid question."),
      );
      setState(() {
        _problem = true;
      });
      return '';
    }
    try {
      http.Response response =
          await http.get(Uri.parse("https://yesno.wtf/api"));
      if (response.statusCode == 200 && response.body != null) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        Answer answer = Answer.fromMap(responseBody);

        setState(() {
          _problem = false;
          _url = answer.image;
          _gifText = answer.answer;
        });
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
  }

  _handleResetOperation() {
    _questionFieldController.text = '';
    setState(() {
      _url = null;
      _gifText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('I Know Everithing'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange.shade800,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_problem == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black38),
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Please ask a valid question",
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                        ))),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          if (_url != null && _problem != true)
            Container(
              height: 250,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image: NetworkImage(_url!))),
              child: Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _gifText!.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ))),
            ),
          if (_url != null && _problem != true)
            SizedBox(
              height: 30,
            ),
          Container(
            width: 0.4 * MediaQuery.of(context).size.width,
            child: TextField(
              controller: _questionFieldController,
              decoration: InputDecoration(
                labelText: 'Ask a question',
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                border: OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(
                    'Get Answer',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  onPressed: _handlerGetAnswer,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.white),
                  ))),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  child: Text(
                    'Clear',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  onPressed: _handleResetOperation,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.white, width: 1),
                  ))),
                )
              ])
        ],
      ),
    );
  }
}
