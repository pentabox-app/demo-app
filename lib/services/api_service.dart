import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/sub_category.dart';

import '../model/category_model.dart';

class ApiService {
  static const String _baseUrl = 'http://esptiles.imperoserver.in/api/API/Product/DashBoard';

  Future<Categorys> fetchCategories(int pageIndex) async {
    print("main category aagainystsfsdfdsfsf");
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'CategoryId': 0,
        'DeviceManufacturer': 'Google',
        'DeviceModel': 'Android SDK built for x86',
        'DeviceToken': ' ',
        'PageIndex': pageIndex,
      }),
    );

    if (response.statusCode == 200) {
      return Categorys.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }
  Future<SbCategory> fetchSubCategory(int categoryId) async {
    final response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
        ,
        body: jsonEncode(<String, dynamic>{
          'CategoryId':categoryId,
          'PageIndex':2
        }));

    if(response.statusCode == 200){
      var data = SbCategory.fromJson(jsonDecode(response.body.toString()));

      print("run successfully ${data.result?.toJson()}" );
      return data;
    }
    else{

      throw Exception('Failed to load categories');

    }
  }
  Future<Products> fetchProduct(int? sbCategoryId) async{
    var response = await http.post(Uri.parse("http://esptiles.imperoserver.in/api/API/Product/ProductList"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
        ,
        body: jsonEncode(<String, dynamic>{

          'PageIndex':2,
          'SubCategoryId':sbCategoryId
        })
    );
    if(response.statusCode == 200){
      var data = Products.fromJson(jsonDecode(response.body.toString()));

      return data;
    }
    else{
      throw Exception('Failed to load categories');
    }

  }
}
