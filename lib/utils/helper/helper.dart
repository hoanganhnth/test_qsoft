import 'package:shopping_cart/utils/constants/size_constants.dart';

class Helper {
  static double caculateWidthCardHorizontal(double numberCardRow,
      {double paddingLeft = 16, double marginCard = 16}) {
    return (SizeConstants.widthSize -
            marginCard * numberCardRow.toInt() -
            paddingLeft) /
        numberCardRow;
  }

  static double caculateWidthCardHorizontalFull(int numberCardRow,
      {double padding = 16, double marginCard = 16}) {
    return (SizeConstants.widthSize -
            (numberCardRow - 1) * marginCard -
            padding * 2) /
        numberCardRow;
  }

  static String formatPrice(double price, String currency) {
    return "${price.toStringAsFixed(2)} $currency";
  }
}
