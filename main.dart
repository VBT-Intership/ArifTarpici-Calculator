import 'dart:io';

void main() {
  print("************* Welcome To Calculator *************");
  var continuation = "y";
  var result;
  bool firstWorkOfCalculater = true;
  IOperation _operation;
  do {
    print("Enter Number");
    var countOne = int.parse(stdin.readLineSync());

    print("---------- Operations ----------");
    print("1-) Addition");
    print("2-) Substraction");
    print("3-) Multiplication");
    print("4-) Division");

    var process = stdin.readLineSync();
    stdout.write("------------------------------\nSelected Operation :" +
        process +
        "\n");

    // only work once if block
    checkFirstWorkOrNot(firstWorkOfCalculater, process, result);
    // only work once if block

    print("Enter Number");
    var countTwo = int.parse(stdin.readLineSync());

    switch (process) {
      case "1":
        _operation = new Addition(countOne, countTwo);
        result = _operation.Processor();
        break;
      case "2":
        _operation = new Substraction(countOne, countTwo);
        result = _operation.Processor();
        break;
      case "3":
        _operation = new Multiplication(countOne, countTwo);
        result = _operation.Processor();
        break;
      case "4":
        try {
          _operation = new Division(countOne, countTwo);
          result = _operation.Processor();
        } on VBTIntegerDoesNotDivisionByZeroException catch (e) {
          print("\n" + e.errorNessage());
          continue;
        }
        break;
      case "5":
        continuation = "n";
        break;
      default:
        print("Invalid Operation");
        break;
    }

    print("\n" +
        _operation.OperationName +
        " Calculation Result: " +
        result.toString());
    print("\nDo You Want To Continue? (y/n): ");
    continuation = stdin.readLineSync();
  } while (continuation == "y");
}

// interface for operators
class IOperation {
  String OperationName;
  int countOne;
  int countTwo;
  int Processor() {}
}
// interface for operators

// operator classes
class Addition implements IOperation {
  @override
  String OperationName = "Addition";
  @override
  int countOne;
  @override
  int countTwo;

  Addition(_countOne, _countTwo) {
    this.countOne = _countOne;
    this.countTwo = _countTwo;
  }

  @override
  int Processor() {
    return this.countOne + this.countTwo;
  }
}

class Substraction implements IOperation {
  @override
  String OperationName = "Substraction";
  @override
  int countOne;
  @override
  int countTwo;

  Substraction(_countOne, _countTwo) {
    this.countOne = _countOne;
    this.countTwo = _countTwo;
  }

  @override
  int Processor() {
    return this.countOne - this.countTwo;
  }
}

class Multiplication implements IOperation {
  @override
  String OperationName = "Multiplication";
  @override
  int countOne;
  @override
  int countTwo;

  Multiplication(_countOne, _countTwo) {
    this.countOne = _countOne;
    this.countTwo = _countTwo;
  }

  @override
  int Processor() {
    return this.countOne * this.countTwo;
  }
}

class Division implements IOperation {
  @override
  String OperationName = "Division";
  @override
  int countOne;
  @override
  int countTwo;

  Division(_countOne, _countTwo) {
    this.countOne = _countOne;
    this.countTwo = _countTwo;
  }

  @override
  int Processor() {
    if (countTwo == 0) {
      throw new VBTIntegerDoesNotDivisionByZeroException();
    } else {
      return (this.countOne / this.countTwo).round();
    }
  }
}
// operator classes

// only work once function block
checkFirstWorkOrNot(firstWorkOfCalculater, process, result) {
  if (firstWorkOfCalculater) {
    if (process == "1" || process == "2") {
      result = 0;
    } else if (process == "3" || process == "4") {
      result = 1;
    }
    firstWorkOfCalculater = false;
  }
}
// only work once function block

// custom exception
class VBTIntegerDoesNotDivisionByZeroException implements Exception {
  String errorNessage() => "A Divide By 0 Error Occurred VBT";
}
// custom exception
