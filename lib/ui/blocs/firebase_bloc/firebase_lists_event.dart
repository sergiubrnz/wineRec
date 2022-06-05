part of 'firebase_lists_bloc.dart';

abstract class FirebaseListsEvent extends Equatable {
  const FirebaseListsEvent();
}

class FirebaseStarted extends FirebaseListsEvent {
  @override
  List<Object> get props => [];
}

class GetFirebaseLists extends FirebaseListsEvent {
  final String uid;

  GetFirebaseLists(this.uid);

  @override
  List<Object> get props => [uid];
}

class DeleteWineFromList extends FirebaseListsEvent {
  // final List<WineModel> likes;
  // final List<WineModel> collection;

  //DeleteBasketProduct(this.ean);

  // @override
  // List<Object> get props => [ean];

  @override
  List<Object> get props => [];
}
