import 'dart:convert';
import 'package:store/customer_views/submit_order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'customer_views/product.dart';
import 'customer_views/calss_category.dart';
import 'customer_views/addcartClass.dart';
import 'customer_views/cart.dart';
import 'customer_views/calss_order.dart';
import 'customer_views/category_page.dart';
//don't forget to include in the pubspec.yaml: http: ^0.12.0+2

class URLS {
  //This stores the url that we'll deal with the restful api through
  //for web-based applications this will be http://localhost:5000/
  //for mobile-based applications (emulators) this will be http://10.0.2.2:5000
  static const String BASE_URL = 'http://10.0.2.2:5000';
}
/// Api services for login and salesmen

class ApiService {
  static Future<dynamic> getCusotmer(String email,String password) async {
    //If the email and password are not valid , returns null
    //If the email and password are correct
    // RESPONSE IS IN THE FORMAT OF JSON :
    // {"Id": 6,
    // "FirstName": "Mariam",
    // "SecondName": "Nabil",
    // "Governorate": "Cairo",
    // "City": "Maadi",
    // "StreetName": "90st",
    // "BuildingNumber": "22",
    // "AppartmentNumber": "1",
    // "Gender": "F",
    // "PhoneNumber": 1012459878,
    // "Email": "Nor@yahoo.com",
    // "Password": "test123"}
    // }
    var queryParameters = {
      'Email': email,
      'Password': password,
    };
    var response = await http.post('${URLS.BASE_URL}/getCustomer',body: queryParameters);
 //   print(customerData);

      print(response.body);
    if (response.statusCode == 200) {
      print("response is 200: ok!");
      dynamic decode1_Customer = json.decode(response.body);
      if(decode1_Customer == null){return null;}
      dynamic decode2_Customer = json.decode(decode1_Customer);
      return decode2_Customer;
    } else {
      return null;
    }
  }
  static Future<dynamic> addCustomer(customerData) async{
    print("sugn up");
    print(customerData);
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/addCustomer'), body: customerData);
    print(customerData);
    if (response.statusCode == 200) {
      print(response.body);
      print("response is 200: ok!");
      dynamic decode1_addCustomer = json.decode(response.body);

      if(decode1_addCustomer == null){return null;}

      dynamic decode2_addCustomer = json.decode(decode1_addCustomer);
      return decode2_addCustomer;
    }
    else {
      //means customer couldn't be created
      print('Signing Up Failed!');
      return null;
    }
  }
  static Future<dynamic> getEmployee(employeeData) async {
    //If the email and password are not valid , returns null
    //If the email and password are correct
    // RESPONSE IS IN THE FORMAT OF JSON :
    // {"Id": 6,
    // "FirstName": "Mariam",
    // "SecondName": "Nabil",
    // "Governorate": "Cairo",
    // "City": "Maadi",
    // "StreetName": "90st",
    // "BuildingNumber": "22",
    // "AppartmentNumber": "1",
    // "PhoneNumber": 1012459878,
    // "Email": "Nor@yahoo.com",
    // "Password": "test123",
    // "Salary": "1000",
    // "Bonus": "0"      //If DeliveryMan only
    // }
    var response = await http.post('${URLS.BASE_URL}/getEmployee',body: employeeData);

    if (response.statusCode == 200) {
      print("response is 200: ok!");
      dynamic decode1_Employee = json.decode(response.body);
      if(decode1_Employee == null){return null;}
      dynamic decode2_Employee = json.decode(decode1_Employee);
      return decode2_Employee;
    } else {
      return null;
    }
  }
  static Future<dynamic> addEmployee(employeeData) async{
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/addEmployee'), body: employeeData);
    if (response.statusCode == 200) {
      print("response is 200: ok!");
      dynamic decode1_addEmployee = json.decode(response.body);
      if(decode1_addEmployee == null){return null;}
      dynamic decode2_addEmployee = json.decode(decode1_addEmployee);
      return decode2_addEmployee;
    }
    else {
      //means employee couldn't be created
      print('Signing Up Failed!');
      return null;
    }
  }

  static Future<dynamic> addPromocode(addPromocodeData) async{
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/addPromocode'), body: addPromocodeData);
    if (response.statusCode == 200) {
      print("response is 200: ok!");
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    }
    else {
      //means employee couldn't be created
      print('Signing Up Failed!');
      return null;
    }
  }

