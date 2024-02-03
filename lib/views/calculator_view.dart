import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// CalculatorView: Stateful widget representing the main calculator screen.
class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

// _CalculatorViewState: State class for CalculatorView.
class _CalculatorViewState extends State<CalculatorView> {
  // Variables to store numeric values and result.
  int x = 0;
  int y = 0;
  num z = 0;

  // Controllers for the text fields.
  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();

  // Listener for app lifecycle events.
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    // Initialize text field values.
    displayOneController.text = x.toString();
    displayTwoController.text = y.toString();

    // Initialize AppLifecycleListener.
    _listener = AppLifecycleListener(
      onDetach: _onDetach,
      onHide: _onHide,
      onResume: _onResume,
      onShow: _onShow,
      onRestart: _onRestart,
      onInactive: _onInactive,
      onPause: _onPause,
      onStateChange: _onStateChange,
    );
  }

  // App lifecycle event handlers with print statements.
  void _onShow() => print('OnShow Called');

  void _onHide() => print('_onHide Called');

  void _onDetach() => print('_onDetach Called');

  void _onResume() => print('onResume Called');

  void _onRestart() => print('onRestart Called');

  void _onInactive() => print('onInactive Called');

  void _onPause() => print('onPause Called');

  void _onStateChange(AppLifecycleState state) =>
      print(' _onStateChange Called: $state');

  @override
  void dispose() {
    // Dispose of controllers and listener.
    displayOneController.dispose();
    displayTwoController.dispose();
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: [
          // DisplayViews for entering numeric values.
          DisplayView(
              hint: 'Enter First num', controller: displayOneController),
          SizedBox(height: 15),
          DisplayView(
              hint: 'Enter Second num', controller: displayTwoController),

          // Display result.
          Text(
            z.toString(),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),

          Spacer(),

          // Row of operation buttons.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      z = (num.tryParse(displayOneController.text)!) +
                          (num.tryParse(displayTwoController.text)!);
                    });
                  },
                  child: Icon(Icons.add)),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      z = (num.tryParse(displayOneController.text)!) -
                          (num.tryParse(displayTwoController.text)!);
                    });
                  },
                  child: const Icon(CupertinoIcons.minus)),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      z = (num.tryParse(displayOneController.text)!) *
                          (num.tryParse(displayTwoController.text)!);
                    });
                  },
                  child: Icon(CupertinoIcons.multiply)),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      z = (num.tryParse(displayOneController.text)!) /
                          (num.tryParse(displayTwoController.text)!);
                    });
                  },
                  child: Icon(CupertinoIcons.divide)),
              FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      x = 0;
                      y = 0;
                      z = 0;
                      displayOneController.clear();
                      displayTwoController.clear();
                    });
                  },
                  label: const Text('Clear'))
            ],
          ),
        ],
      ),
    );
  }
}

// DisplayView: Stateless widget representing a text field for numeric input.
class DisplayView extends StatelessWidget {
  const DisplayView(
      {super.key, this.hint = "Enter a number", required this.controller});

  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 5.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hint ?? 'Enter a number',
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
