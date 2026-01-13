unit uAuditoriaSuporte;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Generics.Collections,
  uIAuditoria, uAuditoriaBase, uIAuditPersistence;

type
  TAuditoriaSuporte = class(TAuditoriaBase)
  private
    FAmbiente: Integer;
    FSuporteLogin: string;
    FSuporteNome: string;

  protected
    function TableName: string;

    procedure Persist(const AOperacao, AEvento, ADetalhe, ADadosAntes, ADadosDepois: string);

  public
    class function New(const APersistence: IAuditPersistence): IAuditoriaBase;

    function SetAmbiente(const AAmbiente: Integer): TAuditoriaSuporte;
    function SetSuporteLogin(const ALogin: string): TAuditoriaSuporte;
    function SetSuporteNome(const ANome: string): TAuditoriaSuporte;
  end;

implementation

{ TAuditoriaSuporte }

uses
  System.DateUtils;

class function TAuditoriaSuporte.New(const APersistence: IAuditPersistence): IAuditoriaBase;
begin
  Result := TAuditoriaSuporte.Create(APersistence);
end;

function TAuditoriaSuporte.TableName: string;
begin
  Result := 'cp_auditoria_suporte';
end;

function TAuditoriaSuporte.SetAmbiente(const AAmbiente: Integer): TAuditoriaSuporte;
begin
  FAmbiente := AAmbiente;
  Result := Self;
end;

function TAuditoriaSuporte.SetSuporteLogin(const ALogin: string): TAuditoriaSuporte;
begin
  FSuporteLogin := Trim(ALogin);
  Result := Self;
end;

function TAuditoriaSuporte.SetSuporteNome(const ANome: string): TAuditoriaSuporte;
begin
  FSuporteNome := Trim(ANome);
  Result := Self;
end;

procedure TAuditoriaSuporte.Persist(const AOperacao, AEvento, ADetalhe, ADadosAntes, ADadosDepois: string);
var
  Fields: TDictionary<string, Variant>;
  NowDT: TDateTime;
  Desc: string;
begin
  EnsureBasics;

  Fields := TDictionary<string, Variant>.Create;
  try
    NowDT := Now;

    Fields.AddOrSetValue('datahora_acao', NowDT);
    Fields.AddOrSetValue('data_acao', DateOf(NowDT));
    Fields.AddOrSetValue('hora_acao', TimeOf(NowDT));

    Fields.AddOrSetValue('suporte_login', FSuporteLogin);
    Fields.AddOrSetValue('suporte_nome', FSuporteNome);
    Fields.AddOrSetValue('ambiente', FAmbiente);

    // No suporte, o projeto pede: modulo, acao, descricao
    Fields.AddOrSetValue('modulo', FModulo);

    Fields.AddOrSetValue('acao', AOperacao);

    Desc := AEvento;
    if Trim(ADetalhe) <> '' then
      Desc := Desc + ' | ' + ADetalhe;

    Fields.AddOrSetValue('descricao', Desc);

    Fields.AddOrSetValue('dados_antes', ADadosAntes);
    Fields.AddOrSetValue('dados_depois', ADadosDepois);

    FPersistence.Insert(TableName, Fields);
  finally
    Fields.Free;
  end;
end;

end.

