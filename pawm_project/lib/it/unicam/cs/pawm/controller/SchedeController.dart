import 'dart:core';
import 'dart:developer';

import 'package:pawm_project/it/unicam/cs/pawm/database/dbManager.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';

class SchedaController {
  static final SchedaController _singleton = SchedaController._internal();
  static final DbManager _db = DbManager.instance;
  ContrattoComune contrattoComune = ContrattoComune(id: 0, oreTotali: 0, oreRimanenti: 0, valoreContratto: 0);
  List<SchedaPrivato> listaPrivato = <SchedaPrivato>[];
  List<ContrattoPrivato> listaContratto = <ContrattoPrivato>[];

  /// Singleton
  factory SchedaController() {
    return _singleton;
  }

  SchedaController._internal();

  ///  Crea una scheda intervento per il comune
  bool creaSchedaComune(int oreIntervento, String ufficio, String data,
      String orario, String descrizione) {
    bool flag = false;

    if (contrattoComune.listaSchede.isEmpty) {
      SchedaComune scheda =
      SchedaComune(
          1,
          contrattoComune.id,
          oreIntervento,
          ufficio,
          data,
          orario,
          descrizione);
      contrattoComune.listaSchede.add(scheda);
      contrattoComune.oreRimanenti =
          contrattoComune.oreRimanenti - oreIntervento;
      flag = true;
      log("Scheda comune creata e aggiunta al contratto");
    } else {
      contrattoComune.listaSchede.sort((a, b) =>
          a.numeroIntervento.compareTo(b.numeroIntervento));
      SchedaComune scheda = SchedaComune(
          contrattoComune.listaSchede.last.numeroIntervento,
          contrattoComune.id,
          oreIntervento,
          ufficio,
          data,
          orario,
          descrizione);

      contrattoComune.listaSchede.add(scheda);
      contrattoComune.oreRimanenti =
          contrattoComune.oreRimanenti - oreIntervento;
      flag = true;
      log("Scheda comune creata e aggiunta al contratto");
    }

    log("Operazione completata(creazione scheda comune)");
    return flag;
  }

  /// Crea una scheda intervento per un privato
  bool creaSchedaPrivato(int durata, String data, String orario,
      String descrizione, String cliente) {
    listaPrivato.sort((a, b) => a.numeroScheda.compareTo(b.numeroScheda));
    int lastNumero;

    if (listaPrivato.isEmpty) {
      lastNumero = 0;
    }

    else {
      lastNumero = listaPrivato.last.numeroScheda;
    }

    SchedaPrivato scheda = SchedaPrivato(
        lastNumero + 1, durata, data, orario, descrizione, cliente);
    listaPrivato.add(scheda);
    log("Scheda privato creata e aggiunta alla lista");
    return listaPrivato.contains(scheda);
  }

  /// Crea la prima scheda di intervento per il comune
  void creaContrattoComune(int oreTotali, int valore) {
    ContrattoComune contratto = ContrattoComune(
      id: contrattoComune.id + 1,
      oreTotali: oreTotali,
      oreRimanenti: oreTotali,
      valoreContratto: valore,
    );
    contrattoComune = contratto;
    log("contratto comune creato");
  }

  bool creaContrattoPrivato(int oreTotali, int valore, String cliente) {
    ContrattoPrivato contratto;

    if (!listaContratto.any((element) => element.cliente == cliente)) {
      listaContratto.sort((a, b) => a.id.compareTo(b.id));
      contratto = ContrattoPrivato(
          listaContratto.last.id + 1, oreTotali, oreTotali, valore, cliente);
      listaContratto.add(contratto);
      log("contratto privato creato ed aggiunto alla lista");
      return true;
    } else {
      return false;
    }
  }

  bool creaSchedaPerContrattoPrivato(int durata, String data, String orario,
      String descrizione, String cliente) {
    ContrattoPrivato contratto =
    listaContratto.singleWhere((element) => element.cliente == cliente);
    int numeroScheda;

    if (contratto.listaSchede.isEmpty) {
      numeroScheda = 1;
    } else {
      numeroScheda = contratto.listaSchede.last.numeroScheda + 1;
    }

    SchedaPrivato scheda =
    SchedaPrivato.contratto(
        numeroScheda,
        contratto.id,
        durata,
        data,
        orario,
        descrizione,
        cliente);
    contratto.listaSchede.add(scheda);
    contratto.oreRimanenti = contratto.oreRimanenti - durata;
    log("scheda per contratto creata ed aggiunta alla lista");

    return contratto.listaSchede.contains(scheda);
  }

  void salvaContrattoComune() {
    _db.writeContrattoComune(contrattoComune);
  }

  void leggiContrattoComune() async {
    List<ContrattoComune> lista = await _db.readAllContrattoComune();
    lista.sort((a, b) => a.id.compareTo(b.id));
    contrattoComune = lista.last;
  }
}
