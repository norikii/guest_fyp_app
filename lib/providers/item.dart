import 'dart:ffi';



class Item {
  String id;
  String itemName;
  String itemDescription;
  String itemType;
  String itemImage;
  double itemPrice;
  int estimatePrepareTime;
  int createdAt;
  int updatedAt;
  int deletedAt;

  Item({
      this.id,
      this.itemName,
      this.itemDescription,
      this.itemType,
      this.itemImage,
      this.itemPrice,
      this.estimatePrepareTime,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});
}