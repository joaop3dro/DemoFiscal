unit classe.totais;

interface

uses ACBrBase, ACBrDFe, ACBrNFe, ACBrUtil.Base, ACBrUtil.FilesIO, ACBrUtil.DateTime, ACBrUtil.Strings,
     ACBrNFe.Classes, pcnConversao, pcnConversaoNFe, pcnNFeRTXT, pcnRetConsReciDFe,
     ACBrDFeConfiguracoes, ACBrDFeSSL, ACBrDFeOpenSSL, ACBrDFeUtil,
     ACBrNFeNotasFiscais, ACBrNFeConfiguracoes,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TTotais = class
  public
    class procedure TotaisNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
  end;

implementation

class procedure TTotais.TotaisNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConn;
    qry.SQL.Text := 'SELECT * FROM totais_nfe WHERE id_nfe = :id_nfe';
    qry.Open;

    with ACBr.NotasFiscais.Add.NFe.Total do
    begin

      ICMSTot.vBC     := qry.FieldByName('vBC').AsCurrency;
      ICMSTot.vICMS   := qry.FieldByName('vICMS').AsCurrency;
      ICMSTot.vBCST   := qry.FieldByName('vBCST').AsCurrency;
      ICMSTot.vST     := qry.FieldByName('vST').AsCurrency;
      ICMSTot.vProd   := qry.FieldByName('vProd').AsCurrency;
      ICMSTot.vFrete  := qry.FieldByName('vFrete').AsCurrency;
      ICMSTot.vSeg    := qry.FieldByName('vSeg').AsCurrency;
      ICMSTot.vDesc   := qry.FieldByName('vDesc').AsCurrency;
      ICMSTot.vII     := qry.FieldByName('vII').AsCurrency;
      ICMSTot.vIPI    := qry.FieldByName('vIPI').AsCurrency;
      ICMSTot.vPIS    := qry.FieldByName('vPIS').AsCurrency;
      ICMSTot.vCOFINS := qry.FieldByName('vCOFINS').AsCurrency;
      ICMSTot.vOutro  := qry.FieldByName('vOutro').AsCurrency;
      ICMSTot.vNF     := qry.FieldByName('vNF').AsCurrency;

      // partilha do icms e fundo de probreza
      ICMSTot.vFCPUFDest   := qry.FieldByName('vFCPUFDest').AsCurrency;
      ICMSTot.vICMSUFDest  := qry.FieldByName('vICMSUFDest').AsCurrency;
      ICMSTot.vICMSUFRemet := qry.FieldByName('vICMSUFRemet').AsCurrency;

      ISSQNtot.vServ   := qry.FieldByName('vServ').AsCurrency;
      ISSQNTot.vBC     := qry.FieldByName('vBC').AsCurrency;
      ISSQNTot.vISS    := qry.FieldByName('vISS').AsCurrency;
      ISSQNTot.vPIS    := qry.FieldByName('vPIS').AsCurrency;
      ISSQNTot.vCOFINS := qry.FieldByName('vCOFINS').AsCurrency;

      retTrib.vRetPIS    := qry.FieldByName('vRetPIS').AsCurrency;
      retTrib.vRetCOFINS := qry.FieldByName('vRetCOFINS').AsCurrency;
      retTrib.vRetCSLL   := qry.FieldByName('vRetCSLL').AsCurrency;
      retTrib.vBCIRRF    := qry.FieldByName('vBCIRRF').AsCurrency;
      retTrib.vIRRF      := qry.FieldByName('vIRRF').AsCurrency;
      retTrib.vBCRetPrev := qry.FieldByName('vBCRetPrev').AsCurrency;
      retTrib.vRetPrev   := qry.FieldByName('vRetPrev').AsCurrency;
    end;
  finally
    qry.Free;
  end;
end;
end.
