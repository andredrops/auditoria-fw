unit uAuditoriaRelatorios;

interface

uses
  System.SysUtils,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  uFuncoesFS;

type
  TfRelAuditoria = class
  private
    // Período
    FDataIni: string;
    FDataFim: string;
    FHoraIni: string;
    FHoraFim: string;

    // Filtros
    FUsuarioId: string;
    FUsuarioNome: string;
    FTela: string;
    FOperacao: string;
    FNarrativa: string;
    FOrdenacao: string;
    FFiltrosUtilizados: string;
    FTextoSQL: string;

    procedure PrepararVariaveis(const ATitulo: string);

    function ImprimirResumido: TfRelAuditoria;
    function ImprimirDetalhado: TfRelAuditoria;

    function EscolherTipoImpressao: Boolean;
  public
    class function New: TfRelAuditoria;

    function SetPeriodo(const ADataIni, ADataFim, AHoraIni, AHoraFim: string): TfRelAuditoria;
    function SetUsuario(const AId, ANome: string): TfRelAuditoria;
    function SetTela(const ATela: string): TfRelAuditoria;
    function SetOperacao(const AOperacao: string): TfRelAuditoria;
    function SetNarrativa(const ANarrativa: string): TfRelAuditoria;
    function SetOrdenacao(const AOrdenacao: string): TfRelAuditoria;
    function SetFiltrosUtilizados(const AFiltros: string): TfRelAuditoria;
    function SetTextoSQL(const AValue: string): TfRelAuditoria;

    function Imprimir: TfRelAuditoria;
  end;

implementation

uses
  Vcl.Controls;

{ TfRelAuditoria }

class function TfRelAuditoria.New: TfRelAuditoria;
begin
  Result := Self.Create;
end;

function TfRelAuditoria.SetPeriodo(
  const ADataIni, ADataFim, AHoraIni, AHoraFim: string): TfRelAuditoria;
begin
  FDataIni := ADataIni;
  FDataFim := ADataFim;
  FHoraIni := AHoraIni;
  FHoraFim := AHoraFim;
  Result := Self;
end;

function TfRelAuditoria.SetUsuario(
  const AId, ANome: string): TfRelAuditoria;
begin
  FUsuarioId := AId;
  FUsuarioNome := ANome;
  Result := Self;
end;

function TfRelAuditoria.SetTela(const ATela: string): TfRelAuditoria;
begin
  FTela := ATela;
  Result := Self;
end;

function TfRelAuditoria.SetTextoSQL(const AValue: string): TfRelAuditoria;
begin
  FTextoSQL := AValue;
  Result := Self;
end;

function TfRelAuditoria.SetOperacao(
  const AOperacao: string): TfRelAuditoria;
begin
  FOperacao := AOperacao;
  Result := Self;
end;

function TfRelAuditoria.SetNarrativa(
  const ANarrativa: string): TfRelAuditoria;
begin
  FNarrativa := ANarrativa;
  Result := Self;
end;

function TfRelAuditoria.SetOrdenacao(
  const AOrdenacao: string): TfRelAuditoria;
begin
  FOrdenacao := AOrdenacao;
  Result := Self;
end;

function TfRelAuditoria.SetFiltrosUtilizados(
  const AFiltros: string): TfRelAuditoria;
begin
  FFiltrosUtilizados := AFiltros;
  Result := Self;
end;

procedure TfRelAuditoria.PrepararVariaveis(const ATitulo: string);
begin
  fFuncoesFS.MudaVarFr3('vTitulo', ATitulo);
  fFuncoesFS.MudaVarFr3('vFiltros', FFiltrosUtilizados);

  fFuncoesFS.MudaVarFr3('vDataIni', FDataIni);
  fFuncoesFS.MudaVarFr3('vDataFim', FDataFim);
  fFuncoesFS.MudaVarFr3('vHoraIni', FHoraIni);
  fFuncoesFS.MudaVarFr3('vHoraFim', FHoraFim);

  fFuncoesFS.MudaVarFr3('vUsuarioId', FUsuarioId);
  fFuncoesFS.MudaVarFr3('vUsuarioNome', FUsuarioNome);
  fFuncoesFS.MudaVarFr3('vTela', FTela);
  fFuncoesFS.MudaVarFr3('vOperacao', FOperacao);
  fFuncoesFS.MudaVarFr3('vNarrativa', FNarrativa);
  fFuncoesFS.MudaVarFr3('vOrdenacao', FOrdenacao);

  fFuncoesFS.MudaVarFr3('vTextoSQL', FTextoSQL);

