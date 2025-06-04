unit helper.nfe.impressao;

interface

uses
  ACBrNFe, ACBrNFeNotasFiscais, ACBrPosPrinter, ACBrNFeDANFeESCPOS, ACBrNFeDANFEClass, ACBrDANFCeFortesFr,
  ACBrDFeReport, ACBrDFeDANFeReport, ACBrNFeDANFeRLClass, ACBrBase, ACBrDFe,
  ACBrDANFCeFortesFrA4;

type
  TNFeImpressaoHelper = class helper for TACBrNFe
  public
    procedure ImprimirXML(const AArquivoXML: String; MostrarPreview: Boolean = True);
  end;

implementation

uses
  ACBrNFeDANFeRL, SysUtils;

procedure TNFeImpressaoHelper.ImprimirXML(const AArquivoXML: String; MostrarPreview: Boolean);
begin
  NotasFiscais.Clear;
  NotasFiscais.LoadFromFile(AArquivoXML);
  NotasFiscais.Imprimir
end;

end.

