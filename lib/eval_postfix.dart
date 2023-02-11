import 'dart:io';
import 'dart:math';

import 'package:stack/stack.dart';
import './extra_math.dart';

bool isOperand(String c) {
  if (c == '+' ||
      c == '-' ||
      c == '*' ||
      c == '/' ||
      c == '^' ||
      c == '(' ||
      c == ')' ||
      c == '%' ||
      c == 'L' ||
      c == 'l' ||
      c == 's' ||
      c == 'c' ||
      c == 't' ||
      c == 'd' ||
      c == 'q' ||
      c == 'f' ||
      c == 'n' ||
      c == 'o' ||
      c == 'a' ||
      c == 'r') {
    return false;
  } else {
    return true;
  }
}

int outStackPrecedenceOperandor(Operandor c) {
  if (c.operator_val == '+' || c.operator_val == '-')
    return 1;
  else if (c.operator_val == '*' || c.operator_val == '/')
    return 3;
  else if (c.operator_val == '^')
    return 6;
  else if (c.operator_val == 'L' ||
      c.operator_val == 'l' ||
      c.operator_val == 's' ||
      c.operator_val == 'c' ||
      c.operator_val == 't' ||
      c.operator_val == 'd' ||
      c.operator_val == 'q' ||
      c.operator_val == 'f' ||
      c.operator_val == 'n' ||
      c.operator_val == 'o' ||
      c.operator_val == 'a' ||
      c.operator_val == 'r'
      )
    return 8;
  else if (c.operator_val == '(')
    return 10;
  else if (c.operator_val == ')')
    return 0;
  else
    return 0;
}

int inStackPrecedenceOperandor(Operandor c) {
  if (c.operator_val == '+' || c.operator_val == '-')
    return 2;
  else if (c.operator_val == '*' || c.operator_val == '/')
    return 4;
  else if (c.operator_val == '^')
    return 5;
  else if (c.operator_val == 'L' ||
      c.operator_val == 'l' ||
      c.operator_val == 's' ||
      c.operator_val == 'c' ||
      c.operator_val == 't' ||
      c.operator_val == 'd' ||
      c.operator_val == 'q' ||
      c.operator_val == 'n' ||
      c.operator_val == 'o' ||
      c.operator_val == 'a' ||
      c.operator_val == 'r')
    return 9;
  else if (c.operator_val == 'f')
    return 7;
  else if (c.operator_val == '(')
    return 0;
  else
    return 0;
}

StringOfOperandors infixToPostfixOperandors(StringOfOperandors infix) {
  Stack<Operandor> st = Stack();
  StringOfOperandors postfix = StringOfOperandors.fromString('');
  int i = 0;
  while (i != infix.length) {
    if (infix.at(i).isOperand) {
      postfix.insertAtEnd(infix.at(i));
      // postfix = postfix + infix.at(i);
      i++;
    } else {
      if (st.isEmpty) {
        // if (infix.at(i).operator_val != '(' && infix.at(i).operator_val != ')')
        if (infix.at(i).operator_val != ')') st.push(infix.at(i));
        i++;
      } else if (outStackPrecedenceOperandor(infix.at(i)) >
          inStackPrecedenceOperandor(st.top())) {
        st.push(infix.at(i));
        i++;
      } else {
        if (st.top().operator_val != '(')
          postfix.insertAtEnd(st.pop());
        else
          st.pop();
        // postfix = postfix + st.pop();
      }
    }
  }
  while (!st.isEmpty) {
    postfix.insertAtEnd(st.pop());
    // postfix = postfix + st.pop();
  }
  return postfix;
}

int unaryOrBinary(String c) {
  if (['+', '-', '*', '/', '^', '(', ')'].contains(c)) {
    return 2;
  } else if ([
    's',
    'c',
    't',
    'L',
    'l',
    'q',
    'f',
    'r',
    'n',
    'o',
    'a',
    '%',
  ].contains(c)) {
    return 1;
  } else
    return 0;
}

class Operandor {
  bool isOperand;
  double double_val;
  String operator_val;
  int unaryOrBinary;

  String toString() {
    if (isOperand) {
      return double_val.toString();
    } else {
      return operator_val;
    }
  }

  Operandor(
      {this.isOperand, this.double_val, this.operator_val, this.unaryOrBinary});
}

