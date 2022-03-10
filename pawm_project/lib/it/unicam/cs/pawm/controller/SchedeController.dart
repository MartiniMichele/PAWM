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

    int lastNumero;

    if(contrattoComune.listaSchede.isEmpty) { lastNumero = 0; }
    else {
      lastNumero = contrattoComune.listaSchede.last.numeroIntervento;
    contrattoComune.listaSchede.sort((a, b) =>
        a.numeroIntervento.compareTo(b.numeroIntervento));
    }

    SchedaComune scheda = SchedaComune(
        numeroIntervento: lastNumero + 1,
        idContratto: contrattoComune.id,
        durata: oreIntervento,
        ufficio: ufficio,
        data: data,
        orario: orario,
        descrizione: descrizione);


    contrattoComune.listaSchede.add(scheda);
    contrattoComune.oreRimanenti =
        contrattoComune.oreRimanenti - oreIntervento;
    ///salva scheda nel DB ed aggiorna il contratto
    salvaSchedaComune(scheda);
    aggiornaContrattoComune();
    log("Scheda comune creata e aggiunta al contratto");
    return contrattoComune.listaSchede.contains(scheda);
  }

  /// Crea una scheda intervento per un privato, l'ID contratto 0 rappresenta l'assenza di contratto
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
        numeroScheda: lastNumero,
        idContratto: 0,
        durataIntervento: durata,
        data: data,
        orario: orario,
        descrizione: descrizione,
        cliente: cliente);

    ///salva la scheda nel DB
    salvaSchedaPrivato(scheda);
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
    ///salva il contratto nel DB
    salvaContrattoComune();
    log("contratto comune creato");
  }

  ///crea un contratto per un privato
  bool creaContrattoPrivato(int oreTotali, int valore, String cliente) {
    ContrattoPrivato contratto;

    if (!listaContratto.any((element) => element.cliente == cliente)) {
      listaContratto.sort((a, b) => a.id.compareTo(b.id));
      contratto = ContrattoPrivato(id: listaContratto.last.id + 1,
          oreTotali: oreTotali,
          oreRimanenti: oreTotali,
          valoreContratto: valore,
          cliente: cliente);

      ///salva il contratto nel DB
      salvaContrattoPrivato(contratto);
      listaContratto.add(contratto);
      log("contratto privato creato ed aggiunto alla lista");
      return true;
    } else {
      return false;
    }
  }

  ///crea una scheda per un contratto, con ID associato
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
    SchedaPrivato(numeroScheda: numeroScheda, idContratto: contratto.id,
        durataIntervento: durata,
        data: data,
        orario: orario,
        descrizione: descrizione,
        cliente: cliente);

    ///salva la scheda nel DB
    salvaSchedaPrivatoContratto(scheda);
    contratto.listaSchede.add(scheda);
    contratto.oreRimanenti = contratto.oreRimanenti - durata;
    log("scheda per contratto creata ed aggiunta alla lista");

    return contratto.listaSchede.contains(scheda);
  }

  void salvaContrattoComune() {
     _db.writeContrattoComune(contrattoComune);
  }

  void salvaSchedaComune(SchedaComune scheda) {
    _db.writeSchedaComune(scheda);
  }

  void salvaSchedaPrivato(SchedaPrivato scheda)  {
    _db.writeSchedaPrivato(scheda);
  }

  void salvaSchedaPrivatoContratto(SchedaPrivato scheda) {
    _db.writeSchedaPrivatoContratto(scheda);
  }

  void salvaContrattoPrivato(ContrattoPrivato contratto)  {
    _db.writeContrattoPrivato(contratto);
  }

  void leggiContrattoComune() async {
    List<ContrattoComune> lista = await _db.readAllContrattoComune();
    lista.sort((a, b) => a.id.compareTo(b.id));
    contrattoComune = lista.last;
  }

  void leggiSchedeComune() async {
    List<SchedaComune> lista = await _db.readAllSchedaComune(contrattoComune.id);
    lista.sort((a, b) => a.numeroIntervento.compareTo(b.numeroIntervento));

    contrattoComune.listaSchede.addAll(lista);
  }

  void leggiSchedePrivato() async {
    List<SchedaPrivato> lista = await _db.readAllSchedaPrivato(0);
    lista.sort((a, b) => a.numeroScheda.compareTo(b.numeroScheda));

    listaPrivato.addAll(lista);
  }

  void leggiSchedePrivatoContratto(int id) async {
    List<SchedaPrivato> lista = await _db.readAllSchedaPrivatoContratto(id);
    lista.sort((a, b) => a.numeroScheda.compareTo(b.numeroScheda));

    listaContratto.firstWhere((element) => element.id == id).listaSchede.addAll(lista);
  }

  void leggiContrattoPrivato() async {
    List<ContrattoPrivato> lista = await _db.readAllContrattoPrivato();
    lista.sort((a, b) => a.id.compareTo(b.id));

    listaContratto.addAll(lista);
  }

  void aggiornaContrattoComune() async {
    await _db.updateContrattoComune(contrattoComune);
  }

  void aggiornaContrattoPrivato(int id) async {
    await _db.updateContrattoPrivato(listaContratto.firstWhere((element) => element.id == id));
  }

  void inizializzaComune() {
    leggiContrattoComune();
    leggiSchedeComune();
  }

  void inizializzaPrivato() {
    leggiContrattoPrivato();
    leggiSchedePrivato();
    for (var element in listaContratto) {
      leggiSchedePrivatoContratto(element.id);
    }
  }
}
