class Place {
  
  String? name;
  
  double? latitude;
  double? longitude;
  String? address;
  

  Place(
      {
    
      this.name,
    
      this.latitude,
      this.longitude,
      this.address,
    });

  Place.fromJson(Map<String, dynamic> json) {
   
    name = json['name'];
   
    latitude = json['geometry']['location']['lat'];
    longitude = json['geometry']['location']['lng'];
    address = json['formatted_address'];
   
  }

 
}