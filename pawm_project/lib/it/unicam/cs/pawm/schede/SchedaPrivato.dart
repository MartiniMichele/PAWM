

import 'package:pawm_project/it/unicam/cs/pawm/schede/TipoSchede.dart';

class SchedaPrivato{

  late int numeroScheda;
  late int durataIntervento;
  late String data;
  late String orario;
  late String descrizione;
  late String cliente;
  final String tipo = "PRIVATO";

  SchedaPrivato(
      this.numeroScheda,
      this.durataIntervento,
      this.data,
      this.orario,
      this.descrizione,
      this.cliente);

  @override
  String toString() {
    return
        'SchedaPrivato{numeroScheda: $numeroScheda, '
        'durataIntervento: $durataIntervento, '
        'data: $data, '
        'orario: $orario, '
        'descrizione: $descrizione, '
        'cliente: $cliente, '
        'tipo: $tipo}';
  }
}