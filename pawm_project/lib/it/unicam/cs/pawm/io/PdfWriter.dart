import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfWriter {
  late SchedaPrivato _schedaPrivato;
  late SchedaComune _schedaComune;
  late ContrattoPrivato _contrattoPrivato;

  PdfWriter.privato(this._schedaPrivato);

  PdfWriter.comune(this._schedaComune);

  PdfWriter.contratto(this._contrattoPrivato);

  pdfSchedaComune() {
    final pdf = pw.Document();
    final numero = pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Container(
          child: pw.Column(children: [
        pw.Text(
            "Numero intervento:" + (_schedaComune.numeroIntervento).toString()), pw.Text(
                "Durata intervento:" + (_schedaComune.numeroOre).toString()),
      ]));
    }));
    pdf.save();
  }
}
