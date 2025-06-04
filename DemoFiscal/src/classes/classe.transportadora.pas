unit classe.transportadora;

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
  TTransportadora = class
  public
    class procedure TranspNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
  end;

implementation

class procedure TTransportadora.TranspNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConn;
    qry.SQL.Text := 'SELECT * FROM transportadora WHERE id_nfe = :id_nfe';
    qry.Open;

    with ACBr.NotasFiscais.Add.NFe.Transp do
    begin

      modFrete := mfContaEmitente;

      Transporta.CNPJCPF  := qry.FieldByName('CNPJCPF').AsString;
      Transporta.xNome    := qry.FieldByName('xNome').AsString;
      Transporta.IE       := qry.FieldByName('IE').AsString;
      Transporta.xEnder   := qry.FieldByName('xEnder').AsString;
      Transporta.xMun     := qry.FieldByName('xMun').AsString;
      Transporta.UF       := qry.FieldByName('UF').AsString;

      retTransp.vServ    := qry.FieldByName('vServ').AsCurrency;
      retTransp.vBCRet   := qry.FieldByName('vBCRet').AsCurrency;
      retTransp.pICMSRet := qry.FieldByName('pICMSRet').AsCurrency;
      retTransp.vICMSRet := qry.FieldByName('vICMSRet').AsCurrency;
      retTransp.CFOP     := qry.FieldByName('CFOP').AsString;
      retTransp.cMunFG   := qry.FieldByName('cMunFG').AsInteger;

      with ACBr.NotasFiscais.Add.NFe.Transp.Vol.New do
      begin
        qVol  := qry.FieldByName('qVol').AsInteger;
        esp   := qry.FieldByName('esp').AsString;
        marca := qry.FieldByName('marca').AsString;
        nVol  := qry.FieldByName('nVol').AsString;
        pesoL := qry.FieldByName('pesoL').AsCurrency;
        pesoB := qry.FieldByName('pesoB').AsCurrency;
      end;

    end;
  finally
    qry.Free;
  end;
end;
end.
