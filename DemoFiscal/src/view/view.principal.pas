unit view.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, ACBrBase,
  ACBrDFe, ACBrNFe, ACBrDFeReport, ACBrDFeDANFeReport, ACBrNFeDANFEClass,
  ACBrNFeDANFEFR, Vcl.ComCtrls, classe.venda.dao, classe.venda;

type
  TForm2 = class(TForm)
    btnSimular: TButton;
    ACBrNFe1: TACBrNFe;
    Button1: TButton;
    ACBrNFeDANFEFR1: TACBrNFeDANFEFR;
    btnSalvar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edCNPJ: TEdit;
    edRazaoSocial: TEdit;
    edNomeFantasia: TEdit;
    edEndereco: TEdit;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edDestCNPJ: TEdit;
    edDestRazaoSocial: TEdit;
    edDestNomeFantasia: TEdit;
    edDestEndereco: TEdit;
    TabSheet3: TTabSheet;
    GridProdutos: TStringGrid;
    btnAdicionarProduto: TButton;
    TabSheet4: TTabSheet;
    edValorProdutos: TEdit;
    edValorFrete: TEdit;
    edValorDesconto: TEdit;
    edValorICMS: TEdit;
    edValorIPI: TEdit;
    edValorTotal: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    procedure btnSimularClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    FVendaDAO: TVendaDAO;
    FVenda: TVenda;
    procedure CalcularTotais;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses classe.nfe.composer, model.con, helper.nfe.impressao;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ACBrNFeDANFEFR1.FastFile := 'C:\Desenvolvimento\DemoFiscal\DemoFiscal\src\Report\NFe\DANFeRetrato.fr3';
  ACBrNFe1.ImprimirXML('CAMINHO DO XML');
end;

procedure TForm2.CalcularTotais;
var
  I: Integer;
  ValorProdutos, ValorFrete, ValorDesconto: Double;
begin
  ValorProdutos := 0;
  for I := 1 to GridProdutos.RowCount -1 do
  begin
    if not GridProdutos.Cells[4, I].IsEmpty then
      ValorProdutos := ValorProdutos + StrToFloat(GridProdutos.Cells[4, I]);
  end;

  // Atualizar campos
  edValorProdutos.Text := FormatFloat('###,##0.00', ValorProdutos);
  edValorFrete.Text := FormatFloat('###,##0.00', 0); // Frete fixo
  edValorDesconto.Text := FormatFloat('###,##0.00', 0); // Desconto fixo
  edValorICMS.Text := FormatFloat('###,##0.00', ValorProdutos * 0.18); // 18% de ICMS
  edValorIPI.Text := FormatFloat('###,##0.00', ValorProdutos * 0.05); // 5% de IPI
  edValorTotal.Text := FormatFloat('###,##0.00',
    ValorProdutos +
    StrToFloat(edValorFrete.Text) -
    StrToFloat(edValorDesconto.Text));
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FVendaDAO := TVendaDAO.Create;
  FVenda := TVenda.Create;

  // Configurar grid de produtos
  GridProdutos.Cells[0, 0] := 'C'#243'digo';
  GridProdutos.Cells[1, 0] := 'Descri'#231#227'o';
  GridProdutos.Cells[2, 0] := 'Quantidade';
  GridProdutos.Cells[3, 0] := 'Valor Unit.';
  GridProdutos.Cells[4, 0] := 'Valor Total';
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FVenda.Free;
  FVendaDAO.Free;
end;

procedure TForm2.btnAdicionarProdutoClick(Sender: TObject);
var
  i: integer;
begin
  i := 1;
  // Adicionar produto mockado
  with GridProdutos do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount - 1] := 'PROD00' + i.ToString; // Código
    Cells[1, RowCount - 1] := 'Produto Teste'; // Descrição
    Cells[2, RowCount - 1] := '1'; // Quantidade
    Cells[3, RowCount - 1] := '100,00'; // Valor Unitário
    Cells[4, RowCount - 1] := '100,00'; // Valor Total
  end;

  inc(i);

  CalcularTotais;
end;

procedure TForm2.btnSalvarClick(Sender: TObject);
var
  Produto: TProduto;
  I: Integer;
begin
  // Configurar emitente
  FVenda.Emitente.CNPJ := edCNPJ.Text;
  FVenda.Emitente.RazaoSocial := edRazaoSocial.Text;
  FVenda.Emitente.NomeFantasia := edNomeFantasia.Text;
  FVenda.Emitente.Endereco.Logradouro := edEndereco.Text;

  // Configurar destinatário
  FVenda.Destinatario.CNPJ := edDestCNPJ.Text;
  FVenda.Destinatario.RazaoSocial := edDestRazaoSocial.Text;
  FVenda.Destinatario.NomeFantasia := edDestNomeFantasia.Text;
  FVenda.Destinatario.Endereco.Logradouro := edDestEndereco.Text;

  // Configurar produtos
  for I := 1 to GridProdutos.RowCount - 1 do
  begin
    Produto := TProduto.Create;
    Produto.Codigo := GridProdutos.Cells[0, I];
    Produto.Descricao := GridProdutos.Cells[1, I];

    if not GridProdutos.Cells[2, I].IsEmpty then
    begin
      Produto.Quantidade := StrToFloat(GridProdutos.Cells[2, I]);
      Produto.ValorUnitario := StrToFloat(GridProdutos.Cells[3, I]);
      Produto.ValorTotal := StrToFloat(GridProdutos.Cells[4, I]);
    end;

    FVenda.AddProduto(Produto);
  end;

  // Configurar totais
  FVenda.Totais.ValorProdutos := StrToFloat(edValorProdutos.Text);
  FVenda.Totais.ValorFrete := StrToFloat(edValorFrete.Text);
  FVenda.Totais.ValorDesconto := StrToFloat(edValorDesconto.Text);
  FVenda.Totais.ValorICMS := StrToFloat(edValorICMS.Text);
  FVenda.Totais.ValorIPI := StrToFloat(edValorIPI.Text);
  FVenda.Totais.ValorTotalNota := StrToFloat(edValorTotal.Text);

  try
    // Salvar venda
    FVendaDAO.SaveVenda(FVenda);
    ShowMessage('Venda salva com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao salvar venda: ' + E.Message);
  end;
end;

procedure TForm2.btnSimularClick(Sender: TObject);
var
  Composer: TNFeComposer;
begin
  ACBrNFe1.NotasFiscais.Clear;
  Composer := TNFeComposer.Create(1, ACBrNFe1, FVendaDAO.FConnection);

  try
    Composer.MontarNFe;
    ACBrNFe1.NotasFiscais.GravarXML;
    ShowMessage('NFe gerada com sucesso.');
  finally
    Composer.Free;
  end;
end;

end.

