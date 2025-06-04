unit classe.nfe.composer;

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
  TNFeComposer = class
  private
    FIDNota: Integer;
    FACBr: TACBrNFe;
    FDConn: TFDConnection;
  public
    constructor Create(IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
    procedure MontarNFe;
  end;

implementation

uses classe.destinatario, classe.emitente, classe.imposto, classe.itens,
  classe.nfe.header, classe.totais, classe.transportadora;


constructor TNFeComposer.Create(IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
begin
  FIDNota := IDNota;
  FACBr := ACBr;
  FDConn := AConn;
end;

procedure TNFeComposer.MontarNFe;
begin
  TNFeHeader.HeaderNfe(FIDNota, FACBr, FDConn);
  TEmitente.EmitNfe(FIDNota, FACBr, FDConn);
  TDestinatario.DestNfe(FIDNota, FACBr, FDConn);
  TItens.ItensNfe(FIDNota, FACBr, FDConn);
  TTransportadora.TranspNfe(FIDNota, FACBr, FDConn);
  TImposto.impNfe(FIDNota, FACBr, FDConn);
  TTotais.TotaisNfe(FIDNota, FACBr, FDConn);
end;

end.