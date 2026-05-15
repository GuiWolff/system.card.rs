import '../models/cliente.dart';

abstract class ClienteRepository {
  Future<Cliente> salvar(Cliente cliente);

  Future<Cliente> atualizar(Cliente cliente);

  Future<Cliente?> buscarPorId(int id);

  Future<List<Cliente>> listar();

  Future<List<Cliente>> pesquisar(String termo);

  Future<void> excluir(int id);
}