end;

function TfRelAuditoria.ImprimirResumido: TfRelAuditoria;
begin
  fFuncoesFS.AbreFr3('Cp_Auditoria_Resumido.fr3');
  PrepararVariaveis('Relatório de Auditoria - Resumido');
  fFuncoesFS.ShowFr3;
  Result := Self;
end;

function TfRelAuditoria.ImprimirDetalhado: TfRelAuditoria;
begin
  fFuncoesFS.AbreFr3('Cp_Auditoria_Detalhado.fr3');
  PrepararVariaveis('Relatório de Auditoria - Detalhado');
  fFuncoesFS.ShowFr3;
  Result := Self;
end;

function TfRelAuditoria.EscolherTipoImpressao: Boolean;
var
  Frm: TForm;
  Rg: TRadioGroup;
  BtnOk, BtnCancel: TButton;
begin
  Result := False;

  Frm := TForm.Create(nil);
  try
    Frm.BorderStyle := bsDialog;
    Frm.Position := poScreenCenter;
    Frm.Caption := 'Tipo de Impressão';
    Frm.ClientWidth := 260;
    Frm.ClientHeight := 140;

    Rg := TRadioGroup.Create(Frm);
    Rg.Parent := Frm;
    Rg.AlignWithMargins := True;
    Rg.Margins.Left := 10;
    Rg.Margins.Top := 10;
    Rg.Margins.Right := 10;
    Rg.Margins.Bottom := 10;
    Rg.Align := alTop;
    Rg.Columns := 2;
    Rg.Caption := 'Selecione o tipo';
    Rg.Items.Add('Resumido');
    Rg.Items.Add('Detalhado');
    Rg.ItemIndex := 0;
    Rg.Height := 70;

    BtnOk := TButton.Create(Frm);
    BtnOk.Parent := Frm;
    BtnOk.Caption := 'Imprimir';
    BtnOk.ModalResult := mrOk;
    BtnOk.Left := 40;
    BtnOk.Top := 90;
    BtnOk.Width := 80;

    BtnCancel := TButton.Create(Frm);
    BtnCancel.Parent := Frm;
    BtnCancel.Caption := 'Cancelar';
    BtnCancel.ModalResult := mrCancel;
    BtnCancel.Left := 140;
    BtnCancel.Top := 90;
    BtnCancel.Width := 80;

    if Frm.ShowModal = mrOk then
    begin
      if Rg.ItemIndex = 0 then
        ImprimirResumido
      else
        ImprimirDetalhado;

      Result := True;
    end;
  finally
    Frm.Free;
  end;
end;

function TfRelAuditoria.Imprimir: TfRelAuditoria;
begin
  EscolherTipoImpressao;
  Result := Self;
end;

end.


//backup antes metodo para escolher tipo relatorio
unit uAuditoriaRelatorios;

interface

uses
  System.SysUtils,
  uFuncoesFS;

