unit classe.imposto;

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
  TImposto = class
  public
    class procedure impNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
  end;

implementation

class procedure TImposto.impNfe(const IDNota: Integer; ACBr: TACBrNFe; AConn: TFDConnection);
var
  qry: TFDQuery;
  BaseCalculo,
  ValorICMS: Double;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConn;
    qry.SQL.Text := 'SELECT * FROM imposto WHERE id_nfe = :id_nfe';
    qry.Open;

    with ACBr.NotasFiscais.Add.NFe.Det.New.Imposto do
    begin
        vTotTrib := 0;

      with ICMS do
      begin
        // caso o CRT seja:
        // 1=Simples Nacional
        // Os valores aceitos para CSOSN são:
        // csosn101, csosn102, csosn103, csosn201, csosn202, csosn203,
        // csosn300, csosn400, csosn500,csosn900

        // 2=Simples Nacional, excesso sublimite de receita bruta;
        // ou 3=Regime Normal.
        // Os valores aceitos para CST são:
        // cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51,
        // cst60, cst70, cst80, cst81, cst90, cstPart10, cstPart90,
        // cstRep41, cstVazio, cstICMSOutraUF, cstICMSSN, cstRep60

        // (consulte o contador do seu cliente para saber qual deve ser utilizado)
        // Pode variar de um produto para outro.

        if ACBr.NotasFiscais.Add.NFe.Emit.CRT in [crtSimplesExcessoReceita, crtRegimeNormal] then
          CST := cst00
        else
          CSOSN := csosn102;

        orig    := oeNacional;
        modBC   := dbiValorOperacao;

        if ACBr.NotasFiscais.Add.NFe.Emit.CRT in [crtSimplesExcessoReceita, crtRegimeNormal] then
          BaseCalculo := 100
        else
          BaseCalculo := 0;

        vBC     := BaseCalculo;
        pICMS   := 18;

        ValorICMS := vBC * pICMS;

        vICMS   := ValorICMS;
        modBCST := dbisMargemValorAgregado;
        pMVAST  := 0;
        pRedBCST:= 0;
        vBCST   := 0;
        pICMSST := 0;
        vICMSST := 0;
        pRedBC  := 0;

        pCredSN := 5;
        vCredICMSSN := 50;
        vBCFCPST := 100;
        pFCPST := 2;
        vFCPST := 2;
        vBCSTRet := 0;
        pST := 0;
        vICMSSubstituto := 0;
        vICMSSTRet := 0;

        vBCFCPSTRet := 0;
        pFCPSTRet := 0;
        vFCPSTRet := 0;
        pRedBCEfet := 0;
        vBCEfet := 0;
        pICMSEfet := 0;
        vICMSEfet := 0;

        {
          abaixo os campos incluidos no layout a partir da NT 2020/005
        }
        // Informar apenas nos motivos de desoneração documentados abaixo
        vICMSSTDeson := 0;
        {
          o campo abaixo só aceita os valores:
          mdiProdutorAgropecuario, mdiOutros, mdiOrgaoFomento
          Campo será preenchido quando o campo anterior estiver preenchido.
        }
        motDesICMSST := mdiOutros;

        // Percentual do diferimento do ICMS relativo ao Fundo de Combate à Pobreza (FCP).
        // No caso de diferimento total, informar o percentual de diferimento "100"
        pFCPDif := 0;
        // Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP) diferido
        vFCPDif := 0;
        // Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP) realmente devido.
        vFCPEfet := 0;

        // partilha do ICMS e fundo de probreza
        with ICMSUFDest do
        begin
          vBCUFDest      := 0.00;
          pFCPUFDest     := 0.00;
          pICMSUFDest    := 0.00;
          pICMSInter     := 0.00;
          pICMSInterPart := 0.00;
          vFCPUFDest     := 0.00;
          vICMSUFDest    := 0.00;
          vICMSUFRemet   := 0.00;
        end;
      end;

      with PIS do
      begin
        CST      := pis99;
        PIS.vBC  := 0;
        PIS.pPIS := 0;
        PIS.vPIS := 0;

        PIS.qBCProd   := 0;
        PIS.vAliqProd := 0;
        PIS.vPIS      := 0;
      end;

      with PISST do
      begin
        vBc       := 0;
        pPis      := 0;
        qBCProd   := 0;
        vAliqProd := 0;
        vPIS      := 0;
        {
          abaixo o campo incluido no layout a partir da NT 2020/005
        }
        {
          valores aceitos pelo campo:
          ispNenhum, ispPISSTNaoCompoe, ispPISSTCompoe
        }
        // Indica se o valor do PISST compõe o valor total da NF-e
        IndSomaPISST :=  ispNenhum;
      end;

      with COFINS do
      begin
        CST            := cof99;
        COFINS.vBC     := 0;
        COFINS.pCOFINS := 0;
        COFINS.vCOFINS := 0;

        COFINS.qBCProd   := 0;
        COFINS.vAliqProd := 0;
      end;

      with COFINSST do
      begin
        vBC       := 0;
        pCOFINS   := 0;
        qBCProd   := 0;
        vAliqProd := 0;
        vCOFINS   := 0;
        {
          abaixo o campo incluido no layout a partir da NT 2020/005
        }
        {
          valores aceitos pelo campo:
          iscNenhum, iscCOFINSSTNaoCompoe, iscCOFINSSTCompoe
        }
        // Indica se o valor da COFINS ST compõe o valor total da NF-e
        indSomaCOFINSST :=  iscNenhum;
      end;

      // Reforma Tributária
      {
      IBSCBSSel.CST := 100;
      IBSCBSSel.cClassTrib := 100000;
      IBSCBSSel.indPerecimento := tipNenhum;

      IBSCBSSel.seletivo.CST := 100;
      IBSCBSSel.seletivo.cClassTrib := 100000;

      IBSCBSSel.seletivo.gImpSel.vBCImpSel := 100;
      IBSCBSSel.seletivo.gImpSel.pImpSel := 5;
      IBSCBSSel.seletivo.gImpSel.pImpSelEspec := 5;
      IBSCBSSel.seletivo.gImpSel.uTrib := 'UNIDAD';
      IBSCBSSel.seletivo.gImpSel.qTrib := 10;
      IBSCBSSel.seletivo.gImpSel.vImpSel := 100;

      IBSCBSSel.gIBSCBS.vBC := 100;

      IBSCBSSel.gIBSCBS.gIBSUF.pIBSUF := 5;
      IBSCBSSel.gIBSCBS.gIBSUF.vTribOP := 100;
      IBSCBSSel.gIBSCBS.gIBSUF.vIBSUF := 100;

      IBSCBSSel.gIBSCBS.gIBSUF.gDif.pDif := 5;
      IBSCBSSel.gIBSCBS.gIBSUF.gDif.pDif := 100;

      IBSCBSSel.gIBSCBS.gIBSUF.gDevTrib.vDevTrib := 100;

      IBSCBSSel.gIBSCBS.gIBSUF.gRed.pRedAliq := 5;
      IBSCBSSel.gIBSCBS.gIBSUF.gRed.pAliqEfet := 5;

      IBSCBSSel.gIBSCBS.gIBSUF.gDeson.CST := 100;
      IBSCBSSel.gIBSCBS.gIBSUF.gDeson.cClassTrib := 100000;
      IBSCBSSel.gIBSCBS.gIBSUF.gDeson.vBC := 100;
      IBSCBSSel.gIBSCBS.gIBSUF.gDeson.pAliq := 5;
      IBSCBSSel.gIBSCBS.gIBSUF.gDeson.vDeson := 100;

      IBSCBSSel.gIBSCBS.gIBSMun.pIBSMun := 5;
      IBSCBSSel.gIBSCBS.gIBSMun.vTribOP := 100;
      IBSCBSSel.gIBSCBS.gIBSMun.vIBSMun := 100;

      IBSCBSSel.gIBSCBS.gIBSMun.gDif.pDif := 5;
      IBSCBSSel.gIBSCBS.gIBSMun.gDif.pDif := 100;

      IBSCBSSel.gIBSCBS.gIBSMun.gDevTrib.vDevTrib := 100;

      IBSCBSSel.gIBSCBS.gIBSMun.gRed.pRedAliq := 5;
      IBSCBSSel.gIBSCBS.gIBSMun.gRed.pAliqEfet := 5;

      IBSCBSSel.gIBSCBS.gIBSMun.gDeson.CST := 100;
      IBSCBSSel.gIBSCBS.gIBSMun.gDeson.cClassTrib := 100000;
      IBSCBSSel.gIBSCBS.gIBSMun.gDeson.vBC := 100;
      IBSCBSSel.gIBSCBS.gIBSMun.gDeson.pAliq := 5;
      IBSCBSSel.gIBSCBS.gIBSMun.gDeson.vDeson := 100;

      IBSCBSSel.gIBSCBS.gIBSCredPres.cCredPres := 1;
      IBSCBSSel.gIBSCBS.gIBSCredPres.pCredPres := 5;
      IBSCBSSel.gIBSCBS.gIBSCredPres.vCredPres := 100;
      IBSCBSSel.gIBSCBS.gIBSCredPres.vCredPresCondSus := 100;

      IBSCBSSel.gIBSCBS.gCBS.pCBS := 5;
      IBSCBSSel.gIBSCBS.gCBS.vTribOp := 100;
      IBSCBSSel.gIBSCBS.gCBS.vCBS := 100;

      IBSCBSSel.gIBSCBS.gCBS.gCBSCredPres.cCredPres := 1;
      IBSCBSSel.gIBSCBS.gCBS.gCBSCredPres.pCredPres := 5;
      IBSCBSSel.gIBSCBS.gCBS.gCBSCredPres.vCredPres := 100;
      IBSCBSSel.gIBSCBS.gCBS.gCBSCredPres.vCredPresCondSus := 100;

      IBSCBSSel.gIBSCBS.gCBS.gDif.pDif := 5;
      IBSCBSSel.gIBSCBS.gCBS.gDif.pDif := 100;

      IBSCBSSel.gIBSCBS.gCBS.gDevTrib.vDevTrib := 100;

      IBSCBSSel.gIBSCBS.gCBS.gRed.pRedAliq := 5;
      IBSCBSSel.gIBSCBS.gCBS.gRed.pAliqEfet := 5;

      IBSCBSSel.gIBSCBS.gCBS.gDeson.CST := 100;
      IBSCBSSel.gIBSCBS.gCBS.gDeson.cClassTrib := 100000;
      IBSCBSSel.gIBSCBS.gCBS.gDeson.vBC := 100;
      IBSCBSSel.gIBSCBS.gCBS.gDeson.pAliq := 5;
      IBSCBSSel.gIBSCBS.gCBS.gDeson.vDeson := 100;

      IBSCBSSel.gIBSCBSMono.qBCMono := 1;
      IBSCBSSel.gIBSCBSMono.adRemIBS := 5;
      IBSCBSSel.gIBSCBSMono.adRemCBS := 5;
      IBSCBSSel.gIBSCBSMono.vIBSMono := 100;
      IBSCBSSel.gIBSCBSMono.vCBSMono := 100;
      IBSCBSSel.gIBSCBSMono.qBCMonoReten := 1;
      IBSCBSSel.gIBSCBSMono.adRemIBSREten := 5;
      IBSCBSSel.gIBSCBSMono.vIBSMonoReten := 100;
      IBSCBSSel.gIBSCBSMono.pCredPresIBS := 5;
      IBSCBSSel.gIBSCBSMono.vCRedPresIBS := 100;
      IBSCBSSel.gIBSCBSMono.pCredPresCBS := 5;
      IBSCBSSel.gIBSCBSMono.vCredPresCBS := 100;
      IBSCBSSel.gIBSCBSMono.pDifIBS := 5;
      IBSCBSSel.gIBSCBSMono.vIBSMonoDif := 100;
      IBSCBSSel.gIBSCBSMono.pDifCBS := 5;
      IBSCBSSel.gIBSCBSMono.vCBSMonoDif := 100;
      IBSCBSSel.gIBSCBSMono.vTotIBSMono := 100;
      IBSCBSSel.gIBSCBSMono.vTotCBSMono := 100;
      }
    end;

  finally
    qry.Free;
  end;
end;
end.
