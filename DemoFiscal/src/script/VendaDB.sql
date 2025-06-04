-- Criar tabela de Emitentes
CREATE TABLE Emitentes (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  CNPJ TEXT NOT NULL UNIQUE,
  IE TEXT,
  RazaoSocial TEXT NOT NULL,
  NomeFantasia TEXT,
  Logradouro TEXT,
  Numero TEXT,
  Complemento TEXT,
  Bairro TEXT,
  Cidade TEXT,
  Estado TEXT,
  CEP TEXT,
  Telefone TEXT,
  Email TEXT
);

-- Criar tabela de Destinatarios
CREATE TABLE Destinatarios (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  CNPJ TEXT NOT NULL UNIQUE,
  IE TEXT,
  RazaoSocial TEXT NOT NULL,
  NomeFantasia TEXT,
  Logradouro TEXT,
  Numero TEXT,
  Complemento TEXT,
  Bairro TEXT,
  Cidade TEXT,
  Estado TEXT,
  CEP TEXT,
  Telefone TEXT,
  Email TEXT
);

-- Criar tabela de Transportadoras
CREATE TABLE Transportadoras (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  CNPJ TEXT NOT NULL UNIQUE,
  RazaoSocial TEXT NOT NULL,
  Logradouro TEXT,
  Numero TEXT,
  Complemento TEXT,
  Bairro TEXT,
  Cidade TEXT,
  Estado TEXT,
  CEP TEXT,
  Placa TEXT,
  UFPlaca TEXT,
  ValorFrete REAL
);

-- Criar tabela de Produtos
CREATE TABLE Produtos (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Codigo TEXT NOT NULL UNIQUE,
  Descricao TEXT NOT NULL,
  NCM TEXT,
  CEST TEXT,
  CFOP TEXT,
  Unidade TEXT,
  AliquotaICMS REAL,
  AliquotaIPI REAL
);

-- Criar tabela de Vendas
CREATE TABLE Vendas (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Numero INTEGER NOT NULL,
  DataEmissao DATETIME NOT NULL,
  EmitenteID INTEGER NOT NULL,
  DestinatarioID INTEGER NOT NULL,
  TransportadoraID INTEGER,
  ChaveAcesso TEXT,
  FOREIGN KEY (EmitenteID) REFERENCES Emitentes(ID),
  FOREIGN KEY (DestinatarioID) REFERENCES Destinatarios(ID),
  FOREIGN KEY (TransportadoraID) REFERENCES Transportadoras(ID)
);

-- Criar tabela de Itens de Venda
CREATE TABLE ItensVenda (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  VendaID INTEGER NOT NULL,
  ProdutoID INTEGER NOT NULL,
  Quantidade REAL NOT NULL,
  ValorUnitario REAL NOT NULL,
  ValorTotal REAL NOT NULL,
  ValorICMS REAL,
  ValorIPI REAL,
  FOREIGN KEY (VendaID) REFERENCES Vendas(ID),
  FOREIGN KEY (ProdutoID) REFERENCES Produtos(ID)
);

-- Criar tabela de Totais
CREATE TABLE Totais (
  VendaID INTEGER PRIMARY KEY,
  ValorProdutos REAL NOT NULL,
  ValorFrete REAL,
  ValorSeguro REAL,
  ValorDesconto REAL,
  ValorICMS REAL,
  ValorIPI REAL,
  ValorTotalNota REAL NOT NULL,
  FOREIGN KEY (VendaID) REFERENCES Vendas(ID)
);
