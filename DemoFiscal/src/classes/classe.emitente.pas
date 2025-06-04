unit classe.emitente;

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
  TEmitente = class
  public
    class procedure EmitNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
  end;

implementation

class procedure TEmitente.EmitNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConn;
    qry.SQL.Text := 'SELECT * FROM emitente WHERE id_nfe = :id_nfe';
    qry.Open;

    with ACBr.NotasFiscais.Add.NFe.emit do
    begin

      CNPJCPF := qry.FieldByName('cnpj').AsString;
      xNome := qry.FieldByName('razao').AsString;
      xFant := qry.FieldByName('fantasia').AsString;
      enderEmit.xLgr := qry.FieldByName('logradouro').AsString;
      enderEmit.nro := qry.FieldByName('numero').AsString;
      enderEmit.xBairro := qry.FieldByName('bairro').AsString;
      enderEmit.cMun := qry.FieldByName('codigo_municipio').AsInteger;
      enderEmit.xMun := qry.FieldByName('municipio').AsString;
      enderEmit.UF := qry.FieldByName('uf').AsString;
      enderEmit.CEP := qry.FieldByName('cep').AsInteger;
      IE := qry.FieldByName('ie').AsString;

    end;
  finally
    qry.Free;
  end;
end;
end.