  static Future<dynamic> addDiscount(addDiscountData) async{
    print("leh kda bs!!!!");
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/addDiscount'), body: addDiscountData);
    if (response.statusCode == 200) {
      print("addDiscount response is 200: ok!");
      return 1;
    }
    else {
      print('Could not add Discount');
      return null;
    }
  }

  static Future<dynamic> requestProduct(RequestData) async{
    print("The The The requestProduct($RequestData)");
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/requestProduct'), body: RequestData);
    if (response.statusCode == 200) {
      print("requestProduct response is 200: ok!");
      return 1;
    }
    else {
      print('Could not requestProduct');
      return null;
    }
  }


  static Future<dynamic> getPromocodes() async{
    final response = await http.get(Uri.encodeFull('${URLS.BASE_URL}/getPromocodes'));
    if (response.statusCode == 200) {
      print("getPromocodes response is 200: ok!");
      //unfortunately, I have no idea why it worked when decoding twice and then decoding in the for loop
      //However, fortunately IT WORKED!!
      var decode1_Promocodes = json.decode(response.body);
      var decode2_Promocodes = json.decode(decode1_Promocodes);

      List<Map<String,dynamic>> ListOfPromocodes = [];

      for ( int i=0;i< decode2_Promocodes.length ; i++){
        ListOfPromocodes.add(decode2_Promocodes[i]);
      }
      return ListOfPromocodes;
    }
    else {
      //means employee couldn't be created
      print("Response is NOT OKAY! >_<");
      return null;
    }
  }
  static Future<dynamic> addCategory(addCategoryData) async{
    print("leh kda bs!!!!");
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/addCategory'), body: addCategoryData);
    if (response.statusCode == 200) {
      print("addCategory response is 200: ok!");
      return json.decode(response.body);
    }
    else {
      print('Could not add Category');
      return null;
    }
  }
  static Future<dynamic> addSupplier(addSupplierData) async{
    print("leh kda bs!!!!");
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/addSupplier'), body: addSupplierData);
    if (response.statusCode == 200) {
      print(response.body) ;
      return json.decode(response.body);
    }
    else {
      print('Could not add Supplier');
      return null;
    }
  }

  // static Future<void> editPromocode(EditPromoCodeData) async{
  //   final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/editPromocode='),body: EditPromoCodeData);
  //   if (response.statusCode == 200) {
  //     print("response is 200: ok!");
  //   }
  //   else {
  //     print("Response is NOT OKAY! >_<");
  //   }
  // }

  static Future<void> deletePromocode(String Code) async{
    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/deletePromocode'),body: {'Code':Code});
    if (response.statusCode == 200) {
      print("response is 200: ok!");
    }
    else {
      Exception("Can't delete this promocode!");
    }
  }

  static Future<dynamic> getCategories() async{
    final response = await http.get(Uri.encodeFull('${URLS.BASE_URL}/getCategories'));
    if (response.statusCode == 200) {
      print("response is 200: ok!");
      //unfortunately, I have no idea why it worked when decoding twice and then decoding in the for loop
      //However, fortunately IT WORKED!!
      print(response.body);
      var decode1_Categories = json.decode(response.body);
      var decode2_Categories = json.decode(decode1_Categories);
      print(decode2_Categories[1]);
      return decode2_Categories;
    }
    else {
      throw Exception("Can't get Categories!");
    }
  }

  static Future<dynamic> getSuppliers() async{
    final response = await http.get(Uri.encodeFull('${URLS.BASE_URL}/getSuppliers'));
    if (response.statusCode == 200) {
      print("response is 200: ok!");
      //unfortunately, I have no idea why it worked when decoding twice and then decoding in the for loop
      //However, fortunately IT WORKED!!
      print(response.body);
      var decode1_Suppliers = json.decode(response.body);
      var decode2_Suppliers = json.decode(decode1_Suppliers);
      print(decode2_Suppliers);
      print(decode2_Suppliers[1]);
      print(decode2_Suppliers[1]['Email']);
      return decode2_Suppliers;
    }
    else {
      throw Exception("Can't get Suppliers!");
    }
  }

  static Future<dynamic> getProducts_SalesManView() async{
    final response = await http.get(Uri.encodeFull('${URLS.BASE_URL}/getProducts_SalesManView'));
    if (response.statusCode == 200) {
      print("getProducts_SalesManView response is 200: ok!");
      //unfortunately, I have no idea why it worked when decoding twice and then decoding in the for loop
      //However, fortunately IT WORKED!!
      var decode1_Products = json.decode(response.body);
      var decode2_Products = json.decode(decode1_Products);

      return decode2_Products;
    }
    else {
      throw Exception("Can't get Products_SalesManView!");
    }
  }

