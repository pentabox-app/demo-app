import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/sub_category.dart';
import 'package:untitled1/view_model/mian_view_model.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category List",
          style: TextStyle(color: Colors.white), // White text
        ),
        backgroundColor: Colors.black, // Black background
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list), // Filter icon
            onPressed: () {
              // Implement filter functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.search), // Search icon
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category list (horizontal ListViewBuilder)
          Flexible(
            child: Container(
              height: 60,
              color: Colors.black,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.categories.length,
                itemBuilder: (context, index) {
                  final category = viewModel.categories[index];
                  return GestureDetector(
                    onTap: () async {
                      await viewModel.fetchSubCategory(category.id);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(category.name,style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  );
                },
              ),
            ),
          ),

          // Product list (conditional rendering based on subCategories)
          Flexible(
            flex: 4,
            child: Container(

              child: viewModel.subCategories?.result?.category.isNotEmpty == true
                  ? RefreshIndicator(
                onRefresh: () => viewModel.fetchCategories(),
                child: ListView.builder(
                  // Remove scroll behavior
                   // Avoids extra empty space
                  itemCount: viewModel.subCategories!.result?.category[0].subCategories?.length,
                  itemBuilder: (context, categoryIndex) {
                    final category = viewModel.subCategories?.result?.category[0].subCategories?[categoryIndex];
                    return buildSubCategory(category!, viewModel);
                  },
                ),
              )
                  : Center(child: Text('No subcategories found')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        viewModel.fetchCategories();

      },
      child: Icon(Icons.refresh),),
    );
  }

  Widget buildSubCategory(SubCategory category, CategoryViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display category name
          Text(
            "  ${category.name}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5), // Add some spacing

          // Nested ListViewBuilder for products (if subCategories exist)
          SizedBox(
            height: 150, // Adjust height as needed for products
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // Remove trailing empty space by adjusting itemCount
              itemCount: category.product?.length ?? 0, // Handle null case
              itemBuilder: (context, productIndex) {
                if (productIndex >= category.product!.length) return Container(); // Avoid out-of-bounds access
                final product = category.product![productIndex];
                return _buildProductItem(product); // Call product item builder
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0), // Add rounded corners
        ),
        child: Stack(
          children: [
            // Display image (assuming you have a 'imageUrl' property in your Product model)
            if (product.imageName != null)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Match container corners
                  child: Image.network(
                    product.imageName!,
                    fit: BoxFit.cover, // Adjust image fit as needed
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Icon(Icons.error)), // Handle image loading errors
                  ),
                ),
              ),

            // Product name positioned at the bottom
            Positioned(
              bottom: 10.0, // Adjust positioning as needed
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                color: Colors.black.withOpacity(0.5), // Semi-transparent background
                child: Text(
                  product.name ?? "", // Handle case where name might be null
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                  maxLines: 1, // Wrap long names to one line
                  overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

