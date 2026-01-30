unit uAuditoriaFormPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPesq_Tabela_Base, Data.DB, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, uJvDbGridZebrado, Vcl.StdCtrls, ComboBoxDN,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Mask, JvExMask, JvToolEdit;

type
  TfAuditoriaFormPesquisa = class(TfPesq_Tabela_Base)
    btnImprimir: TBitBtn;
    DBRichEdit1: TDBRichEdit;
    lblDataIni: TLabel;
    lblDataFim: TLabel;
    lblHoraIni: TLabel;
    lblHoraFim: TLabel;
    edtDataIni: TJvDateEdit;
    edtDataFim: TJvDateEdit;
    edtHoraIni: TMaskEdit;
    edtHoraFim: TMaskEdit;
    lblUsuarioId: TLabel;
    lblUsuarioNome: TLabel;
    lblTela: TLabel;
    edtUsuarioId: TEdit;
    edtUsuarioNome: TEdit;
    edtModulo: TEdit;
    lblOperacao: TLabel;
    lblNarrativa: TLabel;
    lblOrdenacao: TLabel;
    edtEvento: TEdit;
    edtNarrativa: TEdit;
    cbOrdenacao: TComboBoxDN;
    btnVisualizarCargo: TBitBtn;
    pnContainerDescricao: TPanel;
    Label5: TLabel;
    procedure btnVisualizarCargoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtHoraIniExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure AplicarFiltro();
    procedure AplicarAcesso();
    procedure ValidarHoraMask(Sender: TObject);
    procedure LimparFiltros();
    procedure ValidarDataHora();
    procedure Imprimir();
    function GetFiltrosAplicados(): string;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  fAuditoriaFormPesquisa: TfAuditoriaFormPesquisa;

implementation

{$R *.dfm}

uses udmDados,uConstAcessoBioPonto, uFuncoesComumD7, uAuditoriaRelatorios;

{ TfAuditoriaFormPesquisa }

procedure TfAuditoriaFormPesquisa.btnImprimirClick(Sender: TObject);
begin
  inherited;
  Self.Imprimir();
end;

procedure TfAuditoriaFormPesquisa.btnVisualizarCargoClick(Sender: TObject);
begin
  inherited;
  Self.AplicarFiltro();
end;

constructor TfAuditoriaFormPesquisa.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTabela := 'cp_auditoria';
  FCampoID := 'id_auditoria';
  FsqlTabela := dmDados.sqlCp_Auditoria;
  FFormItemClass := TfAuditoriaFormPesquisa;
  FFormItem := fAuditoriaFormPesquisa;
  FAcesso_Modulo := cAcesso_Auditoria;
end;

procedure TfAuditoriaFormPesquisa.edtHoraIniExit(Sender: TObject);
begin
  inherited;
  ValidarHoraMask(Sender);
end;

procedure TfAuditoriaFormPesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  inherited;

end;

procedure TfAuditoriaFormPesquisa.FormShow(Sender: TObject);
begin
  inherited;
  Self.AplicarAcesso();
  edtDataIni.Text := FormatDateTime('dd/mm/yyyy', Now);
  edtDataFim.Text := FormatDateTime('dd/mm/yyyy', Now);
  Self.AplicarFiltro();
end;

function TfAuditoriaFormPesquisa.GetFiltrosAplicados: string;
begin
  Result := EmptyStr;

  // Usuário
  if Trim(edtUsuarioId.Text) <> '' then
    Result := Result +
      ' Usuário ID = ' + edtUsuarioId.Text + ' | ';

  if Trim(edtUsuarioNome.Text) <> '' then
    Result := Result +
      ' Usuário Nome = ' + edtUsuarioNome.Text + ' | ';

  // Tela
  if Trim(edtModulo.Text) <> '' then
    Result := Result +
      ' Módulo = ' + edtModulo.Text + ' | ';

  // Operação
  if Trim(edtEvento.Text) <> '' then
    Result := Result +
      ' Evento = ' + edtEvento.Text + ' | ';

  // Narrativa
  if Trim(edtNarrativa.Text) <> '' then
    Result := Result +
      ' Narrativa = ' + edtNarrativa.Text + ' | ';

  // Ordenação
  case cbOrdenacao.ItemIndex of
    0: Result := Result + ' Ordem por Data e Hora DESC';
    1: Result := Result + ' Ordem por data e Hora ASC';
    2: Result := Result + ' Ordem por Hora';
    3: Result := Result + ' Ordem por Usuário Nome';
    4: Result := Result + ' Ordem por Usuário ID';
  else
    Result := Result + ' Ordem por Data e Hora DESC';
  end;