  static Future<dynamic> getLimitedProducts_SalesManView() async{
    print("Hereeeeeeeeee ");
    final response = await http.get('${URLS.BASE_URL}/getLimitedProducts');
    print("Here");
    if (response.statusCode == 200) {
      print("getLimitedProducts_SalesManView response is 200: ok!");
      //unfortunately, I have no idea why it worked when decoding twice and then decoding in the for loop
      //However, fortunately IT WORKED!!
      var decode1_Products = json.decode(response.body);
      var decode2_Products = json.decode(decode1_Products);
      print(decode2_Products);
      return decode2_Products;
    }
    else {
      throw Exception("Can't get Products_SalesManView!");
    }
  }

  static Future<dynamic> addProduct(addProductData) async{

    print(addProductData);
    //converting all nulls to empty strings ""
    for(dynamic k in addProductData.keys){
      if(addProductData[k]==null){addProductData[k]="";}
    }

    final response = await http.post(Uri.encodeFull('${URLS.BASE_URL}/addProduct'), body: addProductData);

    if (response.statusCode == 200) {
      print("response is 200: ok!");
      return 1;
    }
    else {
      //should never happen!
      print('Adding product have Failed!');
      return null;
    }
  }
}
/// HR Man View ***************************************************************************
///------------------------------------------------------------------ HR's view---------> deliverymen details
Future<dynamic> GetDeliveryMen()async {

  final response = await http.get ('${URLS.BASE_URL}/deliveryMenHR');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((dm) =>new DeliveryMen_HR.fromJson(dm)).toList();
  }
  else{
    throw Exception("Failed To load Delivery men details from API");
  }

}
Future<dynamic> GetDeliveryMenSearchedRating(double rate)async {

  var rating= {
    'rate': '$rate',
  };
  final response =  await http.post('http://10.0.2.2:5000/DeliveryMenRateHR', body: rating);
  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((dm) =>new DeliveryMen_HR.fromJson(dm)).toList();
  }
  else{
    throw Exception("Failed To load Delivery men details from API");
  }

}

Future<dynamic> GetDeliveryMenRating(int ID)async {

  Map<String,dynamic> id= {'ID': '$ID'};
  final response =  await http.post('http://10.0.2.2:5000/RateDM_HR', body: id);
  print(json.decode(response.body));
  if(response.statusCode ==200){
    dynamic jsonResponse=json.decode(response.body);
    return (jsonResponse[0]);
  }
  else{
    throw Exception("Failed To load Delivery men details from API");
  }

}




Future<dynamic> AddBonus_DM(int DM_id, int bonus)async {

  var bonus_req= {
    'Bonus': '$bonus',
    'Id': '$DM_id'
  };
  final response =  await http.post('http://10.0.2.2:5000/deliveryMenBonus', body: bonus_req);
  if(response.statusCode ==200){
    return json.decode(response.body);
  }
  else{
    throw Exception("Failed To update DM's salary from API");
  }
}

class DeliveryMen_HR {
  final String FirstName;
  final String LastName;
  final String Governorate;
  final String City;
  final String StreetName;
  final String email;
  //String image;
  final int id;
  final String BuildingNumber;
  final String AppartmentNumber;
  final int PhoneNumber;
  final int Salary;
  final int Bonus;
  //double rating;
  DeliveryMen_HR({this.FirstName, this.LastName, this.Governorate,this.City, this.StreetName, this.email, this.id,this.BuildingNumber,this.AppartmentNumber,this.PhoneNumber,this.Salary,this.Bonus});

  factory DeliveryMen_HR.fromJson(Map<String,dynamic>json ){
    return DeliveryMen_HR(
        FirstName: json['FirstName'],
        LastName: json['SecondName'],
        Governorate: json['Governorate'],
        City: json['City'],
        StreetName: json['StreetName'],
        email: json['Email'],
        id: json['Id'],
        BuildingNumber: json['BuildingNumber'],
        AppartmentNumber: json['AppartmentNumber'],
        PhoneNumber: json['PhoneNumber'],
        Salary: json['Salary'],
        Bonus:json['Bonus']);
  }
}


///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> HR's view---------> salesmen details

