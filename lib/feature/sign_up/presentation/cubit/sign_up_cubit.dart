import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:transite_way/feature/sign_up/data/models/sign_up_request_body.dart';
import 'package:transite_way/feature/sign_up/domain/repository/sign_up_repository.dart';
import 'package:transite_way/feature/sign_up/presentation/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepository _signUpRepository;

  SignUpCubit(this._signUpRepository) : super(SignUpInitial());

  void signUp(SignUpRequestBody signUpRequestBody) async {
    emit(SignUpLoading());
    try {
      final http.Response response = await _signUpRepository.signUp(signUpRequestBody);

      if (response.statusCode == 200) {
        emit(SignUpSuccess());
      } else {
        try {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          final String message = responseBody['message'] ?? 'An unknown error occurred.';

          if (response.statusCode == 400 && (message.contains('Email is already registered') || message.contains('Phone is already registered'))) {
            emit(SignUpEmailOrPhoneExists(message: "Email already exited please login to continue"));
          } else {
            emit(SignUpFailure(errorMessage: message));
          }
        } catch (e) {
          emit(SignUpFailure(errorMessage: "email already exited please login to continue."));
        }
      }
    } catch (e) {
      emit(SignUpFailure(errorMessage: "An unexpected error occurred. Please check your connection."));
    }
  }
}
