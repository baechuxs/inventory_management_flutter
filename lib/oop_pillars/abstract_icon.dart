import 'package:flutter/material.dart';

abstract class IconType {
  IconData getIcon();
}

class IconIn extends IconType {
  @override
  IconData getIcon() {
    return Icons.arrow_upward;
  }
}

class IconOut extends IconType {
  @override
  IconData getIcon() {
    return Icons.arrow_downward;
  }
}

class IconUpdate extends IconType {
  @override
  IconData getIcon() {
    return Icons.update;
  }
}

class IconDashboard extends IconType {
  @override
  IconData getIcon() {
    return Icons.dashboard_sharp;
  }
}

class IconList extends IconType {
  @override
  IconData getIcon() {
    return Icons.list;
  }
}

class TotalProduct extends IconType {
  @override
  IconData getIcon() {
    return Icons.present_to_all_outlined;
  }
}

class TotalStock extends IconType {
  @override
  IconData getIcon() {
    return Icons.warehouse_outlined;
  }
}

class ProductValue extends IconType {
  @override
  IconData getIcon() {
    return Icons.attach_money_outlined;
  }
}

class StockValue extends IconType {
  @override
  IconData getIcon() {
    return Icons.monetization_on_outlined;
  }
}
