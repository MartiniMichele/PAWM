import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';

class SchedaController {

  static final SchedaController _singleton = SchedaController._internal();
  List<SchedaComune> listaComune = <SchedaComune>[];
  List<SchedaPrivato> listaPrivato = <SchedaPrivato>[];
  List<ContrattoPrivato> listaContratto = <ContrattoPrivato>[];

  /// Singleton
  factory SchedaController() {
    return _singleton;
  }
  SchedaController._internal();

///  Crea una scheda intervento per il comune
bool creaSchedaComune(int oreIntervento, String ufficio, String data, String orario, String descrizione) {

  listaComune.sort((a, b) => a.numeroIntervento.compareTo(b.numeroIntervento));
  SchedaComune scheda = SchedaComune(
      listaComune.last.numeroIntervento + 1,
      listaComune.last.numeroOre - oreIntervento,
      ufficio, data, orario, descrizione);
  listaComune.add(scheda);
  log("Scheda comune creata e aggiunta alla lista");
  return listaComune.contains(scheda);
}


/// Crea una scheda intervento per un privato
bool creaSchedaPrivato (int durata, String data, String orario, String descrizione, String cliente) {

  listaPrivato.sort((a, b) => a.numeroScheda.compareTo(b.numeroScheda));
  SchedaPrivato scheda = SchedaPrivato(
      listaPrivato.last.numeroScheda + 1,
      durata, data, orario, descrizione, cliente);
  listaPrivato.add(scheda);
log("Scheda privato creata e aggiunta alla lista");
  return listaPrivato.contains(scheda);
}

/// Crea la prima scheda di intervento per il comune
bool creaPrimaSchedaComune(int numeroIntervento, int ore, String ufficio,  String data, String orario, String descrizione) {

  SchedaComune scheda = SchedaComune(numeroIntervento, ore, ufficio, data, orario, descrizione);
  listaComune.add(scheda);
  log("scheda comune creata ed aggiunta alla lista");
  return listaComune.contains(scheda);
}

bool creaPrimaSchedaPrivato(int numeroIntervento, int durata,  String data, String orario, String descrizione, String cliente) {

  SchedaPrivato scheda = SchedaPrivato(numeroIntervento, durata, data, orario, descrizione, cliente);

  listaPrivato.add(scheda);
  log("scheda privato creata ed aggiunta alla lista");
  return listaPrivato.contains(scheda);
}

bool creaContrattoPrivato(int oreTotali, int valore, String cliente) {

  ContrattoPrivato? contratto;

  if (!listaContratto.any((element) => element.cliente == cliente)) {

    contratto = ContrattoPrivato(oreTotali, oreTotali, valore, cliente);
    listaContratto.add(contratto);
    log("contratto privato creato ed aggiunto alla lista");
    return true;
  }
  else { return false; }
}

bool creaSchedaPerContrattoPrivato(int durata, String data, String orario, String descrizione, String cliente) {
  
  ContrattoPrivato contratto = listaContratto.singleWhere((element) => element.cliente == cliente);
  int numeroScheda;

  if (contratto.listaSchede.isEmpty) { numeroScheda = 1; }

  else { numeroScheda = contratto.listaSchede.last.numeroScheda + 1; }

  SchedaPrivato scheda = SchedaPrivato(numeroScheda, durata, data, orario, descrizione, cliente);
  contratto.listaSchede.add(scheda);
  contratto.oreRimanenti = contratto.oreRimanenti - durata;

  return contratto.listaSchede.contains(scheda);
}

//TODO aggiungere salvataggio in DBMS

}