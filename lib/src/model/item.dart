class Item {
  String name;
  double price;
  double taxRate;
  bool includeTax;

  // These will be calculated
  double calculatedPrice;
  double total;
  double hoursNeeded;

  Item(
      {this.name = "",
      this.price = 0.0,
      this.taxRate = 0.0,
      this.includeTax = false}) {
    // TODO: This is the same logic as in the calculator_bloc.dart file
    calculatedPrice = double.parse(
        (price * (includeTax ? ((taxRate / 100) + 1) : 1))
            .toStringAsPrecision(5));
    hoursNeeded = double.parse((calculatedPrice / 20.0).toStringAsPrecision(3));
  }
}
