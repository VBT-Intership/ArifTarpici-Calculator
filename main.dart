import 'dart:io';

void main() {
  print("************* Hesap Makinesine Hoşgeldiniz *************");
  var continuation = "y";
  var result;
  bool firstWorkOfCalculater = true;
  IOperation _operation;
  do {
    print("Sayı Giriniz");
    var countOne = int.parse(stdin.readLineSync());

    print("---------- İşlemler ----------");
    print("1-) Toplama");
    print("2-) Çıkarma");
    print("3-) Çarpma");
    print("4-) Bölme");

    var process = stdin.readLineSync();
    stdout.write(
        "------------------------------\nSeçilen İşlem :" + process + "\n");

    // only work once if block
    checkFirstWorkOrNot(firstWorkOfCalculater, process, result);
    // only work once if block

    print("Sayı Giriniz");
    var countTwo = int.parse(stdin.readLineSync());

    switch (process) {
      case "1":
        _operation = new Addition(countOne, countTwo);
        result = _operation.Processor();
        break;
      case "2":
        _operation = new Substract(countOne, countTwo);
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
        print("Geçersiz İşlem");
        break;
    }

    print("\n" +
        _operation.OperationName +
        " Hesaplaması Sonucu: " +
        result.toString());
    print("\nDevam Etmek İstiyor Musunuz? (y/n): ");
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
  String OperationName = "Toplama";
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

class Substract implements IOperation {
  @override
  String OperationName = "Çıkarma";
  @override
  int countOne;
  @override
  int countTwo;

  Substract(_countOne, _countTwo) {
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
  String OperationName = "Çarpma";
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
  String OperationName = "Bölme";
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
  String errorNessage() => "0'a Bölünme Hatası Oluştu VBT";
}
// custom exception
