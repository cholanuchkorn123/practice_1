class Product {
  late String name;
  static final Product _instance = Product._internal();
  factory Product({name}) {
    _instance.name = name;
    return _instance;
  }
  Product._internal();
}
