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
  Future<bool> creaSchedaComune(int oreIntervento, String ufficio, String data,
      String orario, String descrizione) async {

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
    _salvaSchedaComune(scheda);
    await _aggiornaContrattoComune();
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
        numeroScheda: lastNumero + 1,
        idContratto: 0,
        durataIntervento: durata,
        data: data,
        orario: orario,
        descrizione: descrizione,
        cliente: cliente);

    ///salva la scheda nel DB
    _salvaSchedaPrivato(scheda);
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
    _salvaContrattoComune();
    log("contratto comune creato");
  }

  ///crea un contratto per un privato
  bool creaContrattoPrivato(int oreTotali, int valore, String cliente) {

    ContrattoPrivato contratto;
    int lastId;

    if(listaContratto.isEmpty) {
      lastId = 0;
    } else {
      lastId = listaContratto.last.id;
    }

    if (!listaContratto.any((element) => element.cliente == cliente)) {
      listaContratto.sort((a, b) => a.id.compareTo(b.id));
      contratto = ContrattoPrivato(id: lastId + 1,
          oreTotali: oreTotali,
          oreRimanenti: oreTotali,
          valoreContratto: valore,
          cliente: cliente);

      ///salva il contratto nel DB
      _salvaContrattoPrivato(contratto);
      listaContratto.add(contratto);
      log("contratto privato creato ed aggiunto alla lista");
      return true;
    } else {
      return false;
    }
  }

  ///crea una scheda per un contratto, con ID associato
  Future<bool> creaSchedaPerContrattoPrivato(int durata, String data, String orario,
      String descrizione, String cliente) async {
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


    contratto.listaSchede.add(scheda);
    contratto.oreRimanenti = contratto.oreRimanenti - durata;
    ///salva la scheda nel DB ed aggiorna il contratto
    _salvaSchedaPrivatoContratto(scheda);
    await _aggiornaContrattoPrivato(contratto.id);

    log("scheda per contratto creata ed aggiunta alla lista");

    return contratto.listaSchede.contains(scheda);
  }

  ///metodo per aggiornare i dati di una scheda comune, corregge anche il conto delle ore rimanenti del contratto
  Future<void> correggiSchedaComune(int numeroScheda, int durata, String ufficio, String descrizione) async {
    SchedaComune scheda = contrattoComune.listaSchede.firstWhere((element) => element.numeroIntervento == numeroScheda);
    int differenzaOre;

    if(scheda.durata > durata) {
      differenzaOre = scheda.durata - durata;
      scheda.durata = durata;
      contrattoComune.oreRimanenti = contrattoComune.oreRimanenti + differenzaOre;
    }
    if(scheda.durata < durata) {
      differenzaOre = durata - scheda.durata;
      scheda.durata = durata;
      contrattoComune.oreRimanenti = contrattoComune.oreRimanenti - differenzaOre;
    }

    scheda.ufficio = ufficio;
    scheda.descrizione = descrizione;
    await _aggiornaSchedaComune(scheda);
    await _aggiornaContrattoComune();
  }

  ///metodo per aggiornare una scheda privato
  Future<void> correggiSchedaPrivato(int numeroScheda, int durata, String descrizione, String cliente) async {
    SchedaPrivato scheda = listaPrivato.firstWhere((element) => element.numeroScheda == numeroScheda);
    scheda.durataIntervento = durata;
    scheda.descrizione = descrizione;
    scheda.cliente = cliente;

    await _aggiornaSchedaPrivato(scheda);
  }

  ///metodo per aggiornare una scheda privato per contratto
  Future<void> correggiSchedaPrivatoContratto(int numeroScheda, int idContratto, int durata, String descrizione) async {
    ContrattoPrivato contratto = listaContratto.firstWhere((element) => element.id == idContratto);
    SchedaPrivato scheda = contratto.listaSchede.firstWhere((element) => element.numeroScheda == numeroScheda);

    int differenzaOre;

    if(scheda.durataIntervento > durata) {
      differenzaOre = scheda.durataIntervento - durata;
      scheda.durataIntervento = durata;
      contratto.oreRimanenti = contratto.oreRimanenti + differenzaOre;
    }
    if(scheda.durataIntervento < durata) {
      differenzaOre = durata - scheda.durataIntervento;
      scheda.durataIntervento = durata;
      contratto.oreRimanenti = contratto.oreRimanenti - differenzaOre;
    }

    scheda.descrizione = descrizione;
    await _aggiornaSchedaPrivato(scheda);
    await _aggiornaContrattoPrivato(idContratto);
  }

  Future<void> rinnovaContrattoPrivato(String cliente, int oreTotali, int valore) async {

    ContrattoPrivato contratto = listaContratto.firstWhere((element) => element.cliente == cliente);
    contratto.oreTotali = oreTotali;
    contratto.oreRimanenti = oreTotali;
    contratto.valoreContratto = valore;

    await _aggiornaContrattoPrivato(contratto.id);
  }

  List<String> clientiContratti() {
    List<String> lista = [];

    for (var element in listaContratto) {
      lista.add(element.cliente);
    }

    return lista;
  }

  List<SchedaPrivato> schedeContratti() {
    List<SchedaPrivato> lista = [];

    for(var element in listaContratto) {
      lista.addAll(element.listaSchede);
    }

    return lista;
  }

  void _salvaContrattoComune() {
     _db.writeContrattoComune(contrattoComune);
  }

  void _salvaSchedaComune(SchedaComune scheda) {
    _db.writeSchedaComune(scheda);
  }

  void _salvaSchedaPrivato(SchedaPrivato scheda)  {
    _db.writeSchedaPrivatoContratto(scheda);
  }

  void _salvaSchedaPrivatoContratto(SchedaPrivato scheda) {
    _db.writeSchedaPrivatoContratto(scheda);
  }

  void _salvaContrattoPrivato(ContrattoPrivato contratto)  {
    _db.writeContrattoPrivato(contratto);
  }

  Future<void> leggiContrattoComune() async {
    List<ContrattoComune> lista = await _db.readAllContrattoComune();
    lista.sort((a, b) => a.id.compareTo(b.id));
    contrattoComune = lista.last;
  }

  Future<void> leggiSchedeComune() async {
    List<SchedaComune> lista = await _db.readAllSchedaComune(contrattoComune.id);
    lista.sort((a, b) => a.numeroIntervento.compareTo(b.numeroIntervento));

    contrattoComune.listaSchede.addAll(lista);
  }

  Future<void> leggiContrattoPrivato() async{
    List<ContrattoPrivato> lista = await _db.readAllContrattoPrivato();
    lista.sort((a, b) => a.id.compareTo(b.id));

    listaContratto.addAll(lista);
  }

  Future<void> leggiSchedePrivatoContratto(int id) async {
    List<SchedaPrivato> lista = await _db.readAllSchedaPrivatoContratto(id);
    lista.sort((a, b) => a.numeroScheda.compareTo(b.numeroScheda));

    if(id == 0) {
      listaPrivato.addAll(lista);
    }
    else {
      listaContratto.firstWhere((element) => element.id == id).listaSchede.addAll(lista);
    }

  }

  Future<void> _aggiornaContrattoComune() async {
    await _db.updateContrattoComune(contrattoComune);
  }

  Future<void> _aggiornaContrattoPrivato(int id) async {
    await _db.updateContrattoPrivato(listaContratto.firstWhere((element) => element.id == id));
  }

  Future<void> _aggiornaSchedaComune(SchedaComune scheda) async {
    await _db.updateSchedaComune(scheda);
  }

  Future<void> _aggiornaSchedaPrivato(SchedaPrivato scheda) async {
    await _db.updateSchedaPrivato(scheda);
  }

  Future<void> inizializzaComune() async {
    await leggiContrattoComune();
    await leggiSchedeComune();
  }

  Future<void> inizializzaPrivato() async {
    await leggiSchedePrivatoContratto(0);
  }

  Future<void> inizializzaPrivatoContratto() async {
    await leggiContrattoPrivato();

    for (var element in listaContratto) {
      await leggiSchedePrivatoContratto(element.id);
    }
  }
}
