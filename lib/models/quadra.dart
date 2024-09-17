/// Classe que representa uma Quadra.
class Quadra {
  final String id;
  final String nome;
  final String tipo; 
  final double precoPorHora;
  final bool disponivel;

  /// Construtor da classe Quadra.
  Quadra({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.precoPorHora,
    required this.disponivel,
  });
}