Future<dynamic> GetSalesMen()async {

  final response = await http.get ('${URLS.BASE_URL}/SalesMenHR');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((dm) =>new SalesMen_HR.fromJson(dm)).toList();
  }
  else{
    throw Exception("Failed To load Sales men details from API");
  }

}


class SalesMen_HR {
  final String FirstName;
  final String LastName;
  final String Governorate;
  final String City;
  final String StreetName;
  final String email;
  //String image;
  final int id;
  final String BuildingNumber;
  final String AppartmentNumber;
  final int PhoneNumber;
  final int Salary;
  SalesMen_HR({this.FirstName, this.LastName, this.Governorate,this.City, this.StreetName, this.email, this.id,this.BuildingNumber,this.AppartmentNumber,this.PhoneNumber,this.Salary});

  factory SalesMen_HR.fromJson(Map<String,dynamic>json ){
    return SalesMen_HR(
      FirstName: json['FirstName'],
      LastName: json['SecondName'],
      Governorate: json['Governorate'],
      City: json['City'],
      StreetName: json['StreetName'],
      email: json['Email'],
      id: json['Id'],
      BuildingNumber: json['BuildingNumber'],
      AppartmentNumber: json['AppartmentNumber'],
      PhoneNumber: json['PhoneNumber'],
      Salary: json['Salary'],
    );
  }
}

///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> HR's view---------> Customers details
Future<dynamic> GetCustomers_HR(int customer_id)async {

  var id_searching= {
    'Id': '$customer_id'
  };

  final response = await http.post ('${URLS.BASE_URL}/CustomerHR', body: id_searching);

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((cust) =>new Customer.fromJson(cust)).toList();
  }
  else{
    throw Exception("Failed To load Delivery men details from API");
  }

}

class Customer {
  final String FirstName;
  final String LastName;
  final String Governorate;
  final String City;
  final String StreetName;
  final String email;
  final int id;
  final String gender;
  final String BuildingNumber;
  final String AppartmentNumber;
  final int PhoneNumber;

  Customer({this.FirstName, this.LastName, this.Governorate,this.City, this.StreetName, this.email, this.id,this.gender,this.BuildingNumber,this.AppartmentNumber,this.PhoneNumber});


  factory Customer.fromJson(Map<String,dynamic>json ){
    return Customer(
      FirstName: json['FirstName'],
      LastName: json['SecondName'],
      Governorate: json['Governorate'],
      City: json['City'],
      StreetName: json['StreetName'],
      email: json['Email'],
      gender: json['Gender'],
      id: json['Id'],
      BuildingNumber: json['BuildingNumber'],
      AppartmentNumber: json['AppartmentNumber'],
      PhoneNumber: json['PhoneNumber'],

    );
  }
}

///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> HR's view---------> Complaints details

Future<dynamic> GetComplaints_HR()async {

  final response = await http.get ('${URLS.BASE_URL}/ComplaintsHR');

  if(response.statusCode ==200){
    print("comp");
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((cust) =>new Complaints.fromJson(cust)).toList();
  }
  else{
    throw Exception("Failed To load complaints from API");
  }

}


Future<dynamic> Send_respond(String respond, int customerid)async {

  var myrespond= {
    'respond': respond,
    'customerid': '$customerid'
  };
  print (respond);
  final response =  await http.post('http://10.0.2.2:5000/Respond_complaint', body: myrespond);
  if(response.statusCode ==200){
    return json.decode(response.body);
  }
  else{
    throw Exception("Failed To send response from API");
  }
}


Future<dynamic> ShowResolvedComp()async {

  final response = await http.get ('${URLS.BASE_URL}/resolvedshow');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((cust) =>new Complaints.fromJson(cust)).toList();
  }
  else{
    throw Exception("Failed To show resolved messages from API");
  }

}



class Complaints {

  final int id;
  final int Customer_id;
  final String message;
  final String respond;
  Complaints({this.id,this.Customer_id,this.message,this.respond});


  factory Complaints.fromJson(Map<String,dynamic>json ){
    return Complaints(

        id: json['Id'],
        Customer_id: json['CustomerId'],
        message: json['Message'],
        respond: json ['respond']

    );
  }
}

///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> HR's view-----------------> feedback on deliverymen


Future<dynamic> GetFB_DM_HR()async {

  final response = await http.get ('${URLS.BASE_URL}/FeedbackDMHR');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((cust) =>new FeedBackHR.fromJson(cust)).toList();
  }
  else{
    throw Exception("Failed To load reviews from API");
  }

}


