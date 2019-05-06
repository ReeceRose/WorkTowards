import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CalculatorBloc {
  double _price = 0.0;
  bool _includeTax = true;
  double _taxRate = 1;
  double _calculatedPrice = 0.0;
  double _hoursNeeded = 0.0;

  BehaviorSubject _calculatorController;
  BehaviorSubject<double> _priceController;
  BehaviorSubject<bool> _includeTaxController;
  BehaviorSubject<double> _taxRateController;
  BehaviorSubject<double> _calculatedPriceController;
  BehaviorSubject<double> _hoursNeededController;

  CalculatorBloc() {
    _calculatorController = BehaviorSubject();
    _priceController = BehaviorSubject<double>.seeded(this._price);
    _includeTaxController = BehaviorSubject<bool>.seeded(this._includeTax);
    _taxRateController = BehaviorSubject<double>.seeded(this._taxRate);
    _calculatedPriceController =
        BehaviorSubject<double>.seeded(this._calculatedPrice);
    _hoursNeededController = BehaviorSubject<double>.seeded(this._hoursNeeded);
  }

  Observable get calculatorStream$ => _calculatorController.stream;
  Observable get priceStream$ => _priceController.stream;
  Observable get includeTaxStream$ => _includeTaxController.stream;
  Observable get taxRateStream$ => _taxRateController.stream;
  Observable get calculatedPriceStream$ => _calculatedPriceController.stream;
  Observable get hoursNeededStream$ => _hoursNeededController.stream;

  double get currentPrice => _priceController.value;
  bool get includeTax => _includeTaxController.value;
  double get currentTaxRate => _taxRateController.value;
  double get calculatedPrice => _calculatedPriceController.value;
  double get hoursNeeded => _hoursNeededController.value;

  set currentPrice(double price) {
    _price = price;
    _priceController.add(_price);
    this.calculatePrice();
  }

  set includeTax(bool includeTax) {
    _includeTax = includeTax;
    _includeTaxController.add(_includeTax);
    this.calculatePrice();
  }

  set currentTaxRate(double taxRate) {
    print(taxRate);
    _taxRate = taxRate;
    _taxRateController.add(_taxRate);
    this.calculatePrice();
  }

  set calculatedPrice(double calculatedPrice) {
    _calculatedPrice = calculatedPrice;
    _calculatedPriceController.add(_calculatedPrice);
  }

  set hoursNeeded(double hoursNeeded) {
    _hoursNeeded = hoursNeeded;
    _hoursNeededController.add(_hoursNeeded);
  }

  void calculatePrice() {
    calculatedPrice = double.parse(
        (_price * (_includeTax ? ((_taxRate / 100) + 1) : 1)).toStringAsPrecision(5));
    hoursNeeded =
        double.parse((_calculatedPrice / 20.0).toStringAsPrecision(3));
  }

  dispose() {
    _calculatorController.close();
    _priceController.close();
    _includeTaxController.close();
    _taxRateController.close();
    _calculatedPriceController.close();
  }
}
