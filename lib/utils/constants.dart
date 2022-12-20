const String firebaseStorageProductImageDir = 'ProductImages';
const String currencySymbol = '৳';

abstract class OrderStatus{
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
  static const String returned = 'Returned';
}