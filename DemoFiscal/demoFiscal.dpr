program demoFiscal;

uses
  Vcl.Forms,
  view.principal in 'src\view\view.principal.pas' {Form2},
  classe.destinatario in 'src\classes\classe.destinatario.pas',
  classe.emitente in 'src\classes\classe.emitente.pas',
  classe.imposto in 'src\classes\classe.imposto.pas',
  classe.itens in 'src\classes\classe.itens.pas',
  classe.nfe.composer in 'src\classes\classe.nfe.composer.pas',
  classe.nfe.header in 'src\classes\classe.nfe.header.pas',
  classe.totais in 'src\classes\classe.totais.pas',
  classe.transportadora in 'src\classes\classe.transportadora.pas',
  model.con in 'src\model\model.con.pas' {dmCon: TDataModule},
  helper.nfe.impressao in 'src\helpers\helper.nfe.impressao.pas',
  classe.venda in 'src\classes\classe.venda.pas',
  classe.venda.dao in 'src\classes\classe.venda.dao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TdmCon, dmCon);
  Application.Run;
end.
