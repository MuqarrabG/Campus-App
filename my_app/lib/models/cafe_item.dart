enum Size {
  small,
  regular,
  large
}

enum Type {
  cappuccino,
  longBlack,
  shortBlack,
  latte
}

enum Milk {
  fullCream,
  skimMilk,
  oatMilk,
  almondMilk
}

class CafeItem {
  final String name;
  final String imagePath;
  final bool isCoffee;
  final double basePrice;
  double _price;
  bool _extraShot;
  Milk _milk;
  Size _size; // Private size variable
  Type _type;

  CafeItem({
    required this.name,
    required this.basePrice,
    required this.imagePath,
    required this.isCoffee,
    bool extraShot = false,
    Size size = Size.small,
    Type type = Type.cappuccino,
    Milk milk = Milk.fullCream
  })  : _price = basePrice,
        _size = size,
        _type = type,
        _milk = milk,
        _extraShot = extraShot;

  // Getter for size
  Size get size => _size;

  // Getter for type
  Type get type => _type;

  // Getter for milk
  Milk get milk => _milk;

  // Getter for extra shot
  bool get extraShot => _extraShot;

  // Setter for size
  set size(Size newSize) {
    if (_size != newSize) {
      _price = _calculatePrice(newSize, _milk, _extraShot);
      _size = newSize;
    }
  }

  // Setter for type
  set type(Type newType) {
    if (_type != newType) {
      _type = newType;
    }
  }

  // Setter for milk
  set milk(Milk newMilk) {
    if (_milk != newMilk) {
      _price = _calculatePrice(_size, newMilk, _extraShot);
      _milk = newMilk;
    }
  }

  // Setter for extra shot
  set extraShot(bool newShot) {
    if (_extraShot != newShot) {
      _price = _calculatePrice(_size, _milk, newShot);
      _extraShot = newShot;
    }
  }

  // Getter for price
  double get price => _price;

  // Calculate the price based on the size, milk, and extra shot
  double _calculatePrice(Size size, Milk milk, bool extraShot) {
    double price = basePrice;

    // Adjust price based on size
    switch (size) {
      case Size.small:
        price += 0.00; // No change for small size
        break;
      case Size.regular:
        price += 0.50;
        break;
      case Size.large:
        price += 1.00;
        break;
    }

    // Adjust price based on milk
    switch (milk) {
      case Milk.almondMilk:
      case Milk.oatMilk:
        price += 1.00;
        break;
      default:
        break;
    }

    // Adjust price for extra shot
    if (extraShot) {
      price += 0.70;
    }

    return price;
  }

  // Convert a CafeItem into a Map. The keys must correspond to the names of the
  // fields in the JSON object.
  Map<String, dynamic> toJson() => {
        'name': name,
        'imagePath': imagePath,
        'isCoffee': isCoffee,
        'basePrice': basePrice,
        'price': _price,
        'extraShot': _extraShot,
        'milk': _milk.toString().split('.').last,
        'size': _size.toString().split('.').last,
        'type': _type.toString().split('.').last,
      };

  // Convert a Map into a CafeItem. The keys must correspond to the names of the
  // fields in the JSON object.
  factory CafeItem.fromJson(Map<String, dynamic> json) {
    return CafeItem(
      name: json['name'],
      basePrice: json['basePrice'],
      imagePath: json['imagePath'],
      isCoffee: json['isCoffee'],
      extraShot: json['extraShot'],
      size: Size.values.firstWhere((e) => e.toString() == 'Size.' + json['size']),
      type: Type.values.firstWhere((e) => e.toString() == 'Type.' + json['type']),
      milk: Milk.values.firstWhere((e) => e.toString() == 'Milk.' + json['milk']),
    );
  }
}