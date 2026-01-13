unit uAuditoriaEvento;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Generics.Collections,

  uAuditoriaIntf,
  uAuditPersistenceIntf,
  uAuditoriaContexto;

type
  TAuditoriaEvento = class(TInterfacedObject, IAuditoriaEvento)
  private
    FPersistence: IAuditPersistence;
    FContexto: IAuditoriaContexto;

    FOperacao: string;
    FDescricao: string;

    procedure PersistirEvento;
  public
    constructor Create(
      APersistence: IAuditPersistence;
      AContexto: IAuditoriaContexto
    );

    function SetOperacao(const AValue: string): IAuditoriaEvento;
    function SetDescricao(const AValue: string): IAuditoriaEvento;

    procedure Gerar;
  end;

implementation

uses
  System.DateUtils;

constructor TAuditoriaEvento.Create(
  APersistence: IAuditPersistence;
  AContexto: IAuditoriaContexto
);
begin
  FPersistence := APersistence;
  FContexto := AContexto;
end;

function TAuditoriaEvento.SetOperacao(const AValue: string): IAuditoriaEvento;
begin
  FOperacao := AValue;
  Result := Self;
end;

function TAuditoriaEvento.SetDescricao(const AValue: string): IAuditoriaEvento;
begin
  FDescricao := AValue;
  Result := Self;
end;

procedure TAuditoriaEvento.Gerar;
begin
  PersistirEvento;
end;

procedure TAuditoriaEvento.PersistirEvento;
var
  Fields: TDictionary<string, Variant>;
  Agora: TDateTime;
  Tabela: string;
  Ctx: TAuditoriaContexto;
begin
  if FPersistence = nil then
    Exit;

  Ctx := FContexto as TAuditoriaContexto;

  Agora := Now;
  Fields := TDictionary<string, Variant>.Create;
  try
    Fields.Add('datahora_acao', Agora);
    Fields.Add('data_acao', DateOf(Agora));
    Fields.Add('hora_acao', TimeOf(Agora));
    Fields.Add('modulo', Ctx.GetModulo);

    if Trim(Ctx.GetSuporteLogin) <> '' then
    begin
      Tabela := 'nemesis.cp_auditoria_suporte';

      Fields.Add('suporte_login', Ctx.GetSuporteLogin);
      Fields.Add('suporte_nome',  Ctx.GetSuporteNome);
      Fields.Add('ambiente',      Ctx.GetAmbiente);

      Fields.Add('acao', FOperacao);
      Fields.Add('descricao', FDescricao);
    end
    else
    begin
      Tabela := 'nemesis.cp_auditoria';

      Fields.Add('tela',   Ctx.GetTela);
      Fields.Add('origem', Ctx.GetOrigem);

      Fields.Add('usuario_id',   Ctx.GetUsuarioId);
      Fields.Add('usuario_nome', Ctx.GetUsuarioNome);

      Fields.Add('unidade_id',   Ctx.GetUnidadeId);
      Fields.Add('unidade_nome', Ctx.GetUnidadeNome);

      Fields.Add('empregador_id',   Ctx.GetEmpregadorId);
      Fields.Add('empregador_nome', Ctx.GetEmpregadorNome);

      Fields.Add('profissional_id',   Ctx.GetProfissionalId);
      Fields.Add('profissional_nome', Ctx.GetProfissionalNome);

      Fields.Add('operacao', FOperacao);
      Fields.Add('evento',   FDescricao);
    end;

    FPersistence.Insert(Tabela, Fields);
  finally
    Fields.Free;
  end;
end;

end.

