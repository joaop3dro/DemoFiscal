unit classe.venda.dao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, system.Generics.Collections,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Stan.Param,  FireDAC.DatS,
  FireDAC.DApt.Intf,  FireDAC.DApt,
  FireDAC.Comp.DataSet, classe.venda;

type
  TVendaDAO = class
  private
    procedure CreateDatabase;
    function LoadFromFile(const AFileName: string): string;
    function GetProdutoID(const AProduto: TProduto): Integer;
  public
    FConnection: TFDConnection;
    constructor Create;
    destructor Destroy; override;
    
    function GetEmitenteID(const AEmitente: TEmitente): Integer;
    function GetDestinatarioID(const ADestinatario: TDestinatario): Integer;
    function GetTransportadoraID(const ATransportadora: TTransportadora): Integer;
    
    procedure SaveVenda(const AVenda: TVenda);
    procedure SaveEmitente(const AEmitente: TEmitente);
    procedure SaveDestinatario(const ADestinatario: TDestinatario);
    procedure SaveTransportadora(const ATransportadora: TTransportadora);
    procedure SaveProduto(const AProduto: TProduto);
    procedure SaveTotais(const ATotais: TTotais; const AVendaID: Integer);
    procedure SaveItensVenda(const AVendaID: Integer; const AProdutos: TObjectList<TProduto>);
  end;

implementation

{ TVendaDAO }

constructor TVendaDAO.Create;
begin
  inherited;
  FConnection := TFDConnection.Create(nil);
  FConnection.Params.DriverID := 'SQLite';
  FConnection.Params.Database := 'C:\Desenvolvimento\DemoFiscal\DemoFiscal\exe\Vendas.db';
  FConnection.Connected := True;
  CreateDatabase;
end;

destructor TVendaDAO.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TVendaDAO.CreateDatabase;
var
  SQL: string;
begin
  SQL := LoadFromFile('VendaDB.sql');
  //FConnection.ExecSQL(SQL);
end;

