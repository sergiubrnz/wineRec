import '../Models/FoodModel.dart';
import '../Models/GrapesModel.dart';
import '../Models/WineTypeModel.dart';

List<WineTypeModel> listaTipuriVin = [
  WineTypeModel(image: "assets/white.png", type: 'Vin alb', key: '2'),
  WineTypeModel(image: "assets/red.png", type: 'Vin rosu', key: '1'),
  WineTypeModel(image: "assets/rose.png", type: 'Vin rose', key: '4'),
  WineTypeModel(image: "assets/sparkling.png", type: 'Vin spumant', key: '3'),
];

List<FoodModel> listaMancaruri = [
  FoodModel(image: "assets/vegetables.png", name: 'Legume', key: '19'),
  FoodModel(image: "assets/fish.png", name: 'Peste', key: '12'),
  FoodModel(image: "assets/beef.png", name: 'Vita', key: '4'),
  FoodModel(image: "assets/chicken.png", name: 'Pasare', key: '20'),
  // FoodModel(image: "assets/pasta.png", name: 'Italian', key: '5'), //35
  // FoodModel(image: "assets/sushi.png", name: 'Japanese', key: '28'),
];

List<GrapesModel> listaStruguri = [
  GrapesModel(color: 'red', name: "Merlot", key: '10'),
  GrapesModel(color: 'red', name: "Cabernet", key: '2'),
  GrapesModel(color: 'red', name: "Pinot Noir", key: '14'),
  GrapesModel(color: 'white', name: "Sauvignon", key: '17'),
  GrapesModel(color: 'white', name: "Pinot Gris", key: '13'),
  GrapesModel(color: 'white', name: "Chardonnay", key: '5'),
  GrapesModel(color: 'red', name: "Saperavi", key: '643'),
  GrapesModel(color: 'red', name: 'Shiraz', key: '1'),
  GrapesModel(color: 'white', name: 'Gewürztraminer', key: '7'),
  GrapesModel(color: 'red', name: 'Malbec', key: '9'),
  GrapesModel(color: 'white', name: 'Riesling', key: '15'),
  GrapesModel(color: 'red', name: 'Tempranillo', key: '19'),
];

List<int> listaAni = [
  2021,
  2020,
  2019,
  2018,
  2017,
  2016,
  2012,
  2010,
  2009,
  2008,
  2007,
];
