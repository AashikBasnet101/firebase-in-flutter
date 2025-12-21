abstract class AddPlacesState {}

class AddPlacesInitialState extends AddPlacesState {}

class AddPlacesLoadingState extends AddPlacesState {}

class AddPlacesLoadedState extends AddPlacesState {}

class AddPlacesErrorState extends AddPlacesState {
  final String message;
  AddPlacesErrorState(this.message);
}
