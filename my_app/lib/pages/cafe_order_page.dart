import 'package:flutter/material.dart';
import 'package:my_app/components/my_button.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/models/cafe_item.dart';
import 'package:provider/provider.dart';

class CafeOrderPage extends StatefulWidget {
  final CafeItem item;
  final String cafeName;
  const CafeOrderPage({super.key, required this.item, required this.cafeName});

  @override
  State<CafeOrderPage> createState() => _CafeOrderPageState();
}

class _CafeOrderPageState extends State<CafeOrderPage> {
  // Quantity of order
  int quantity = 1;

  // Extra shot selection
  bool extraShot = false;

  // Current size selection
  Size selectedSize = Size.small;

  // Current type selection
  Type selectedType = Type.cappuccino;

  // Current milk selection
  Milk selectedMilk = Milk.fullCream;

  // Increment quantity
  void increment() {
    setState(() {
      if (quantity < 10) {
        quantity++;
      }
    });
  }

  // Decrement quantity
  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  // Select extra shot
  void toggleExtraShot(bool? value) {
    setState(() {
      extraShot = value ?? false;
      widget.item.extraShot = extraShot;
    });
  }

  // Select size
  void selectSize(Size size) {
    setState(() {
      selectedSize = size;
      widget.item.size = size;
    });
  }

  // Select type
  void selectType(Type type) {
    setState(() {
      selectedType = type;
      widget.item.type = type;
    });
  }

  // Select milk
  void selectMilk(Milk milk) {
    setState(() {
      selectedMilk = milk;
      widget.item.milk = milk;
    });
  }

  // Add to cart
  void addToCart() {
    if (quantity > 0) {
      Provider.of<Cafe>(context, listen: false).addItemToCart(widget.item, quantity);
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          backgroundColor: Colors.brown,
          title: Text(
            "Successfully added to cart",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          "${widget.cafeName} Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[900],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    widget.item.imagePath,
                    height: 120,
                  ),
                ),
                const SizedBox(height: 20),

                if (widget.item.isCoffee) ...[
                  buildOptionSection(
                    "Extra Shot?",
                    "\$0.70",
                    Checkbox(
                      value: extraShot,
                      onChanged: toggleExtraShot,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildOptionSection(
                    "Size",
                    null,
                    Column(
                      children: [
                        buildCheckbox("Small", selectedSize == Size.small, () => selectSize(Size.small), "\$0.00"),
                        buildCheckbox("Regular", selectedSize == Size.regular, () => selectSize(Size.regular), "\$0.50"),
                        buildCheckbox("Large", selectedSize == Size.large, () => selectSize(Size.large), "\$1.00"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildOptionSection(
                    "Type",
                    null,
                    Column(
                      children: [
                        buildCheckbox("Cappuccino", selectedType == Type.cappuccino, () => selectType(Type.cappuccino), "\$0.00"),
                        buildCheckbox("Long Black", selectedType == Type.longBlack, () => selectType(Type.longBlack), "\$0.00"),
                        buildCheckbox("Short Black", selectedType == Type.shortBlack, () => selectType(Type.shortBlack), "\$0.00"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildOptionSection(
                    "Milk",
                    null,
                    Column(
                      children: [
                        buildCheckbox("Full Cream", selectedMilk == Milk.fullCream, () => selectMilk(Milk.fullCream), "\$0.00"),
                        buildCheckbox("Skim Milk", selectedMilk == Milk.skimMilk, () => selectMilk(Milk.skimMilk), "\$0.00"),
                        buildCheckbox("Oat Milk", selectedMilk == Milk.oatMilk, () => selectMilk(Milk.oatMilk), "\$1.00"),
                        buildCheckbox("Almond Milk", selectedMilk == Milk.almondMilk, () => selectMilk(Milk.almondMilk), "\$1.00"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: decrement,
                            icon: const Icon(Icons.remove),
                            color: Colors.grey,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 60,
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                quantity.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[800],
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: increment,
                            icon: const Icon(Icons.add),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '\$${(widget.item.price * quantity).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        text: "Add to cart",
                        onTap: addToCart,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOptionSection(String title, String? price, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (price != null) ...[
              const SizedBox(width: 10),
              Text(price),
            ],
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  Widget buildCheckbox(String label, bool isSelected, VoidCallback onTap, String price) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (bool? value) => onTap(),
              ),
              Text(label),
            ],
          ),
          Text(price),
        ],
      ),
    );
  }
}
