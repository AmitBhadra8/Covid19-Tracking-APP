import 'dart:convert';

import 'package:covid_tracking_app/model/worldStatesmodel.dart';
import 'package:covid_tracking_app/services/Utilitites/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesServices {

  Future<WorldStatesmodel> fetchWorldStatesRecords () async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStatesmodel.fromJson(data);
    } else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countrieslistapi () async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200) {

      data = jsonDecode(response.body);
      return data;

    } else{
      throw Exception('Error');
    }
  }
}