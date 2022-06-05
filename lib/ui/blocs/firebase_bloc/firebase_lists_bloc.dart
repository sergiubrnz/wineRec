import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wine_rec/firebase/data_methods.dart';
import 'package:wine_rec/utils/Models/wineModel.dart';

part 'firebase_lists_event.dart';
part 'firebase_lists_state.dart';

class FirebaseListsBloc extends Bloc<FirebaseListsEvent, FirebaseListsState> {
  FirebaseListsBloc() : super(FirebaseListsInitial()) {
    on<FirebaseStarted>(_onStarted);
    on<GetFirebaseLists>(_onGetLists);
    //on<DeleteWineFromList>(_onAddToBasket);
  }

  get uid => null;

  void _onStarted(
      FirebaseStarted event, Emitter<FirebaseListsState> emit) async {
    emit(FirebaseListsInitial());
  }

  void _onGetLists(
      GetFirebaseLists event, Emitter<FirebaseListsState> emit) async {
    var uid = event.uid;
    try {
      emit(ListsLoading());
      var likes = await DataMethods().getLikes(uid: uid);
      print('LIKES ${likes.runtimeType}');
      var collection = await DataMethods().getCollection(uid: uid);
      print('COLLECTION ${collection.runtimeType}');
      if ((likes.runtimeType == List<WineModel>) &&
          (collection.runtimeType == List<WineModel>)) {
        emit(ListsLoaded(
            likes as List<WineModel>, collection as List<WineModel>));
      } else {
        emit(ListsUnavailable());
      }
    } catch (_) {
      print(_);
      emit(FirebaseListsInitial());
    }
  }

  // void _onAddToBasket(
  //     AddProductToBasket event, Emitter<FirebaseListsState> emit) async {
  //   var ean = event.ean;
  //   var quantity = event.quantity;
  //   final product = await CameraService.addSelfScanningProduct(ean, quantity);
  //   emit(ProductInitial());
  // }
}
