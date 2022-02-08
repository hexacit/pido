import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/age_categories_response.dart';
import 'package:pido/src/models/api_models/responses/areas_response.dart';
import 'package:pido/src/models/api_models/responses/countries_response.dart';
import 'package:pido/src/models/api_models/responses/education_enviroment_response.dart';
import 'package:pido/src/models/sub_models/exception.dart';
import 'package:pido/src/models/sub_models/settings.dart';
import 'package:pido/src/services/dio_service.dart';
import 'package:dio/dio.dart';
import '../../models/api_models/responses/cities_response.dart';
import '../../models/api_models/responses/settings_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class ConfigsController {
  static  ConfigsController? _instance;
 // =ConfigsController();

  // ||.. private constructor ..||
 ConfigsController._();

 // ||.. singleton pattern ..||
  static ConfigsController? get instance {
    if (_instance != null) return _instance;
    return _instance = ConfigsController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

//   ||.. get app settings ..||
  Future<BaseResponse> getSettings() async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getSetting');
    print(jsonResponse);

    BaseResponse response =
    BaseResponse.fromJson(jsonResponse,dataKey: 'settings');
            
    return response;
  }


  //   ||.. get cities ..||
  Future<CitiesResponse> getCities() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getCities',
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
                    'Accept':'application/json',

        },
      ),
    );
     if(response.data['code']==202)
    throw ApiException(response.data['message'], 202);
    CitiesResponse citiesResponse = CitiesResponse.fromJson(response.data);
         
    return citiesResponse;
  }

  Future<BaseResponse> getAreas() async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getAreas');
    print(jsonResponse);

    BaseResponse response =
    BaseResponse.fromJson(jsonResponse,dataKey: 'items');

    return response;
        
  }
  Future<BaseResponse> getAges() async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getAges');
    print(jsonResponse);

    BaseResponse response =
    BaseResponse.fromJson(jsonResponse,dataKey: 'items');

    return response;

  }
  Future<BaseResponse> getPage(int id) async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('pages/$id');
    print(jsonResponse);

    BaseResponse response =
    BaseResponse.fromJson(jsonResponse,dataKey: 'page');

    return response;

  }
  Future<BaseResponse> getFaq() async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getFaq');
    print(jsonResponse);

    BaseResponse response =
    BaseResponse.fromJson(jsonResponse,dataKey: 'items');

    return response;

  }
  Future<String> getCurrentDateTime() async {

    print('getCurrentDateTime ');


    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('date-time');
    print('getCurrentDateTime  $jsonResponse');
    String date =jsonResponse['data']['current_date'];

    return date;
  }
  Future<BaseResponse> getCountries() async {

    print('getCountries ');


    final Map<String, dynamic> jsonResponse = await ApiProvider.instance!.post('secure/countries',{});
    print('getCountries  $jsonResponse');
    BaseResponse countriesResponse = BaseResponse.fromJson(jsonResponse,dataKey: 'data');


    return countriesResponse;
  }
  Future<Map<String, dynamic>> getRegions(String countryId) async {

    print('getRegions ');


    final Map<String, dynamic> jsonResponse = await ApiProvider.instance!.post('secure/regions',{
      'id':countryId
    });
    print('getRegions  $jsonResponse');


    return jsonResponse;
  }
  Future<Map<String, dynamic>> getZones(String zoneId) async {

    print('getRegions ');


    final Map<String, dynamic> jsonResponse = await ApiProvider.instance!.post('secure/zones',{
      'id':zoneId
    });
    print('getRegions  $jsonResponse');


    return jsonResponse;
  }

//   ||.. get districts by city id ..||
 

 Future<AgeCategoriesResponse> getAgeCategories() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getAgeCategories',
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
                    'Accept':'application/json',

        },
      ),
    );
     if(response.data['code']==202)
    throw ApiException(response.data['message'], 202);
    AgeCategoriesResponse ageCategoriesResponse = AgeCategoriesResponse.fromJson(response.data);
        
    return ageCategoriesResponse;
  }

  Future<EducationEnviromentsResponse> getEducationEnviroment() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getEducationEnviroment',
      options: Options( 
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
                    'Accept':'application/json',

        },
      ),
    );
     if(response.data['code']==202)
    throw ApiException(response.data['message'], 202);
    EducationEnviromentsResponse educationEnviromentsResponse = EducationEnviromentsResponse.fromJson(response.data);
        
    return educationEnviromentsResponse;
  }

}
