
import 'package:flutter/material.dart';
import 'package:pido/src/controllers/api_controllers/configs_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/area.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/error_component.dart';
import 'package:easy_localization/easy_localization.dart';

class AreasDialog extends StatefulWidget {
  final Function(Area?)onSelect;
  const AreasDialog({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<AreasDialog> createState() => _AreasDialogState();
}

class _AreasDialogState extends State<AreasDialog> {

  late Future<List<Area>>_future;
  Future<List<Area>> getAreas() async {
    BaseResponse  baseResponse;
    List<Area>?areas;
    try {
      baseResponse = await _configsController.getAreas(

      );
      if(baseResponse.status!){
        areas=List<Area>.from(baseResponse.data.map((v)=>Area.fromJson(v)));

      }

    } on Exception catch (e) {

      print(e);
      Helpers.showMessage('SomethingWentWrong'.tr(),
          MessageType.MESSAGE_FAILED);

    }
    return areas!;
  }
  late ConfigsController _configsController;

  int? selectedAreaId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configsController=ConfigsController.instance!;
    _future=getAreas();

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height*0.6,
        child:   FutureBuilder<List<Area>>(
            future: _future,
            builder: (context, snapshot) {

              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.hasError){
                print(snapshot.error);
                print(snapshot.stackTrace);

                return ErrorComponent(onTryAgainTap: (){});
              }
              return   Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Theme.of(context).primaryColor,
                    child: Center(child: Text(
                      'ChooseArea'.tr(),

                    ),),
                  ),

                  Expanded(
                    child: ListView.separated(itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          selectedAreaId=snapshot.data![index].id;
                          widget.onSelect(snapshot.data![index]);
                          setState(() {

                          });
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(snapshot.data![index].name??''),
                              ),
                              if(selectedAreaId!=null&&selectedAreaId==snapshot.data![index].id)
                                Icon(Icons.done,
                                  color: Theme.of(context).primaryColor,
                                )
                            ],
                          ),
                        ),
                      );
                    },
                        separatorBuilder: (context,index)=>Divider(),
                        itemCount: snapshot.data!.length),
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}
