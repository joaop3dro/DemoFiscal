unit classe.itens;

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
  TItens = class
  public
    class procedure ItensNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
  end;

implementation

class procedure TItens.ItensNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
var
  qry: TFDQuery;
  i: integer;
begin
  i := 1;

  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConn;
    qry.SQL.Text := 'SELECT * FROM nfe_itens WHERE id_nfe = :id_nfe';
    qry.Open;

    while not qry.Eof do
    begin

      with ACBr.NotasFiscais.Add.NFe.Det.New do
      begin

        Prod.nItem    := i;
        Prod.cProd    := qry.FieldByName('cProd').AsString;
        Prod.cEAN     := qry.FieldByName('cEAN').AsString;
        Prod.xProd    := qry.FieldByName('xProd').AsString;
        Prod.NCM      := qry.FieldByName('NCM').AsString;
        Prod.EXTIPI   := qry.FieldByName('EXTIPI').AsString;
        Prod.CFOP     := qry.FieldByName('CFOP').AsString;
        Prod.uCom     := qry.FieldByName('uCom').AsString;
        Prod.qCom     := qry.FieldByName('qCom').AsCurrency;
        Prod.vUnCom   := qry.FieldByName('vUnCom').AsCurrency;
        Prod.vProd    := qry.FieldByName('vProd').AsCurrency;

        Prod.cEANTrib  := qry.FieldByName('cEANTrib').AsString;
        Prod.uTrib     := qry.FieldByName('uTrib').AsString;
        Prod.qTrib     := qry.FieldByName('qTrib').AsCurrency;
        Prod.vUnTrib   := qry.FieldByName('vUnTrib').AsCurrency;

        Prod.vOutro    := qry.FieldByName('vOutro').AsCurrency;
        Prod.vFrete    := qry.FieldByName('vFrete').AsCurrency;
        Prod.vSeg      := qry.FieldByName('vSeg').AsCurrency;
        Prod.vDesc     := qry.FieldByName('vDesc').AsCurrency;

        infAdProd := qry.FieldByName('infAdProd').AsString;

        inc(i)

      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;
end.
