unit uAuditoriaAlteracao;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Generics.Collections,

  uAuditoriaIntf,
  uAuditPersistenceIntf;

type
  TAuditoriaAlteracao = class(TInterfacedObject, IAuditoriaAlteracao)
  private
    FPersistence: IAuditPersistence;
    FContexto: IAuditoriaContexto;
    FView: IAuditoriaView;

  public
    constructor Create(
      const APersistence: IAuditPersistence;
      const AContexto: IAuditoriaContexto;
      const AView: IAuditoriaView
    );

    procedure Persistir;
  end;

implementation

uses
  System.DateUtils;

{ TAuditoriaAlteracao }

constructor TAuditoriaAlteracao.Create(
  const APersistence: IAuditPersistence;
  const AContexto: IAuditoriaContexto;
  const AView: IAuditoriaView
);
begin
  FPersistence := APersistence;
  FContexto := AContexto;
  FView := AView;
end;

procedure TAuditoriaAlteracao.Persistir;
var
  Fields: TDictionary<string, Variant>;
  Agora: TDateTime;
begin
  if (FPersistence = nil) or (FView = nil) then
    Exit;

  if FView.GetAlteracoes.Count = 0 then
    Exit;

  Agora := Now;
  Fields := TDictionary<string, Variant>.Create;
  try
    Fields.Add('datahora_acao', Agora);
    Fields.Add('data_acao', DateOf(Agora));
    Fields.Add('hora_acao', TimeOf(Agora));

    Fields.Add('modulo', FContexto.GetModulo);
    Fields.Add('tela',   FContexto.GetTela);
    Fields.Add('origem', FContexto.GetOrigem);

    Fields.Add('usuario_id',   FContexto.GetUsuarioId);
    Fields.Add('usuario_nome', FContexto.GetUsuarioNome);

    Fields.Add('unidade_id',   FContexto.GetUnidadeId);
    Fields.Add('unidade_nome', FContexto.GetUnidadeNome);

    Fields.Add('empregador_id',   FContexto.GetEmpregadorId);
    Fields.Add('empregador_nome', FContexto.GetEmpregadorNome);

    Fields.Add('profissional_id',   FContexto.GetProfissionalId);
    Fields.Add('profissional_nome', FContexto.GetProfissionalNome);

    Fields.Add('operacao', 'ALTERACAO');
    Fields.Add('evento',   'Alteração de dados');

    Fields.Add('dados_antes',  FView.AsTextoAntes);
    Fields.Add('dados_depois', FView.AsTextoDepois);

    FPersistence.Insert('nemesis.cp_auditoria', Fields);
  finally
    Fields.Free;
  end;
end;

end.

