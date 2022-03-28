import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../utility.dart';

class Agreements extends StatelessWidget {
  Agreements({Key? key}) : super(key: key);
  final Utility _utility = Utility();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final children = <Widget>[];

    for (var i = 0; i < 10; i++) {
      children.add(Text(
        'BantuPay Wallet Terms of Use',
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
      ));
      children.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.5),
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            textAlign: TextAlign.justify,
            style: _utility.getTextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w400),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F4F4),
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFFF7F4F4),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.5),
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              ...children,
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    print('I am summoned');
                    appState.currentAction = PageAction(state: PageState.pop);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300.0, 33.0),
                    primary: Colors.orange[800],
                    padding: const EdgeInsets.all(0),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Accept Terms and Conditions',
                    style: _utility.getTextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
