import 'dart:math';

String inpTxtToDisplay(String inpTxt) {
  Map<String, String> inp_display = {
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    '0': '0',
    '+': '+',
    '-': '-',
    '/': '/',
    '.': '.',
    'e': 'e',
    '%': '%',
    '^': '^',
    'p': 'π',
    '(': '(',
    ')': ')',
    '*': 'x',
    'L': 'log',
    'l': 'ln',
    's': 'sin',
    'c': 'cos',
    't': 'tan',
    'q': 'sqrt',
    'f': '!',
    'r': '1/',
    'n': 'asin',
    'o': 'acos',
    'a': 'atan',
  };
  String displayTxt = '';
  for (int i = 0; i < inpTxt.length; i++) {
    displayTxt = displayTxt + inp_display[inpTxt[i]];
  }
  return displayTxt;
}

String inpTxtToBaseTxt(String inpTxt) {
  Map<String, String> inp_display = {
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    '0': '0',
    '+': '+',
    '-': '-',
    '/': '/',
    '.': '.',
    'e': e.toString(),
    '%': '%',
    '^': '^',
    'p': pi.toString(),
    '(': '(',
    ')': ')',
    '*': '*',
    'L': 'L',
    'l': 'l',
    's': 's',
    'c': 'c',
    't': 't',
    'q': 'q',
    'f': 'f',
    'r': 'r',
    'n': 'n',
    'o': 'o',
    'a': 'a',
  };

  String baseTxt = '';

  for (int i = 0; i < inpTxt.length; i++) {
    baseTxt = baseTxt + inp_display[inpTxt[i]];
  }

  return baseTxt;
}
