enum Category { book, kitchen, stationery, electronic }

var _categoryStrings = Map.fromIterable(Category.values,
    key: (category) => category.toString(), value: (category) => category);

Category getCategoryFromString(String categoryStr) {
  return _categoryStrings[categoryStr];
}
