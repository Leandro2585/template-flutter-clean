import 'package:dartz/dartz.dart';
import 'package:template_flutter_clean/data/protocols/repositories/index.dart';
import 'package:template_flutter_clean/domain/entities/index.dart';
import 'package:template_flutter_clean/domain/errors/index.dart';
import 'package:template_flutter_clean/domain/usecases/index.dart';

class AuthencationServiceInput {
  final String email;
  final String password;

  AuthencationServiceInput({ required this.email, required this.password });
}

class AuthenticationService extends UseCase<User, AuthencationServiceInput> {
  final UserRepository _userRepository;
  
  AuthenticationService(this._userRepository);

  @override
  Future<Either<Failure, User>> call(AuthencationServiceInput input) async {
    return await _userRepository.auth(email: input.email, password: input.password);
  }
}