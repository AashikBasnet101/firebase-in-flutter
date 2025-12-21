import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/features/cloudinary/bloc/add_places_event.dart';
import 'package:newprojectfirebase/features/cloudinary/bloc/add_places_state.dart';
import 'package:newprojectfirebase/utils/cloudinary.dart';

class AddPlacesBloc extends Bloc<AddPlacesEvent, AddPlacesState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddPlacesBloc() : super(AddPlacesInitialState()) {
    on<AddPlaceEvent>((event, emit) async {
      emit(AddPlacesLoadingState());

      try {
        final imageData =
            await CloudinaryService().uploadImage(event.imageFile);

        await firestore.collection('places').add({
          ...event.place.toJson(),
          'url': imageData['secure_url'],
          'public_id': imageData['public_id'],
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(AddPlacesLoadedState());
      } catch (e) {
        emit(AddPlacesErrorState(e.toString()));
      }
    });
  }
}
