unit classe.destinatario;

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
  TDestinatario = class
  public
    class procedure DestNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
  end;

implementation

class procedure TDestinatario.DestNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConn;
    qry.SQL.Text := 'SELECT * FROM destinatario WHERE id_nfe = :id_nfe';
    qry.Open;

    with ACBr.NotasFiscais.Add.NFe.Dest do
    begin

      CNPJCPF           := qry.FieldByName('CNPJCPF').AsString;
      IE                := qry.FieldByName('IE').AsString;
      ISUF              := qry.FieldByName('ISUF').AsString;
      xNome             := qry.FieldByName('xNome').AsString;

      EnderDest.Fone    := qry.FieldByName('Fone').AsString;
      EnderDest.CEP     := qry.FieldByName('CEP').AsInteger;
      EnderDest.xLgr    := qry.FieldByName('xLgr').AsString;
      EnderDest.nro     := qry.FieldByName('nro').AsString;;
      EnderDest.xCpl    := qry.FieldByName('xCpl').AsString;
      EnderDest.xBairro := qry.FieldByName('xBairro').AsString;
      EnderDest.cMun    := qry.FieldByName('cMun').AsInteger;
      EnderDest.xMun    := qry.FieldByName('xMun').AsString;
      EnderDest.UF      := qry.FieldByName('UF').AsString;
      EnderDest.cPais   := 1058;
      EnderDest.xPais   := 'BRASIL';
    end;
  finally
    qry.Free;
  end;
end;
end.
