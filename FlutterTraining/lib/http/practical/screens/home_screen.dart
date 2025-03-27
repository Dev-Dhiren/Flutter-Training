import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/http/practical/models/category.dart';
import 'package:flutter_training/http/practical/models/products.dart';
import 'package:flutter_training/http/practical/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _service = ApiService();

  List<Categories> categories = [];
  List<Products> products = [];
  bool isLoading = true;
  int offset = 0;
  int limit = 20;

  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _fetchCategoriesAndProducts();
  }

  _buildCategories() {
    if (categories.isEmpty) {
      return Text('No Categories found');
    } else {
      return SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            Categories category = categories[index];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade100,
                  backgroundImage: NetworkImage(category.image!),
                ),
                /*CachedNetworkImage(
                  imageUrl: category.image!,
                  height: 50,
                  width: 50,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),*/
                SizedBox(height: 6),
                Text('${category.name}'),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 10);
          },
        ),
      );
    }
  }

  _buildProducts() {
    if (products.isEmpty) {
      return Text('No Product found');
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Products product = products[index];

          return Container(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: product.images![0],
                    height: 50,
                    width: 50,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${product.title}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Rs. ${product.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${product.description}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
        itemCount: products.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 16),
                        // add categories
                        _buildCategories(),
                        SizedBox(height: 16),
                        Text(
                          'Products',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildProducts(),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  _fetchCategoriesAndProducts() async {
    /*var categories = await _service.getCategories();
    var products = await _service.getProducts();
   */

    final categoryFuture = _service.getCategories().then((categories) {
      this.categories = categories;
      print('categories : ${categories}');
    });

    final productFuture = _service
        .getProducts(offset: offset, limit: limit)
        .then((products) {
          this.products = products;
          print('products : ${products}');
        });

    await Future.wait([categoryFuture, productFuture]);

    setState(() {
      isLoading = false;
    });
  }
}
