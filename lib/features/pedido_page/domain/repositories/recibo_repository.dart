import '../models/recibo.dart';

abstract class ReciboRepository {
  Future<String> proximoNumero();

  Future<Recibo> salvar(Recibo recibo);

  Future<Recibo> atualizar(Recibo recibo);

  Future<Recibo?> buscarPorId(int id);

  Future<List<Recibo>> listarHistorico();

  Future<List<Recibo>> pesquisarHistorico(String termo);

  Future<void> excluir(int id);
}