class StringOfOperandors {
  List<Operandor> value = [];
  StringOfOperandors(this.value);
  StringOfOperandors.fromString(String str) {
    int i = 0;
    bool at_exp_start = true;
    Operandor component = Operandor(
        isOperand: true, double_val: 0, operator_val: '', unaryOrBinary: 0);
    String double_val_str = '';
    while (i != str.length) {
      if (str[i] == ' ') {
        i++;
      } else if (isOperand(str[i])) {
        component = Operandor(
            isOperand: true,
            double_val: component.double_val,
            operator_val: '',
            unaryOrBinary: 0);
        double_val_str = double_val_str + str[i];
        component.double_val = double.parse(double_val_str);
        // print("double value is ${component.double_val}");
        i++;
        if (i == str.length) {
          value.add(component);
        }
      } else {
        if (str[i] == '(') {
        } else if (component.operator_val == ')') {
        } else if (str[i] == 'f' || str[i] == '%') {
          value.add(component);
        } else if (unaryOrBinary(str[i]) == 1) {
        } else {
          value.add(component);
        }
        double_val_str = '';
        component = Operandor(
            isOperand: false,
            double_val: 0,
            operator_val: str[i],
            unaryOrBinary: unaryOrBinary(str[i]));
        value.add(component);
        i++;
        at_exp_start = false;
      }
    }
  }

  void insertAtEnd(Operandor item) {
    value.add(item);
  }

  int get length {
    return value.length;
  }

  Operandor at(int idx) {
    return value[idx];
  }

  void display() {
    for (Operandor i in value) {
      if (i.isOperand) {
        stdout.write("${i.double_val} ");
      } else if (!i.isOperand) {
        stdout.write("${i.operator_val} ");
      }
    }
  }
}

double evalPostfix(StringOfOperandors postfix) {
  Stack<double> st = Stack();

  double operand_1, operand_2, result;

  for (int i = 0; i != postfix.length; i++) {
    // print("Stack is :");
    // st.print();
    if (postfix.at(i).isOperand) {
      st.push(postfix.at(i).double_val);
    } else if (postfix.at(i).unaryOrBinary == 2) {
      operand_2 = st.pop();
      operand_1 = st.pop();
      switch (postfix.at(i).operator_val) {
        case '+':
          result = operand_1 + operand_2;
          st.push(result);
          break;

        case '-':
          result = operand_1 - operand_2;
          st.push(result);
          break;

        case '*':
          result = operand_1 * operand_2;
          st.push(result);
          break;

        case '/':
          result = operand_1 / operand_2;
          st.push(result);
          break;

        case '^':
          result = pow(operand_1, operand_2);
          st.push(result);
          break;

        default:
          break;
      }
    } else if (postfix.at(i).unaryOrBinary == 1) {
      operand_2 = st.pop();
      switch (postfix.at(i).operator_val) {
        case 'L':
          result = log(operand_2) / log(10);
          st.push(result);
          break;
        case 'l':
          result = log(operand_2);
          st.push(result);
          break;

        case 's':
          result = sin(operand_2);
          st.push(result);
          break;

        case 'c':
          result = cos(operand_2);
          st.push(result);
          break;

        case 't':
          result = tan(operand_2);
          st.push(result);
          break;

        case 'q':
          result = sqrt(operand_2);
          st.push(result);
          break;

        case 'f':
          result = double.parse(factorial(operand_2.toInt()).toString());
          st.push(result);
          break;

        case 'r':
          result = 1 / operand_2;
          st.push(result);
          break;

        case 'n':
          result = asin(operand_2);
          st.push(result);
          break;

        case 'o':
          result = acos(operand_2);
          st.push(result);
          break;

        case 'a':
          result = atan(operand_2);
          st.push(result);
          break;

        case '%':
          result = operand_2 / 100;
          st.push(result);
          break;

        default:
          break;
      }
    }
  }

  return st.pop();
}

double getAnsFromString(String expression) {
  StringOfOperandors exp_operandors = StringOfOperandors.fromString(expression);
  StringOfOperandors postfix_exp_operandors =
      infixToPostfixOperandors(exp_operandors);
  return evalPostfix(postfix_exp_operandors);
}

void main() {
  StringOfOperandors infix = StringOfOperandors.fromString('56%%');

  // var str = '((21+29)*5)-3^2';
  // var str = '5f';

  // print(getAnsFromString(str));

  infix.display();
  print("");
  var postfix = infixToPostfixOperandors(infix);
  postfix.display();
  print('');
  print(evalPostfix(postfix));
  // print(infixToPostfix(infix));
}
