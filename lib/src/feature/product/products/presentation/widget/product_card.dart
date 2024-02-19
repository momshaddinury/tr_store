part of '../pages/products_list_page.dart';

class _ProductCard extends ConsumerWidget {
  const _ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ProductEntity data = ref.read(productDataProvider);

    final checkIfProductIsInCart =
        ref.watch(checkIfProductIsInCartProvider(data.id));

    return GestureDetector(
      onTap: () {
        _navigateToProductDetailsPage(context, data.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: data.image,
                cacheKey: data.image,
                fit: BoxFit.contain,
                height: 100,
                width: 100,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  CategoryPill(category: data.category),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${data.price}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () {
                          if (!checkIfProductIsInCart) {
                            ref.read(cartProvider.notifier).addItem(data);
                          }
                        },
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: checkIfProductIsInCart
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).primaryColor,
                        ),
                      ),
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

  void _navigateToProductDetailsPage(
    BuildContext context,
    int id,
  ) {
    context.goNamed(
      Routes.productDetails,
      queryParameters: <String, String>{
        'id': id.toString(),
      },
    );
  }
}