Future<dynamic> DM_Feedback_details(int id)async {

  var id_searching= {
    'Id': '$id'
  };

  print(id_searching);
  final response = await http.post ('${URLS.BASE_URL}/DM_Feedback_details', body: id_searching);
  print('I am hereee in HR errorrrrrrrrrrrrrrr');
  if(response.statusCode ==200){
    print('dkhaallltttt');

    dynamic jsonResponse=json.decode(response.body);

    print(jsonResponse);
    print(jsonResponse.length);
    print(jsonResponse[0]);

    return jsonResponse.map((cust) =>new DeliveryMen_HR.fromJson(cust)).toList()[0];
  }
  else{
    throw Exception("Failed To load Delivery men details from API");
  }

}




class FeedBackHR {

  final int id;
  final int rate;
  final int Customer_id;
  final int dm;
  final String message;
  //final String respond;
  FeedBackHR({this.id,this.rate,this.Customer_id,this.dm, this.message});


  factory FeedBackHR.fromJson(Map<String,dynamic>json ){
    return FeedBackHR(
        id: json['Id'],
        Customer_id: json['CustomerId'],
        message: json['Message'],
        dm: json ['DeliveryManId'],
        rate: json["Rate"]
    );
  }
}

///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Respond to complaints (Customer view) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


Future<dynamic> ShowResolvedComp_Customer(int id)async {
  var idd={
    'Id': '$id'
  };

  final response = await http.post ('${URLS.BASE_URL}/resolvedshowCustomer',  body: idd);

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((cust) =>new Complaints.fromJson(cust)).toList();
  }
  else{
    throw Exception("Failed To show resolved messages from API");
  }

}




Future<dynamic> UpdatemyPW(Map<String,dynamic> UserData, String password)async {

  UserData.addAll({'password': '$password'});
  for (var k in UserData.keys) {
    UserData[k]=UserData[k].toString();
  }
  final response =  await http.post('http://10.0.2.2:5000/PasswordUPDATE', body: UserData);
  if(response.statusCode ==200){
    return json.decode(response.body);
  }
  else{
    throw Exception("Failed To update HR's password from API");
  }
}



class HR {
  final String FirstName;
  final String LastName;
  final String Governorate;
  final String City;
  final String StreetName;
  final String email;
  final int id;
  final String gender;
  final String BuildingNumber;
  final String AppartmentNumber;
  final int PhoneNumber;

  HR({this.FirstName, this.LastName, this.Governorate,this.City, this.StreetName, this.email, this.id,this.gender,this.BuildingNumber,this.AppartmentNumber,this.PhoneNumber});


  factory HR.fromJson(Map<String,dynamic>json ){
    return HR(
      FirstName: json['FirstName'],
      LastName: json['SecondName'],
      Governorate: json['Governorate'],
      City: json['City'],
      StreetName: json['StreetName'],
      email: json['Email'],
      gender: json['Gender'],
      id: json['Id'],
      BuildingNumber: json['BuildingNumber'],
      AppartmentNumber: json['AppartmentNumber'],
      PhoneNumber: json['PhoneNumber'],

    );
  }
}





Future<dynamic> HR_details(int id)async {

  var id_searching= {
    'Id': '$id'
  };

  final response = await http.post ('${URLS.BASE_URL}/HR', body: id_searching);if(response.statusCode ==200){

    List jsonResponse=json.decode(response.body);

    return jsonResponse.map((cust) =>new HR.fromJson(cust)).toList()[0];
  }
  else{
    throw Exception("Failed To load Delivery men details from API");
  }

}

/// Delivery Man View ***********************************************************************************
Future <dynamic> GetOrder() async{
  final response = await http.get ('${URLS.BASE_URL}/deliveryman');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((order) =>new Order.fromJson(order)).toList();
  }
  else{
    throw Exception("Failed To load Orders from API");
  }
}

class Order{
  final String FirstName;
  final String SecondName;
  final String City;
  final String StreetName;
  final int Id; //this is the order id

  Order({this.FirstName,this.SecondName,this.City,this.StreetName,this.Id});

  factory Order.fromJson(Map<String,dynamic>json ){
    return Order(
        FirstName: json['FirstName'],
        SecondName:json['SecondName'],
        City: json['city'],
        StreetName: json['StreetName'],
        Id:json['Id']);

  }
}

