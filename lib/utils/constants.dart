const String firebaseStorageProductImageDir = 'ProductImages';
const String currencySymbol = '৳';
const String serverKey = 'AAAAEB3kOrU:APA91bG5c9G3BoNe4OXrwep0T6Vgu2Jk16-Qhv9hmEFr97DuiOwwgQrXD3osw-of-3zIqs7u3PARHUAiY6rY1TeGJLq11xcft-XzyQElZqV-sGdVEX6Lu4ZA4SrCEjfGNRRuv26iLoWd';

abstract class OrderStatus{
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
  static const String returned = 'Returned';
}

abstract class NotificationType{
  static const String comment = 'New Comment';
  static const String order = 'New Order';
  static const String user = 'New User';
}