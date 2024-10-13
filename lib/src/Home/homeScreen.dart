import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  final List<Product> products = List.generate(
    20,
    (index) => Product(
      name: 'Product $index',
      price: 10.0 + index,
      imageUrl: 'https://via.placeholder.com/150',
      discount: index % 2 == 0 ? 10 : 0,
    ),
  );

  late AnimationController _controller;
  late Animation<Offset> _carouselFadeAnimation;
  late Animation<Offset> _gridFadeAnimation;

  ScrollController _scrollController = ScrollController();
  bool _showSlider = true;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for fade-up effect
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // Separate animations for carousel and grid
    _carouselFadeAnimation = Tween<Offset>(
            begin: Offset(0, 0.3), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _gridFadeAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation
    _controller.forward();

    // Listen to scroll controller
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _showSlider = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showSlider = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background color for the screen
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Products'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Carousel Slider with Fade-Up Animation
          _showSlider
              ? SlideTransition(
                  position:
                      _carouselFadeAnimation, // Apply the separate carousel animation
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: ['Item 1', 'Item 2'].map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                )
              : Container(),

          // Product Grid with Fade-Up Animation
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    controller:
                        _scrollController, // Attach the scroll controller
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return SlideTransition(
                        position:
                            _gridFadeAnimation, // Apply separate grid animation
                        child: ProductCard(product: products[index]),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Product Model
class Product {
  final String name;
  final double price;
  final String imageUrl;
  final int discount;

  Product(
      {required this.name,
      required this.price,
      required this.imageUrl,
      required this.discount});
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(product.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),

                  // Product Price and Discount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${product.price}',
                          style: TextStyle(fontSize: 14, color: Colors.green)),
                      if (product.discount > 0)
                        Text('${product.discount}% OFF',
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
