// clearing 1 thing at a time,                        //done
// i.e. to make _displayInpTxt from _inpTxt
// remove extra point (decimal) in answer
// to make ! and % to work properly
// implement 2nd                                      //done
// implement deg functionality
import './inptxt_to_display.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import './eval_postfix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(
            color: const Color.fromARGB(255, 108, 19, 209)),
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({@required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _inpTxt = '';
  String _displayInpTxt = '';
  String _baseTxt = '';
  String _ans = '';
  bool _extended = false;
  bool _2nd = true;
  bool _equated = true;
  bool _operatorUsed = false;
  double _firstOperand;
  double _secondOperand;

  Map<String, Object> identifier_Icon = {
    'XX': Icon(Icons.backspace_outlined),
    'icon': Icon(Icons.science_sharp),
  };

  Map<String, String> keys_extended = {
    '2nd': 'i',
    'deg': 'd',
    'sin': 's',
    'cos': 'c',
    'tan': 't',
    'x^y': '^',
    'lg': 'L',
    'ln': 'l',
    '(': '(',
    ')': ')',
    'sqr(x)': 'q',
    'C': 'C',
    'XX': 'c',
    '%': '%',
    '/': '/',
    'X!': 'f',
    '7': '7',
    '8': '8',
    '9': '9',
    'x': '*',
    '1/x': 'r',
    '4': '4',
    '5': '5',
    '6': '6',
    '-': '-',
    'π': 'p',
    '1': '1',
    '2': '2',
    '3': '3',
    '+': '+',
    'icon': 'icon',
    'e': 'e',
    '0': '0',
    '.': '.',
    '=': '=',
  };

  Map<String, String> keys_extended_2nd = {
    '2nd': 'i',
    'deg': 'd',
    'asin': 'n',
    'acos': 'o',
    'atan': 'a',
    'x^y': '^',
    'lg': 'L',
    'ln': 'l',
    '(': '(',
    ')': ')',
    'sqr(x)': 'q',
    'C': 'C',
    'XX': 'c',
    '%': '%',
    '/': '/',
    'X!': 'f',
    '7': '7',
    '8': '8',
    '9': '9',
    'x': '*',
    '1/x': 'r',
    '4': '4',
    '5': '5',
    '6': '6',
    '-': '-',
    'π': 'p',
    '1': '1',
    '2': '2',
    '3': '3',
    '+': '+',
    'icon': 'icon',
    'e': 'e',
    '0': '0',
    '.': '.',
    '=': '=',
  };

  Map<String, String> keys_ = {
    'C': 'C',
    'XX': 'c',
    '%': '%',
    '/': '/',
    '7': '7',
    '8': '8',
    '9': '9',
    'x': '*',
    '4': '4',
    '5': '5',
    '6': '6',
    '-': '-',
    '1': '1',
    '2': '2',
    '3': '3',
    '+': '+',
    'icon': 'icon',
    '0': '0',
    '.': '.',
    '=': '=',
  };

  void onTap(String identifier) {
    // else if ([
    //   'sin',
    //   'cos',
    //   'tan',
    //   'lg',
    //   'ln',
    // ].contains(identifier)) {
    //   setState(() {
    //     // _displayInpTxt = _displayInpTxt + identifier + '(';
    //     if (_extended)
    //       _inpTxt = _inpTxt + keys_extended[identifier] + '(';
    //     else
    //       _inpTxt = _inpTxt + keys_[identifier] + '(';
    //   });
    // }
    if (identifier == 'C') {
      setState(() {
        _inpTxt = '';
        // _displayInpTxt = '';
        _ans = '';
      });
    } else if (identifier == 'XX') {
      setState(() {
        if (_inpTxt.length > 0) {
          _inpTxt = _inpTxt.substring(0, _inpTxt.length - 1);
        }
        // if (_displayInpTxt.length > 0) {
        //   _displayInpTxt =
        //       _displayInpTxt.substring(0, _displayInpTxt.length - 1);
        // }
        // _displayInpTxt = '';
        _ans = '';
      });
    } else if (identifier == '2nd') {
      setState(() {
        _2nd = !_2nd;
      });
    } else if (identifier == 'icon') {
      setState(() {
        _extended = !_extended;
      });
    } else if (identifier == '=') {
      var ans = getAnsFromString(_baseTxt);
      setState(() {
        _ans = ans.toString();
      });
    } else if (_2nd
        ? keys_extended_2nd.keys.contains(identifier)
        : keys_extended.keys.contains(identifier)) {
      setState(() {
        // _displayInpTxt = _displayInpTxt + identifier;
        if (_extended)
          _2nd
              ? _inpTxt = _inpTxt + keys_extended_2nd[identifier]
              : _inpTxt = _inpTxt + keys_extended[identifier];
        else
          _inpTxt = _inpTxt + keys_[identifier];
      });
    } else {}
    setState(() {
      _displayInpTxt = inpTxtToDisplay(_inpTxt);
      _baseTxt = inpTxtToBaseTxt(_inpTxt);
    });
  }

   PreferredSizeWidget _buildAppBar(Widget title) {
    return AppBar(title: title,);
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = _buildAppBar(Text(widget.title));
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // textbox('display: ${_displayInpTxt}'),
            // textbox('BaseTxt: ${_baseTxt}'),
            textbox(_displayInpTxt),
            SizedBox(height: 5),
            textbox(_ans),
            SizedBox(height: 5),
            // child: GridView.count(
            //   crossAxisCount: 4,
            //   children: [
            //     ...keys
            //         .map((e) => SizedBox(
            //               height: 30,
            //               child: TextButton(
            //                 style: ButtonStyle(
            //                     tapTargetSize:
            //                         MaterialTapTargetSize.shrinkWrap),
            //                 onPressed: () {},
            //                 child: Text(e),
            //               ),
            //             ))
            //         .toList(),
            //   ],
            // ),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
              child: GridUnScrollable(
                height: ((mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) - 70*2 - 5*2 - 25).toDouble(),
                crossAxisCount: _extended ? 5 : 4,
                children: _extended
                    ? _2nd
                        ? keys_extended_2nd.keys
                            .toList()
                            .map(
                              (e) => FlatButton(
                                onTap: () {
                                  onTap(e);
                                },
                                identifier: e,
                                child: (identifier_Icon.keys.contains(e))
                                    ? identifier_Icon[e]
                                    : Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            )
                            .toList()
                        : keys_extended.keys
                            .toList()
                            .map(
                              (e) => FlatButton(
                                onTap: () {
                                  onTap(e);
                                },
                                identifier: e,
                                child: (identifier_Icon.keys.contains(e))
                                    ? identifier_Icon[e]
                                    : Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            )
                            .toList()
                    : keys_.keys
                        .toList()
                        .map(
                          (e) => FlatButton(
                            onTap: () {
                              onTap(e);
                            },
                            identifier: e,
                            child: (identifier_Icon.keys.contains(e))
                                ? identifier_Icon[e]
                                : Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        )
                        .toList(),
              ),
            ),
            // buttons
          ],
        ),
      ),
    );
  }

  Container textbox(String txt) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(
        width: 2,
      )),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            txt,
            style: TextStyle(fontSize: 30),
          )),
    );
  }
}