type
  TfRelAuditoria = class
  private
    // Período
    FDataIni: string;
    FDataFim: string;
    FHoraIni: string;
    FHoraFim: string;

    // Filtros
    FUsuarioId: string;
    FUsuarioNome: string;
    FTela: string;
    FOperacao: string;
    FNarrativa: string;
    FOrdenacao: string;
    FFiltrosUtilizados: string;

    procedure PrepararVariaveis(const ATitulo: string);
  public
    class function New: TfRelAuditoria;

    function SetPeriodo(
      const ADataIni, ADataFim, AHoraIni, AHoraFim: string): TfRelAuditoria;
    function SetUsuario(const AId, ANome: string): TfRelAuditoria;
    function SetTela(const ATela: string): TfRelAuditoria;
    function SetOperacao(const AOperacao: string): TfRelAuditoria;
    function SetNarrativa(const ANarrativa: string): TfRelAuditoria;
    function SetOrdenacao(const AOrdenacao: string): TfRelAuditoria;
    function SetFiltrosUtilizados(const AFiltros: string): TfRelAuditoria;

    function ImprimirResumido(): TfRelAuditoria;
    function ImprimirDetalhado(): TfRelAuditoria;
  end;

implementation

{ TfRelAuditoria }

class function TfRelAuditoria.New: TfRelAuditoria;
begin
  Result := Self.Create;
end;

function TfRelAuditoria.SetPeriodo(
  const ADataIni, ADataFim, AHoraIni, AHoraFim: string): TfRelAuditoria;
begin
  FDataIni := ADataIni;
  FDataFim := ADataFim;
  FHoraIni := AHoraIni;
  FHoraFim := AHoraFim;
  Result := Self;
end;

function TfRelAuditoria.SetUsuario(
  const AId, ANome: string): TfRelAuditoria;
begin
  FUsuarioId := AId;
  FUsuarioNome := ANome;
  Result := Self;
end;

function TfRelAuditoria.SetTela(const ATela: string): TfRelAuditoria;
begin
  FTela := ATela;
  Result := Self;
end;

function TfRelAuditoria.SetOperacao(
  const AOperacao: string): TfRelAuditoria;
begin
  FOperacao := AOperacao;
  Result := Self;
end;

function TfRelAuditoria.SetNarrativa(
  const ANarrativa: string): TfRelAuditoria;
begin
  FNarrativa := ANarrativa;
  Result := Self;
end;

function TfRelAuditoria.SetOrdenacao(
  const AOrdenacao: string): TfRelAuditoria;
begin
  FOrdenacao := AOrdenacao;
  Result := Self;
end;

function TfRelAuditoria.SetFiltrosUtilizados(
  const AFiltros: string): TfRelAuditoria;
begin
  FFiltrosUtilizados := AFiltros;
  Result := Self;
end;

procedure TfRelAuditoria.PrepararVariaveis(const ATitulo: string);
begin
  fFuncoesFS.MudaVarFr3('vTitulo', ATitulo);
  fFuncoesFS.MudaVarFr3('vFiltros', FFiltrosUtilizados);

  fFuncoesFS.MudaVarFr3('vDataIni', FDataIni);
  fFuncoesFS.MudaVarFr3('vDataFim', FDataFim);
  fFuncoesFS.MudaVarFr3('vHoraIni', FHoraIni);
  fFuncoesFS.MudaVarFr3('vHoraFim', FHoraFim);

  fFuncoesFS.MudaVarFr3('vUsuarioId', FUsuarioId);
  fFuncoesFS.MudaVarFr3('vUsuarioNome', FUsuarioNome);
  fFuncoesFS.MudaVarFr3('vTela', FTela);
  fFuncoesFS.MudaVarFr3('vOperacao', FOperacao);
  fFuncoesFS.MudaVarFr3('vNarrativa', FNarrativa);
  fFuncoesFS.MudaVarFr3('vOrdenacao', FOrdenacao);
end;

function TfRelAuditoria.ImprimirResumido: TfRelAuditoria;
begin
  Result := Self;
  fFuncoesFS.AbreFr3('Cp_Auditoria_Resumido.fr3');
  PrepararVariaveis('Relatório de Auditoria - Resumido');
  fFuncoesFS.ShowFr3;
end;

function TfRelAuditoria.ImprimirDetalhado: TfRelAuditoria;
begin
  Result := Self;
  fFuncoesFS.AbreFr3('RelAuditoriaDetalhado.fr3');
  PrepararVariaveis('Relatório de Auditoria - Detalhado');
  fFuncoesFS.ShowFr3;
end;

end.