Future <dynamic> MyOrders(Id) async{
  print(Id);
  final response=await http.post ('${URLS.BASE_URL}/MyOrders',body:{"Id":'$Id'});
  if (response.statusCode==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((order) =>new OrderDetails.fromJson(order)).toList();
  }
  else{
    throw Exception("Failed To load OrderDetails from API");
  }
}

class OrderDetails{
  final String FirstName;
  final String SecondName;
  final String Governorate;
  final String City;
  final String StreetName;
  final String BuildingNumber;
  final String AppartmentNumber;
  final int PhoneNumber;
  final int TotalPayment;
  final int Id;

  OrderDetails({this.FirstName,this.SecondName,this.Governorate,this.City,this.StreetName,
    this.BuildingNumber,this.AppartmentNumber,this.PhoneNumber,this.TotalPayment,this.Id});
  factory OrderDetails.fromJson(Map <String,dynamic> json ){
    return OrderDetails(
      FirstName: json['FirstName'],
      SecondName:json['SecondName'],
      City:json['City'],
      Governorate:json['Governorate'],
      StreetName: json['StreetName'],
      BuildingNumber: json['BuildingNumber'],
      AppartmentNumber:json['AppartmentNumber'],
      PhoneNumber: json['PhoneNumber'],
      TotalPayment: json['TotalPayment'],
      Id:json["Id"],
    );
  }
}
//this id is the order id to be marked by a  delivery man
Future<dynamic>DeliverOrder(DMId,OrderId)async {
  print("DMan= ${DMId}  OrderId=${OrderId}");
  final response=await http.post('${URLS.BASE_URL}/DeliverOrder',body:{"DMId":'$DMId',"OrderId":'$OrderId'});
  if(response.statusCode==200){
    print("Successful assigning order");
    return;
  }
  else{
    throw Exception("Failed To Assign the order to a delivery man");
  }
}

Future<dynamic>MarkOrderDelivered(OrderId)async{
  final response=await http.post('${URLS.BASE_URL}/MarkOrderDelivered',body:{"OrderId":'$OrderId'});
  if(response.statusCode==200){
    print("Marked the Order  as Delivered To Customer :D");
    return;
  }
  else{
    throw Exception("Failed To Mark the Order as delivered");
  }
}

///*************************************MARIM NASER ********************************************************************

/// Best Sellers
Future <dynamic> GetBestSellerProducts() async{
  final response = await http.get ('${URLS.BASE_URL}/BestproductsHome');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((product) =>new Product.fromJson(product)).toList();
  }
  else{
    throw Exception("Failed To load Best Seller Products from API");
  }
}
/// offers
Future <dynamic> GetProductsWithOffers() async{
  final response = await http.get ('${URLS.BASE_URL}/OffersHome');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((product) =>new Product.fromJson(product)).toList();
  }
  else{
    throw Exception("Failed To load Best Seller Products from API");
  }
}
/// Categories
Future <dynamic> GetCategories() async{
  final response = await http.get ('${URLS.BASE_URL}/Categories');

  if(response.statusCode ==200){
    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((product) =>new MyCategory.fromJson(product)).toList();
  }
  else{
    throw Exception("Failed To load Categories from API");
  }
}

