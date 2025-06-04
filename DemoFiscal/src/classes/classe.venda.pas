unit classe.venda;

interface

uses
  System.SysUtils, System.Classes, system.Generics.Collections;

type
  // Classe base para endereços
  TEndereco = class
  private
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FEstado: string;
    FCEP: string;
  public
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property CEP: string read FCEP write FCEP;
  end;

  // Classe para emitente
  TEmitente = class
  private
    FCNPJ: string;
    FIE: string;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FEndereco: TEndereco;
    FTelefone: string;
    FEmail: string;
  public
    constructor Create;
    destructor Destroy; override;
    property CNPJ: string read FCNPJ write FCNPJ;
    property IE: string read FIE write FIE;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property Endereco: TEndereco read FEndereco;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
  end;

  // Classe para destinatário
  TDestinatario = class
  private
    FCNPJ: string;
    FIE: string;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FEndereco: TEndereco;
    FTelefone: string;
    FEmail: string;
  public
    constructor Create;
    destructor Destroy; override;
    property CNPJ: string read FCNPJ write FCNPJ;
    property IE: string read FIE write FIE;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property Endereco: TEndereco read FEndereco;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
  end;

  // Classe para produto
  TProduto = class
  private
    FCodigo: string;
    FDescricao: string;
    FNCM: string;
    FCEST: string;
    FCFOP: string;
    FUnidade: string;
    FQuantidade: Double;
    FValorUnitario: Double;
    FValorTotal: Double;
    FAliquotaICMS: Double;
    FValorICMS: Double;
    FAliquotaIPI: Double;
    FValorIPI: Double;
  public
    property Codigo: string read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property NCM: string read FNCM write FNCM;
    property CEST: string read FCEST write FCEST;
    property CFOP: string read FCFOP write FCFOP;
    property Unidade: string read FUnidade write FUnidade;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property AliquotaICMS: Double read FAliquotaICMS write FAliquotaICMS;
    property ValorICMS: Double read FValorICMS write FValorICMS;
    property AliquotaIPI: Double read FAliquotaIPI write FAliquotaIPI;
    property ValorIPI: Double read FValorIPI write FValorIPI;
  end;

  // Classe para totais
  TTotais = class
  private
    FValorProdutos: Double;
    FValorFrete: Double;
    FValorSeguro: Double;
    FValorDesconto: Double;
    FValorICMS: Double;
    FValorIPI: Double;
    FValorTotalNota: Double;
  public
    property ValorProdutos: Double read FValorProdutos write FValorProdutos;
    property ValorFrete: Double read FValorFrete write FValorFrete;
    property ValorSeguro: Double read FValorSeguro write FValorSeguro;
    property ValorDesconto: Double read FValorDesconto write FValorDesconto;
    property ValorICMS: Double read FValorICMS write FValorICMS;
    property ValorIPI: Double read FValorIPI write FValorIPI;
    property ValorTotalNota: Double read FValorTotalNota write FValorTotalNota;
  end;

  // Classe para transportadora
  TTransportadora = class
  private
    FCNPJ: string;
    FRazaoSocial: string;
    FEndereco: TEndereco;
    FPlaca: string;
    FUFPlaca: string;
    FValorFrete: Double;
  public
    constructor Create;
    destructor Destroy; override;
    property CNPJ: string read FCNPJ write FCNPJ;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Endereco: TEndereco read FEndereco;
    property Placa: string read FPlaca write FPlaca;
    property UFPlaca: string read FUFPlaca write FUFPlaca;
    property ValorFrete: Double read FValorFrete write FValorFrete;
  end;

  // Classe principal da venda
  TVenda = class
  private
    FNumero: Integer;
    FDataEmissao: TDateTime;
    FEmitente: TEmitente;
    FDestinatario: TDestinatario;
    FProdutos: TObjectList<TProduto>;
    FTotais: TTotais;
    FTransportadora: TTransportadora;
    FChaveAcesso: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddProduto(const AProduto: TProduto);
    procedure CalcularTotais;
    property Numero: Integer read FNumero write FNumero;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property Emitente: TEmitente read FEmitente;
    property Destinatario: TDestinatario read FDestinatario;
    property Produtos: TObjectList<TProduto> read FProdutos;
    property Totais: TTotais read FTotais;
    property Transportadora: TTransportadora read FTransportadora;
    property ChaveAcesso: string read FChaveAcesso write FChaveAcesso;
  end;

implementation

{ TEmitente }

constructor TEmitente.Create;
begin
  inherited;
  FEndereco := TEndereco.Create;
end;

destructor TEmitente.Destroy;
begin
  FEndereco.Free;
  inherited;
end;

{ TDestinatario }

constructor TDestinatario.Create;
begin
  inherited;
  FEndereco := TEndereco.Create;
end;

destructor TDestinatario.Destroy;
begin
  FEndereco.Free;
  inherited;
end;

{ TTransportadora }

constructor TTransportadora.Create;
begin
  inherited;
  FEndereco := TEndereco.Create;
end;

destructor TTransportadora.Destroy;
begin
  FEndereco.Free;
  inherited;
end;

{ TVenda }

constructor TVenda.Create;
begin
  inherited;
  FEmitente := TEmitente.Create;
  FDestinatario := TDestinatario.Create;
  FProdutos := TObjectList<TProduto>.Create;
  FTotais := TTotais.Create;
  FTransportadora := TTransportadora.Create;
end;

destructor TVenda.Destroy;
begin
  FProdutos.Free;
  FTotais.Free;
  FTransportadora.Free;
  FDestinatario.Free;
  FEmitente.Free;
  inherited;
end;

procedure TVenda.AddProduto(const AProduto: TProduto);
begin
  FProdutos.Add(AProduto);
end;

procedure TVenda.CalcularTotais;
var
  I: Integer;
  VlrProdutos, VlrICMS, VlrIPI: Double;
begin
  VlrProdutos := 0;
  VlrICMS := 0;
  VlrIPI := 0;

  for I := 0 to FProdutos.Count - 1 do
  begin
    VlrProdutos := VlrProdutos + FProdutos[I].ValorTotal;
    VlrICMS := VlrICMS + FProdutos[I].ValorICMS;
    VlrIPI := VlrIPI + FProdutos[I].ValorIPI;
  end;

  FTotais.ValorProdutos := VlrProdutos;
  FTotais.ValorICMS := VlrICMS;
  FTotais.ValorIPI := VlrIPI;
  FTotais.ValorTotalNota := VlrProdutos + FTransportadora.ValorFrete - FTotais.ValorDesconto;
end;

end.
