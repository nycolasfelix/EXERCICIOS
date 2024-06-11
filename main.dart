import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Comidas',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FoodListScreen(),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final List<FoodItem> _foodItems = [
    FoodItem(name: 'Pizza', price: 20.0),
    FoodItem(name: 'Hambúrguer', price: 15.0),
    FoodItem(name: 'Sushi', price: 25.0),
    FoodItem(name: 'Salada', price: 10.0),
    FoodItem(name: 'Sorvete', price: 5.0),
  ];

  final Set<FoodItem> _selectedItems = {};

  void _toggleSelection(FoodItem item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  double _calculateTotal() {
    return _selectedItems.fold(0.0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Comidas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _foodItems.length,
              itemBuilder: (context, index) {
                final item = _foodItems[index];
                final isSelected = _selectedItems.contains(item);

                return ListTile(
                  title: Text(item.name),
                  trailing: Text('R\$ ${item.price.toStringAsFixed(2)}'),
                  tileColor: isSelected ? Colors.green[100] : null,
                  onTap: () => _toggleSelection(item),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: R\$ ${_calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItem {
  final String name;
  final double price;

  FoodItem({required this.name, required this.price});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price;

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}
