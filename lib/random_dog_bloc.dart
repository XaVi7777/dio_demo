import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RandomDogState {}

class RandomDogStateInitial extends RandomDogState {}

class RandomDogStateSuccess extends RandomDogState {
  final RandomDogResponse data;
  RandomDogStateSuccess(this.data);
}

class RandomDogStateLoading extends RandomDogState {

}

class RandomDogStateError extends RandomDogState {}

abstract class RandomDogEvent {}

class RandomDogLoadEvent extends RandomDogEvent {}

class RandomDogBloc extends Bloc<RandomDogEvent, RandomDogState> {
  final dio = Dio();
  RandomDogBloc() : super(RandomDogStateInitial()) {
    on<RandomDogLoadEvent>(_onRandomDogLoadEvent);
  }

  FutureOr<void> _onRandomDogLoadEvent(
    RandomDogLoadEvent event,
    Emitter<RandomDogState> emit,
  ) async {
    if(state is RandomDogStateLoading){
      return;
    }
    emit(RandomDogStateLoading());
    final response = await dio.get('https://dog.ceo/api/breeds/image/random');
    final randomDogResponse = RandomDogResponse.fromJson(response.data);
    emit(RandomDogStateSuccess(randomDogResponse));
  }
}

class RandomDogResponse {
  final String message;
  final String status;

  static RandomDogResponse fromJson(Map<String, dynamic> jsonData) =>
      RandomDogResponse(jsonData['message'], jsonData['status']);

  const RandomDogResponse(this.message, this.status);
}