end;

procedure TfAuditoriaFormPesquisa.Imprimir;
var
  LTextoSQL,
  LFiltros: string;

  function LimparSQL(const ATexto: string): string;
  var
    C: Char;
  begin
    Result := '';
    for C in ATexto do
    begin
      // mantém só caracteres imprimíveis padrão
      if (C >= #32) and (C <= #126) then
        Result := Result + C;
    end;
  end;

begin
  LTextoSQL := dmDados.sqlCp_Auditoria.SQL.Text;
  LTextoSQL := StringReplace(LTextoSQL, '"', '''', [rfReplaceAll]);
  LTextoSQL := LimparSQL(LTextoSQL);

  LFiltros := Self.GetFiltrosAplicados();

  TfRelAuditoria.New
    .SetTextoSQL(LTextoSQL)
    .SetPeriodo(
      edtDataIni.Text,
      edtDataFim.Text,
      edtHoraIni.Text,
      edtHoraFim.Text
    )
    .SetFiltrosUtilizados(LFiltros)
    .Imprimir
    .Free;

end;

procedure TfAuditoriaFormPesquisa.AplicarAcesso;
begin
  btnImprimir.Visible := dmDados.TemAcesso(cAcesso_Auditoria_Relatorio);
end;

procedure TfAuditoriaFormPesquisa.AplicarFiltro();
var
  TextoSQL: string;
begin
  TextoSQL := 'SELECT * FROM cp_auditoria WHERE 0=0 ';

  // Período - Datas
  if edtDataIni.Date > 0 then
    TextoSQL := TextoSQL +
      ' AND data_acao >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd', edtDataIni.Date));

  if edtDataFim.Date > 0 then
    TextoSQL := TextoSQL +
      ' AND data_acao <= ' + QuotedStr(FormatDateTime('yyyy-mm-dd', edtDataFim.Date));

  // Período - Horas
  if edtHoraIni.Text <> '  :  ' then
    TextoSQL := TextoSQL +
      ' AND hora_acao >= ' + QuotedStr(edtHoraIni.Text);

  if edtHoraFim.Text <> '  :  ' then
    TextoSQL := TextoSQL +
      ' AND hora_acao <= ' + QuotedStr(edtHoraFim.Text);

  // Usuário
  if Trim(edtUsuarioId.Text) <> '' then
    TextoSQL := TextoSQL +
      ' AND usuario_id = ' + edtUsuarioId.Text;

  if Trim(edtUsuarioNome.Text) <> '' then
    TextoSQL := TextoSQL +
      ' AND usuario_nome LIKE ' + QuotedStr('%' + edtUsuarioNome.Text + '%');

  // Tela
  if Trim(edtModulo.Text) <> '' then
    TextoSQL := TextoSQL +
      ' AND modulo LIKE ' + QuotedStr('%' + edtModulo.Text + '%');

  // Operação
  if Trim(edtEvento.Text) <> '' then
    TextoSQL := TextoSQL +
      ' AND evento LIKE ' + QuotedStr('%' + edtEvento.Text + '%');

  // Narrativa
  if Trim(edtNarrativa.Text) <> '' then
    TextoSQL := TextoSQL +
      ' AND narrativa LIKE ' + QuotedStr('%' + edtNarrativa.Text + '%');

  // Ordenação
  case cbOrdenacao.ItemIndex of
    0: TextoSQL := TextoSQL + 'ORDER BY data_acao DESC, hora_acao,usuario_nome';
    1: TextoSQL := TextoSQL + 'ORDER BY data_acao ASC, hora_acao, usuario_nome';
    2: TextoSQL := TextoSQL + 'ORDER BY hora_acao, usuario_nome';
    3: TextoSQL := TextoSQL + 'ORDER BY usuario_nome, data_acao DESC, hora_acao';
    4: TextoSQL := TextoSQL + 'ORDER BY usuario_id, data_acao DESC, hora_acao';
  else
    TextoSQL := TextoSQL + 'ORDER BY data_acao DESC, hora_acao, usuario_nome';
  end;

  // Executa
  dmDados.ZListaSQL(dmDados.sqlCp_Auditoria, TextoSQL);
end;


procedure TfAuditoriaFormPesquisa.ValidarHoraMask(Sender: TObject);
var
  E: TMaskEdit;
  HoraPadrao: string;
  TextoLimpo: string;
  Hora: TDateTime;
begin
  if not (Sender is TMaskEdit) then
    Exit;

  E := TMaskEdit(Sender);

  // Remove ':' e '_' para detectar se ficou "vazio mascarado"
  TextoLimpo := StringReplace(E.Text, ':', '', [rfReplaceAll]);
  TextoLimpo := StringReplace(TextoLimpo, '_', '', [rfReplaceAll]);

  if Trim(TextoLimpo) = '' then
  begin
    if SameText(E.Name, 'edtHoraIni') then
      HoraPadrao := '00:00:00'
    else if SameText(E.Name, 'edtHoraFim') then
      HoraPadrao := '23:59:59'
    else
      HoraPadrao := '00:00:00';

    E.Text := HoraPadrao;
    Exit;
  end;

  if not TryStrToTime(E.Text, Hora) then
  begin
    if SameText(E.Name, 'edtHoraIni') then
      E.Text := '00:00:00'
    else
      E.Text := '23:59:59';
  end;
end;

procedure TfAuditoriaFormPesquisa.LimparFiltros;
begin
  edtDataIni.Text := '  /  /    ';
  edtDataFim.Text := '  /  /    ';

  edtHoraIni.Text := '00:00:00';
  edtHoraFim.Text := '23:59:59';

  edtUsuarioId.Clear;
  edtUsuarioNome.Clear;
  edtModulo.Clear;
  edtEvento.Clear;
  edtNarrativa.Clear;

  cbOrdenacao.ItemIndex := -1;

  Self.AplicarFiltro();
end;


procedure TfAuditoriaFormPesquisa.ValidarDataHora;
var
  LData1, LData2: TDate;
  LHoraIni, LHoraFim: TTime;
begin
  if not DataValida(edtDataIni.Text) then
    MensagemAbort('Aviso', 'A data inicial está incorreta!', MB_ICONWARNING);

  if not DataValida(edtDataFim.Text) then
    MensagemAbort('Aviso', 'A data final está incorreta!', MB_ICONWARNING);

  if not HoraValida(edtHoraIni.Text) then
    MensagemAbort('Aviso', 'A hora inicial está incorreta!', MB_ICONWARNING);

  if not HoraValida(edtHoraFim.Text) then
    MensagemAbort('Aviso', 'A hora final está incorreta!', MB_ICONWARNING);

  LData1 := edtDataIni.Date;
  LData2 := edtDataFim.Date;

  if LData1 > LData2 then
    MensagemAbort('Aviso', 'A data inicial não pode ser superior a data final!', MB_ICONWARNING);

  { valida hora apenas se a data for a mesma }
  if LData1 = LData2 then
  begin
    LHoraIni := StrToTime(edtHoraIni.Text);
    LHoraFim := StrToTime(edtHoraFim.Text);

    if LHoraIni > LHoraFim then
      MensagemAbort('Aviso', 'A hora inicial não pode ser superior à hora final!', MB_ICONWARNING);
  end;
end;


end.
