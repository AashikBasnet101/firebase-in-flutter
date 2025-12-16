import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newprojectfirebase/features/test/post_models.dart';
import 'package:newprojectfirebase/features/test/test_event.dart';
import 'package:newprojectfirebase/features/test/test_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialState()) {
    on<IncrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count + 1));
      } else {
        emit(UpdatedState(1));
      }
    });

    on<DecrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count - 1));
      } else {
        emit(UpdatedState(-1));
      }
    }
    );

    on <LoginEvent>((event, emit) {
      
    });
  }
}



///password visibility bloc
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordInitialState()) {
    on<TogglePasswordVisibility>((event, emit) {
      if (state is PasswordUpdatedState) {
        emit(PasswordUpdatedState(!(state as PasswordUpdatedState).isVisible));
      } else {
        emit(const PasswordUpdatedState(true));
      }
    });
  }
}

//api hit bloc
class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitialState()) {
    on<FetchDataEvent>(_fetchPosts);
  }
}

Future<void> _fetchPosts(
    FetchDataEvent event, Emitter<ApiState> emit) async {
  emit(ApiLoadingState());

  try {
    final response = await Dio().get(
      'https://dummyjson.com/posts',
    );

    if (response.statusCode == 200) {
      

      final data = response.data;
      final postsJson = data['posts'] as List<dynamic>;

      final posts = postsJson
          .map((e) => Post.fromJson(e))
          .toList();

      emit(ApiLoadedState(posts));
    } else {
      emit(ApiErrorState('Failed to load data'));
    }
  } catch (e) {
    emit(ApiErrorState(e.toString()));
  }
}
