const String collectionProduct = 'Products';
const String productFieldId = 'productId';
const String productFieldName = 'productName';
const String productFieldCategory = 'productCategory';
const String productFieldShortDescription = 'productShortDescription';
const String productFieldLongDescription = 'productLongDescription';
const String productFieldSalePrice = 'productSalePrice';
const String productFieldStock = 'productStock';
const String productFieldDiscount = 'productDiscount';
const String productFieldThumbnailImageUrl = 'productThumbnailImageUrl';
const String productFieldAdditonalImages = 'productAdditonalImages';
const String productFieldAvailable = 'productAvailable';
const String productFieldFeatured = 'productFeatured';

class ProductModel {
  String? productId;
  String productName;
  String category;
  String? shortDescription;
  String? longDescription;
  num salePrice;
  num stock;
  num productDiscount;
  String thumbnailImageUrl;
  List<String>? additonalImages;
  bool available;
  bool featured;

  ProductModel({
    this.productId,
    required this.productName,
    required this.category,
    this.shortDescription,
    this.longDescription,
    required this.salePrice,
    required this.stock,
    required this.productDiscount,
    required this.thumbnailImageUrl,
    this.additonalImages,
    this.available = true,
    this.featured = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      productFieldId: productId,
      productFieldName: productName,
      productFieldCategory: category,
      productFieldShortDescription: shortDescription,
      productFieldLongDescription: longDescription,
      productFieldSalePrice: salePrice,
      productFieldStock: stock,
      productFieldDiscount: productDiscount,
      productFieldThumbnailImageUrl: thumbnailImageUrl,
      productFieldAdditonalImages: additonalImages,
      productFieldAvailable: available,
      productFieldFeatured: featured,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
    productId: map[productFieldId],
    productName: map[productFieldName],
    category: map[productFieldCategory],
    shortDescription: map[productFieldShortDescription],
    longDescription: map[productFieldLongDescription],
    salePrice: map[productFieldSalePrice],
    stock: map[productFieldStock],
    productDiscount: map[productFieldDiscount],
    thumbnailImageUrl: map[productFieldThumbnailImageUrl],
    additonalImages: map[productFieldAdditonalImages] != null ?
    map[productFieldAdditonalImages] as List<String> : null,
    available: map[productFieldAvailable],
    featured: map[productFieldFeatured],
  );
}