function TVendaDAO.LoadFromFile(const AFileName: string): string;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromFile(AFileName, TEncoding.UTF8); // ou TEncoding.Default, conforme o encoding do arquivo
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TVendaDAO.SaveEmitente(const AEmitente: TEmitente);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'INSERT INTO Emitentes (CNPJ, RazaoSocial, NomeFantasia, Logradouro, Numero, '
      + 'Complemento, Bairro, Cidade, Estado, CEP, Telefone, Email) '
      + 'VALUES (:CNPJ, :RazaoSocial, :NomeFantasia, :Logradouro, :Numero, '
      + ':Complemento, :Bairro, :Cidade, :Estado, :CEP, :Telefone, :Email)';
    
    Qry.ParamByName('CNPJ').AsString := AEmitente.CNPJ;
    Qry.ParamByName('RazaoSocial').AsString := AEmitente.RazaoSocial;
    Qry.ParamByName('NomeFantasia').AsString := AEmitente.NomeFantasia;
    Qry.ParamByName('Logradouro').AsString := AEmitente.Endereco.Logradouro;
    Qry.ParamByName('Numero').AsString := AEmitente.Endereco.Numero;
    Qry.ParamByName('Complemento').AsString := AEmitente.Endereco.Complemento;
    Qry.ParamByName('Bairro').AsString := AEmitente.Endereco.Bairro;
    Qry.ParamByName('Cidade').AsString := AEmitente.Endereco.Cidade;
    Qry.ParamByName('Estado').AsString := AEmitente.Endereco.Estado;
    Qry.ParamByName('CEP').AsString := AEmitente.Endereco.CEP;
    Qry.ParamByName('Telefone').AsString := AEmitente.Telefone;
    Qry.ParamByName('Email').AsString := AEmitente.Email;
    
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TVendaDAO.SaveDestinatario(const ADestinatario: TDestinatario);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'INSERT INTO Destinatarios (CNPJ, RazaoSocial, NomeFantasia, Logradouro, Numero, '
      + 'Complemento, Bairro, Cidade, Estado, CEP, Telefone, Email) '
      + 'VALUES (:CNPJ, :RazaoSocial, :NomeFantasia, :Logradouro, :Numero, '
      + ':Complemento, :Bairro, :Cidade, :Estado, :CEP, :Telefone, :Email)';
    
    Qry.ParamByName('CNPJ').AsString := ADestinatario.CNPJ;
    Qry.ParamByName('RazaoSocial').AsString := ADestinatario.RazaoSocial;
    Qry.ParamByName('NomeFantasia').AsString := ADestinatario.NomeFantasia;
    Qry.ParamByName('Logradouro').AsString := ADestinatario.Endereco.Logradouro;
    Qry.ParamByName('Numero').AsString := ADestinatario.Endereco.Numero;
    Qry.ParamByName('Complemento').AsString := ADestinatario.Endereco.Complemento;
    Qry.ParamByName('Bairro').AsString := ADestinatario.Endereco.Bairro;
    Qry.ParamByName('Cidade').AsString := ADestinatario.Endereco.Cidade;
    Qry.ParamByName('Estado').AsString := ADestinatario.Endereco.Estado;
    Qry.ParamByName('CEP').AsString := ADestinatario.Endereco.CEP;
    Qry.ParamByName('Telefone').AsString := ADestinatario.Telefone;
    Qry.ParamByName('Email').AsString := ADestinatario.Email;
    
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TVendaDAO.SaveTransportadora(const ATransportadora: TTransportadora);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'INSERT INTO Transportadoras (CNPJ, RazaoSocial, Logradouro, Numero, '
      + 'Complemento, Bairro, Cidade, Estado, CEP, Placa, UFPlaca, ValorFrete) '
      + 'VALUES (:CNPJ, :RazaoSocial, :Logradouro, :Numero, '
      + ':Complemento, :Bairro, :Cidade, :Estado, :CEP, :Placa, :UFPlaca, :ValorFrete)';
    
    Qry.ParamByName('CNPJ').AsString := ATransportadora.CNPJ;
    Qry.ParamByName('RazaoSocial').AsString := ATransportadora.RazaoSocial;
    Qry.ParamByName('Logradouro').AsString := ATransportadora.Endereco.Logradouro;
    Qry.ParamByName('Numero').AsString := ATransportadora.Endereco.Numero;
    Qry.ParamByName('Complemento').AsString := ATransportadora.Endereco.Complemento;
    Qry.ParamByName('Bairro').AsString := ATransportadora.Endereco.Bairro;
    Qry.ParamByName('Cidade').AsString := ATransportadora.Endereco.Cidade;
    Qry.ParamByName('Estado').AsString := ATransportadora.Endereco.Estado;
    Qry.ParamByName('CEP').AsString := ATransportadora.Endereco.CEP;
    Qry.ParamByName('Placa').AsString := ATransportadora.Placa;
    Qry.ParamByName('UFPlaca').AsString := ATransportadora.UFPlaca;
    Qry.ParamByName('ValorFrete').AsFloat := ATransportadora.ValorFrete;
    
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TVendaDAO.SaveProduto(const AProduto: TProduto);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'INSERT INTO Produtos (Codigo, Descricao, NCM, CEST, CFOP, Unidade, '
      + 'AliquotaICMS, AliquotaIPI) '
      + 'VALUES (:Codigo, :Descricao, :NCM, :CEST, :CFOP, :Unidade, :AliquotaICMS, :AliquotaIPI)';
    
    Qry.ParamByName('Codigo').AsString := AProduto.Codigo;
    Qry.ParamByName('Descricao').AsString := AProduto.Descricao;
    Qry.ParamByName('NCM').AsString := AProduto.NCM;
    Qry.ParamByName('CEST').AsString := AProduto.CEST;
    Qry.ParamByName('CFOP').AsString := AProduto.CFOP;
    Qry.ParamByName('Unidade').AsString := AProduto.Unidade;
    Qry.ParamByName('AliquotaICMS').AsFloat := AProduto.AliquotaICMS;
    Qry.ParamByName('AliquotaIPI').AsFloat := AProduto.AliquotaIPI;
    
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TVendaDAO.SaveTotais(const ATotais: TTotais; const AVendaID: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'INSERT INTO Totais (VendaID, ValorProdutos, ValorFrete, ValorSeguro, '
      + 'ValorDesconto, ValorICMS, ValorIPI, ValorTotalNota) '
      + 'VALUES (:VendaID, :ValorProdutos, :ValorFrete, :ValorSeguro, '
      + ':ValorDesconto, :ValorICMS, :ValorIPI, :ValorTotalNota)';
    
    Qry.ParamByName('VendaID').AsInteger := AVendaID;
    Qry.ParamByName('ValorProdutos').AsFloat := ATotais.ValorProdutos;
    Qry.ParamByName('ValorFrete').AsFloat := ATotais.ValorFrete;
    Qry.ParamByName('ValorSeguro').AsFloat := ATotais.ValorSeguro;
    Qry.ParamByName('ValorDesconto').AsFloat := ATotais.ValorDesconto;
    Qry.ParamByName('ValorICMS').AsFloat := ATotais.ValorICMS;
    Qry.ParamByName('ValorIPI').AsFloat := ATotais.ValorIPI;
    Qry.ParamByName('ValorTotalNota').AsFloat := ATotais.ValorTotalNota;
    
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TVendaDAO.SaveItensVenda(const AVendaID: Integer; const AProdutos: TObjectList<TProduto>);
var
  Qry: TFDQuery;
  I: Integer;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    
    for I := 0 to AProdutos.Count - 1 do
    begin
      Qry.SQL.Text := 'INSERT INTO ItensVenda (VendaID, ProdutoID, Quantidade, ValorUnitario, '
        + 'ValorTotal, ValorICMS, ValorIPI) '
        + 'VALUES (:VendaID, :ProdutoID, :Quantidade, :ValorUnitario, :ValorTotal, '
        + ':ValorICMS, :ValorIPI)';
      
      Qry.ParamByName('VendaID').AsInteger := AVendaID;
      Qry.ParamByName('ProdutoID').AsInteger := GetProdutoID(AProdutos[I]);
      Qry.ParamByName('Quantidade').AsFloat := AProdutos[I].Quantidade;
      Qry.ParamByName('ValorUnitario').AsFloat := AProdutos[I].ValorUnitario;
      Qry.ParamByName('ValorTotal').AsFloat := AProdutos[I].ValorTotal;
      Qry.ParamByName('ValorICMS').AsFloat := AProdutos[I].ValorICMS;
      Qry.ParamByName('ValorIPI').AsFloat := AProdutos[I].ValorIPI;
      Qry.ExecSQL;
    end;
  finally
    Qry.Free;
  end;
end;

function TVendaDAO.GetDestinatarioID(const ADestinatario: TDestinatario): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT ID FROM Destinatarios WHERE CNPJ = :CNPJ';
    Qry.ParamByName('CNPJ').AsString := ADestinatario.CNPJ;
    Qry.Open;
    if not Qry.IsEmpty then
      Result := Qry.FieldByName('ID').AsInteger
    else
      Result := 0;
  finally
    Qry.Free;
  end;
end;

function TVendaDAO.GetTransportadoraID(const ATransportadora: TTransportadora): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT ID FROM Transportadoras WHERE CNPJ = :CNPJ';
    Qry.ParamByName('CNPJ').AsString := ATransportadora.CNPJ;
    Qry.Open;
    if not Qry.IsEmpty then
      Result := Qry.FieldByName('ID').AsInteger
    else
      Result := 0;
  finally
    Qry.Free;
  end;
end;

function TVendaDAO.GetProdutoID(const AProduto: TProduto): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT ID FROM Produtos WHERE Codigo = :Codigo';
    Qry.ParamByName('Codigo').AsString := AProduto.Codigo;
    Qry.Open;
    if not Qry.IsEmpty then
      Result := Qry.FieldByName('ID').AsInteger
    else
      Result := 0;
  finally
    Qry.Free;
  end;
end;

procedure TVendaDAO.SaveVenda(const AVenda: TVenda);
var
  Qry: TFDQuery;
  VendaID: Integer;
begin
  // Salvar emitente
  SaveEmitente(AVenda.Emitente);
  
  // Salvar destinatário
  SaveDestinatario(AVenda.Destinatario);
  
  // Salvar transportadora (se existir)
  if Assigned(AVenda.Transportadora) then
    SaveTransportadora(AVenda.Transportadora);
  
  // Salvar produtos
  for var Produto in AVenda.Produtos do
    SaveProduto(Produto);
  
  // Inserir venda
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'INSERT INTO Vendas (Numero, DataEmissao, EmitenteID, DestinatarioID, '
      + 'TransportadoraID, ChaveAcesso) '
      + 'VALUES (:Numero, :DataEmissao, :EmitenteID, :DestinatarioID, :TransportadoraID, :ChaveAcesso)';
    
    Qry.ParamByName('Numero').AsInteger := AVenda.Numero;
    Qry.ParamByName('DataEmissao').AsDateTime := AVenda.DataEmissao;
    // Obter IDs das entidades relacionadas
    Qry.ParamByName('EmitenteID').AsInteger := GetEmitenteID(AVenda.Emitente);
    Qry.ParamByName('DestinatarioID').AsInteger := GetDestinatarioID(AVenda.Destinatario);
    Qry.ParamByName('TransportadoraID').AsInteger := GetTransportadoraID(AVenda.Transportadora);
    Qry.ParamByName('ChaveAcesso').AsString := AVenda.ChaveAcesso;
    
    Qry.ExecSQL;
    
    // Obter ID da venda
    Qry.SQL.Text := 'SELECT last_insert_rowid()';
    Qry.Open;
    VendaID := Qry.FieldByName('last_insert_rowid()').AsInteger;
    
    // Salvar totais
    SaveTotais(AVenda.Totais, VendaID);
    
    // Salvar itens da venda
    SaveItensVenda(VendaID, AVenda.Produtos);
  finally
    Qry.Free;
  end;
end;

function TVendaDAO.GetEmitenteID(const AEmitente: TEmitente): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT ID FROM Emitentes WHERE CNPJ = :CNPJ';
    Qry.ParamByName('CNPJ').AsString := AEmitente.CNPJ;
    Qry.Open;
    if not Qry.IsEmpty then
      Result := Qry.FieldByName('ID').AsInteger
    else
      Result := 0;
  finally
    Qry.Free;
  end;
end;

end.