/// products of category
Future<dynamic> CategoryProducts(int CID) async{

  print('$CID');
  Map <String,dynamic> CAT_ID= {"CID":'$CID'};
  final response = await http.post('${URLS.BASE_URL}/CategoryProducts', body:CAT_ID );
  if (response.statusCode == 200) {

    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((product) =>new Product.fromJson(product)).toList();

    return json.decode(response.body);
  }
  else{
    throw Exception("Failed To load Categories from API");
  }
}
///Add To Cart
Future<dynamic> AddToCart(int CustomerID, int productID, int qty) async{
  Map <String,dynamic> addingtocart ={
    'proID': productID.toString(),
    'custID': CustomerID.toString(),
    'QTY':qty.toString()
  };
  print(productID.toString()+" "+CustomerID.toString());
  final response = await http.post('${URLS.BASE_URL}/addtocart', body: addingtocart );
  print("noran");
  if (response.statusCode == 200) {
    print("yarab");
    return json.decode(response.body);
  }
  else{
    print("EXEPTION");
    throw Exception("Failed To load Categories from API");
  }
}
/// get all products in the cart
Future<dynamic> GetCartProducts(int CID) async{

  print('$CID');
  Map <String,dynamic> CAT_ID= {"CID":'$CID'};
  final response = await http.post('${URLS.BASE_URL}/getCart', body:CAT_ID );
  if (response.statusCode == 200) {

    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((product) =>new Product.fromJson(product)).toList();

    return json.decode(response.body);
  }
  else{
    throw Exception("Failed To load Categories from API");
  }
}
/// increment quantity
Future<dynamic> inc_qty(int CustomerID, int productID) async{
  Map <String,dynamic> inc_id = {
    'proID': productID.toString(),
    'custID': CustomerID.toString(),
  };
  final response = await http.post('${URLS.BASE_URL}/incQTY', body: inc_id );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  else{
    print("EXEPTION");
    throw Exception("Failed To load Categories from API");
  }
}
/// deccrement quantity
Future<dynamic> dec_qty(int CustomerID, int productID) async{
  Map <String,dynamic> dec_id = {
    'proID': productID.toString(),
    'custID': CustomerID.toString(),
  };
  print("TB EHHHH");
  final response = await http.post('${URLS.BASE_URL}/decQTY', body: dec_id );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  else{
    throw Exception("Failed To load Categories from API");
  }
}
/// get aty of certain product
Future<dynamic> GetQTY(int PROID) async {

  print('$PROID');
  Map <String, dynamic> CAT_ID = {"proID": '$PROID'};

  final response = await http.post('${URLS.BASE_URL}/getCart', body: CAT_ID);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((product) => new Product.fromJson(product))
        .toList();

    return json.decode(response.body);
  }
  else {
    throw Exception("Failed To load Categories from API");
  }
}
/// delete product from cart
Future<dynamic> DeleteFromCart(int CustomerID, int productID) async{
  Map <String,dynamic> delete_cart = {
    'proID': productID.toString(),
    'custID': CustomerID.toString(),
  };
  final response = await http.post('${URLS.BASE_URL}/deletefromcart', body:delete_cart );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  else{
    print("EXEPTION");
    throw Exception("Failed To load Categories from API");
  }
}
///making order
/// 1-get price and qty of products in cart
Future<dynamic> GetTotalPayment(int CID) async{

  Map <String,dynamic> CAT_ID= {"CID":'$CID'};

  final response = await http.post('${URLS.BASE_URL}/priceQTYget', body:CAT_ID );
  if (response.statusCode == 200) {

    List jsonResponse=json.decode(response.body);
    return jsonResponse.map((product) =>new TotalPayement.fromJson(product)).toList();
  }
  else{

    throw Exception("Failed To load Categories from API");
  }
}
///2- insert new order
Future<dynamic> MakeOrder(int CustomerID, int totalpay) async{
  Map <String,dynamic> makeneworder ={
    'custID': CustomerID.toString(),
    'totpay':totalpay.toString(),
  };
  print(CustomerID.toString() + totalpay.toString() );
  final response = await http.post('${URLS.BASE_URL}/makeorder', body:makeneworder );

  print("noran");
  if (response.statusCode == 200) {
    print("yarab");
    return json.decode(response.body);
  }
  else{
    print("EXEPTION");
    throw Exception("Failed To insert order into API");
  }
}
///3- Clear The Cart Fot this customer ONLY
Future<dynamic> ClearCart(int cID) async{
  ///customer ID
  Map <String,dynamic> clearmycart= {"CID":cID.toString()};
  print("TB EHHHH2");
  final response = await http.post('${URLS.BASE_URL}/emptycart', body:clearmycart );
  print("noran2");
  if (response.statusCode == 200) {
    print("yarab2");
    return json.decode(response.body);
  }
  else{
    print("EXEPTION");
    throw Exception("Failed To load Categories from API");
  }
}
/// get my orders
Future<dynamic> GetMyOrders(int CID) async{


  Map <String,dynamic> CAT_ID= {"CID":'$CID'};
  print(CID.toString());
  final response = await http.post('${URLS.BASE_URL}/getorder', body:CAT_ID );
  if (response.statusCode == 200) {
    print("hello");
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((order) => new OrderM.fromJson(order)).toList();
  }
  else{
    print("helloxx");
    throw Exception("Failed To load orders from API");
  }
}
/// Feedback Delivery man
Future<dynamic> FeedbackDM( double myrate, String message,int CustomerID, int DMID) async{
  Map <String,dynamic> feedbackdmm ={
    'myrate':myrate.toString(),
    'MSG': message,
    'custID': CustomerID.toString(),
    'dmID':DMID.toString()
  };
  print(myrate.toString()+ message+CustomerID.toString()+" "+DMID.toString());
  print(feedbackdmm);
  final response = await http.post('${URLS.BASE_URL}/feedbackdm', body:feedbackdmm );
  print("noran");
  if (response.statusCode == 200) {
    print("yarab");
    return json.decode(response.body);


  }
  else{
    print("EXEPTION");
    throw Exception("Failed To insert feedback into API");
  }
}
///comment product
Future<dynamic> Commentpro(int CustomerID , String Msg,int proid) async{

  print(CustomerID.toString());

  Map <String,dynamic> commment ={
    'MSG':Msg,
    'custID': CustomerID.toString(),
    'proID':proid.toString()

  };
  final response = await http.post('${URLS.BASE_URL}/commentproduct', body:commment );
  print("hyy");
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  else{
    print("yoooo");
    throw Exception("Failed To load Categories from API");
  }
}
/// show comments on certain product
Future<dynamic> showcomment(int proID) async{

  print('$proID');
  Map <String,dynamic> CAT_ID= {"PROID":'$proID'};
  final response = await http.post('${URLS.BASE_URL}/showcommentproduct', body:CAT_ID );
  if (response.statusCode == 200) {

    print(response.body);
    dynamic jsonResponse=json.decode(response.body);
    print(jsonResponse);
    print(jsonResponse.length);
    print(jsonResponse[0]);
   ///return jsonResponse.map((product) =>new String.fromJson(product)).toList();

     return jsonResponse;
   ///  return json.decode(json.decode(response.body));
  }
  else{
    throw Exception("Failed To load Categories from API");
  }
}
///rate  product
Future<dynamic> Ratepro(int CustomerID , double rate,int proid) async{

  print(CustomerID.toString());
  print(proid.toString());
  print(rate.toString());


  Map <String,dynamic> commment ={
    'myrate':rate.toString(),
    'custID': CustomerID.toString(),
    'proID':proid.toString()

  };

  final response = await http.post('${URLS.BASE_URL}/rateproduct', body:commment );
  print("hyy");
  if (response.statusCode == 200) {
    return json.decode(response.body);
    print("hyy");
  }
  else{
    print("yoooo");
    throw Exception("Failed To load Categories from API");
  }
}
/// show rate of certain product
Future<dynamic> showrate(int proID) async{
  Map <String,dynamic> CAT_ID= {"PROID":'$proID'};
  print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  print(CAT_ID);
  final response = await http.post('${URLS.BASE_URL}/showrateproduct', body:CAT_ID );
  if (response.statusCode == 200) {
    print("HHHHHHHHHHHHHHHHHH");
    print(response.body);
    dynamic jsonResponse= json.decode(response.body);
    print(jsonResponse[0][0]);
    ///print(jsonResponse.length);
    ///print(jsonResponse[0]);
    return jsonResponse[0][0];
  }
  else{
    print("exhhxx");
    throw Exception("Failed To load Categories from API");
  }
}
///Make Complaint
Future<dynamic> MakeComplaints(int CustomerID , String Msg) async{

  print(CustomerID.toString());

  Map <String,dynamic> makeComplaint ={
    'custID': CustomerID.toString(),
    'MSG':Msg
  };
  final response = await http.post('${URLS.BASE_URL}/complaint', body: makeComplaint );
  print("hyy");
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  else{
    print("yoooo");
    throw Exception("Failed To load Categories from API");
  }
}

/// check promo code
Future<dynamic> CheckPromocode (String IDpromo) async{
  Map <String,dynamic> CAT_ID= {"code":IDpromo};
  print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  print(CAT_ID);
  final response = await http.post('${URLS.BASE_URL}/checkpromo', body:CAT_ID );
  if (response.statusCode == 200) {
    print("HHHHHHHHHHHHHHHHHH");

    dynamic jsonResponse= json.decode(response.body);
    print(jsonResponse);
    print(jsonResponse[0][0]);

    return jsonResponse[0][0];

  }
  else{
    print("exhhxx");
    return null;
  }
}
/// Use promocode
Future<dynamic> usepromocode(int CustomerID , String code) async{

  print(CustomerID.toString());

  Map <String,dynamic> use ={
    'custID': CustomerID.toString(),
    'code':code
  };
  final response = await http.post('${URLS.BASE_URL}/USEPROMO', body:use );
  print("hyy");
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  else{
    print("yoooo");
    throw Exception("Failed To load Categories from API");
  }
}