class GridUnScrollable extends StatelessWidget {
  final double height;
  final int crossAxisCount;
  final List<Widget> children;

  GridUnScrollable({
    @required this.height,
    @required this.crossAxisCount,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> allRows = [];
    if (children != null) {
      int noOfRows = ((children.length) / crossAxisCount).ceil();
      for (int i = 0; i < noOfRows; i++) {
        if (i == noOfRows - 1) {
          allRows.insert(
              i,
              Expanded(
                  child: Row(
                children: [
                  ...children
                      .sublist(i * crossAxisCount, children.length)
                      .map((e) => Expanded(child: e))
                      .toList()
                ],
              )));
        } else {
          allRows.insert(
              i,
              Expanded(
                child: Row(
                  children: [
                    ...children
                        .sublist(i * crossAxisCount, (i + 1) * crossAxisCount)
                        .map((e) => Expanded(child: e))
                        .toList()
                  ],
                ),
              ));
        }
      }
    }
    return Container(
      height: height,
      child: Column(
        children: allRows,
      ),
    );
  }
}

class FlatButton extends StatelessWidget {
  final Widget child;
  final String identifier;
  final void Function() onTap;

  FlatButton({
    this.child,
    this.identifier,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
      ),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Color.fromARGB(151, 127, 53, 212),
        onTap: onTap,
        child: Align(child: child),
      ),
    );
  }
}
