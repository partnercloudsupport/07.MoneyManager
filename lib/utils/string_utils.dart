/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.
bool isValidEmail(String email) {
  if (email == null) return false;

  return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))'
  r'@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(email);
}

bool isValidPassword(String password) {
  return password != null && password.isNotEmpty;
}

String toMoney(int value) {
  var result = "";
  if(value.toString().length <= 3) {
    return value.toString();
  }

  var temp = 0;
  var lastIndex = 0;
  while(temp * 3  < value.toString().length) {
    if(temp == 0) {
      var dif = value.toString().length - value.toString().length ~/ 3 * 3;
      lastIndex = dif == 0 ? 3 : dif;
      result += value.toString().substring(0, lastIndex) + ",";
    } else {
      result += value.toString().substring(lastIndex, lastIndex + 3) + ((lastIndex + 3 < value.toString().length) ? "," : '');
      lastIndex = lastIndex + 3;
    }
    temp++;
  }

  return result.isEmpty ? value.toString() : result.replaceFirst('-,', '-');
}

int inputtedValue(String inputtedString) {
  var inputted = inputtedString.replaceAll(',', '').split(RegExp(r"(\W+)"))
    .where((element) => element.isNotEmpty).toList();
  var inputtedSign = inputtedString.replaceAll(',', '').split(RegExp(r"(\w+)"))
    .where((element) => element.isNotEmpty).toList();

  if(inputtedString.startsWith('-')) {
    // Remove wrong '-' sign from first value.
    inputtedSign.removeAt(0);
  }

  int value = int.parse(inputted[0]) * (inputtedString.startsWith('-') ? -1 : 1);

  if(inputted.length > 1) {
    if((inputtedSign.contains(' × ') || inputtedSign.contains(' ÷ ')) && inputtedSign.length < inputted.length) {
      for(int index = 0; index < inputtedSign.length; index++) {
        if(inputtedSign[index] == ' × ') {
          inputtedSign.removeAt(index);
          String _before = inputted.removeAt(index);
          String _after = inputted.removeAt(index);
          String _counted = (int.parse(_before) * int.parse(_after)).toString();

          inputted.insert(index, _counted);
        } else if(inputtedSign[index] == ' ÷ ') {
          inputtedSign.removeAt(index);
          String _before = inputted.removeAt(index);
          String _after = inputted.removeAt(index);
          String _counted = (int.parse(_before) ~/ int.parse(_after)).toString();

          inputted.insert(index, _counted);
        }
      }

      // Re-create new string
      String _newText = '';
      for(var index = 0; index < inputted.length; index++) {
        if(index == 0) {
          _newText += toMoney(int.parse(inputted[0]) * (inputtedString.startsWith('-') ? -1 : 1));
        } else {
          _newText += toMoney(int.parse(inputted[index]));
        }
        if(index < inputtedSign.length) {
          _newText += inputtedSign[index];
        }
      }

      return inputtedValue(_newText);
    }
    for(var valueIndex = 1; valueIndex < inputted.length; valueIndex++) {
      var signIndex = valueIndex - 1;
      if(signIndex < inputtedSign.length ) {
        if(inputtedSign[signIndex].trim() == '+') {
          value += int.parse(inputted[valueIndex]);
        } else if(inputtedSign[signIndex].trim() == '-') {
          value -= int.parse(inputted[valueIndex]);
        }
      }
    }
  }

  return value;
}