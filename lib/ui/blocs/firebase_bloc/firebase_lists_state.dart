part of 'firebase_lists_bloc.dart';

abstract class FirebaseListsState extends Equatable {
  const FirebaseListsState();

  @override
  List<Object> get props => [];
}

class FirebaseListsInitial extends FirebaseListsState {}

class ListsLoading extends FirebaseListsState {}

class ListsLoaded extends FirebaseListsState {
  const ListsLoaded(this.likes, this.collection);

  final List<WineModel> likes;
  final List<WineModel> collection;

  @override
  List<Object> get props => [likes, collection];
}

class ListsUnavailable extends FirebaseListsState {}
