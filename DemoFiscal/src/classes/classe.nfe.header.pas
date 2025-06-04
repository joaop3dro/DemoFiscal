unit classe.nfe.header;

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
  TNFeHeader = class
  public
    class procedure HeaderNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
  end;

implementation

uses
  System.SysUtils;

class procedure TNFeHeader.HeaderNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConn;
    qry.SQL.Text := 'SELECT * FROM notas WHERE id = :id';
    qry.ParamByName('id').AsInteger := IDNota;
    qry.Open;

    with ACBr.NotasFiscais.Add.NFe do
    begin
      ide.natOp := qry.FieldByName('natureza_operacao').AsString;
      ide.indPag :=  ipVista;
      ide.modelo := 55;
      ide.serie := qry.FieldByName('serie').AsInteger;
      ide.nNF := qry.FieldByName('numero').AsInteger;
      Ide.nNF       := StrToInt(qry.FieldByName('numero').AsString);
      Ide.cNF       := GerarCodigoDFe(Ide.nNF);
      Ide.dEmi      := Date;
      Ide.dSaiEnt   := Date;
      Ide.hSaiEnt   := Now;
      Ide.tpNF      := tnSaida;
      Ide.tpEmis    := TpcnTipoEmissao(0);
      Ide.tpAmb     := taHomologacao;
      Ide.verProc   := '1.0.0.0';
      Ide.cUF       := UFtoCUF('ES');
      Ide.cMunFG    := StrToInt(qry.FieldByName('cod_municipio').AsString);
      Ide.finNFe    := fnNormal;

      if Assigned(ACBr.DANFE) then
        Ide.tpImp := ACBr.DANFE.TipoDANFE;

      ide.verProc := '1.0';
    end;
  finally
    qry.Free;
  end;
end;

end.