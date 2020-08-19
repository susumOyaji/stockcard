import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  static final list_Items = "list_items";
  static final completed_Items = "completed_items";

  static final code_Items = "code_items";
  static final stock_Items = "stock_items";
  static final value_Items = "value_items";
  static final acquiredAssets_Items = "acquiredAssets_Items";
  static final valuableAssets_Items = "valuableAssets_Items";

  static SharedPreferences _sharedPreferences;

  static Future setInstance() async {
    if (null != _sharedPreferences) return;

    _sharedPreferences = await SharedPreferences.getInstance();
/*
    _sharedPreferences.remove(list_Items);
    _sharedPreferences.remove(completed_Items);
    _sharedPreferences.remove(code_Items);
    _sharedPreferences.remove(stock_Items);
    _sharedPreferences.remove(value_Items);
    */
  }

  ///
  static Future<bool> setCodeItems(List<String> value) =>
      _sharedPreferences.setStringList(code_Items, value);
  static Future<bool> setStockItems(List<String> value) =>
      _sharedPreferences.setStringList(stock_Items, value);
  static Future<bool> setValueItems(List<String> value) =>
      _sharedPreferences.setStringList(value_Items, value);
  static Future<bool> setacquiredAssetsItems(List<String> value) =>
      _sharedPreferences.setStringList(acquiredAssets_Items, value);
  static Future<bool> setvaluableAssetsItems(List<String> value) =>
      _sharedPreferences.setStringList(valuableAssets_Items, value);

  static List<String> getCodeItems() =>
      _sharedPreferences.getStringList(code_Items) ?? [];
  static List<String> getStockItems() =>
      _sharedPreferences.getStringList(stock_Items) ?? [];
  static List<String> getValueItems() =>
      _sharedPreferences.getStringList(value_Items) ?? [];
  static List<String> getacquiredAssetsItems() =>
      _sharedPreferences.getStringList(acquiredAssets_Items) ?? [];
  static List<String> getvaluableAssetsItems() =>
      _sharedPreferences.getStringList(valuableAssets_Items) ?? [];

  ///

}
