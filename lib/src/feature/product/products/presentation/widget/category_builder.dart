part of '../pages/products_list_page.dart';

class _CategoryBuilder extends ConsumerWidget {
  const _CategoryBuilder({
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ).copyWith(left: 16),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (ref.watch(selectedCategoryProvider) == categories[index]) {
                ref.read(selectedCategoryProvider.notifier).state = "";
                return;
              }
              ref.read(selectedCategoryProvider.notifier).state =
                  categories[index];
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: ref.watch(selectedCategoryProvider) == categories[index]
                    ? Border.all(color: Theme.of(context).primaryColor)
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  categories[index].toUpperCase(),
                  style: TextStyle(
                    color:
                        ref.watch(selectedCategoryProvider) == categories[index]
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
