import '../Models/FoodModel.dart';
import '../Models/GrapesModel.dart';
import '../Models/WineTypeModel.dart';

List<WineTypeModel> listaTipuriVin = [
  WineTypeModel(image: "assets/white.png", type: 'Vin alb', key: 'white'),
  WineTypeModel(image: "assets/red.png", type: 'Vin rosu', key: 'red'),
  WineTypeModel(image: "assets/rose.png", type: 'Vin rose', key: 'rose'),
  WineTypeModel(
      image: "assets/sparkling.png", type: 'Vin spumant', key: 'sparkling'),
];

List<FoodModel> listaMancaruri = [
  FoodModel(image: "assets/beef.png", name: 'Vita', key: 'beef'),
  FoodModel(image: "assets/chicken.png", name: 'Pasare', key: 'poultry'),
  FoodModel(image: "assets/fish.png", name: 'Peste', key: 'fish'),
  FoodModel(image: "assets/vegetables.png", name: 'Legume', key: 'vegetables'),
  FoodModel(image: "assets/pasta.png", name: 'Italian', key: 'italian'),
  FoodModel(image: "assets/sushi.png", name: 'Japanese', key: 'japanese'),
];

List<GrapesModel> listaStruguri = [
  GrapesModel(color: 'red', name: "Merlot", key: 'merlot'),
  GrapesModel(color: 'red', name: "Cabernet Sauvignon", key: 'cabernet'),
  GrapesModel(color: 'red', name: "Pinot Noir", key: 'pinotNoir'),
  GrapesModel(color: 'white', name: "Sauvignon", key: 'sauvignon'),
  GrapesModel(color: 'white', name: "Pinot Gris", key: 'pinotGris'),
  GrapesModel(color: 'white', name: "Chardonnay", key: 'chardonnay'),
  GrapesModel(color: 'rose', name: "Cabernet Sauvignon", key: 'cabernetRose'),
];

List<int> listaAni = [
  1995,
  2000,
  2005,
  2006,
  2007,
  2008,
  2010,
  2012,
  2016,
  2017,
  2018,
  2019,
  2020
];
