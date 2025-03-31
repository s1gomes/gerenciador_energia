

import 'package:gerenciamento_energia_bloc/core/usecases/usecase.dart';
import 'package:gerenciamento_energia_bloc/features/eletrodomesticos/data/models/EletrodomesticoModel.dart';
import 'package:gerenciamento_energia_bloc/features/eletrodomesticos/domain/repository/eletro_repository.dart';
//
// class EletrodomesticoUsecase extends UseCase<List<Map<String, dynamic>>, EletrodomesticoModel > {
//
//   final EletrodomesticoRepository eletroRepository;
//
//   EletrodomesticoUsecase(this.eletroRepository);
//
//   @override
//   Future<Either<Failure, List<Map<String, dynamic>>>> call (
//
//       ) {
//     final result = await eletroRepository.getAllEletrodomesticos();
//     return result.fold(initialValue, combine);
//   }
// }