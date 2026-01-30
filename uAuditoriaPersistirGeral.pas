unit uAuditoriaPersistirGeral;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Generics.Collections,
  System.DateUtils,

  uAuditoriaIntf,
  uAuditPersistenceIntf,
  uAuditoriaNarrativa;

type
  TAuditoriaPersistirGeral = class(TInterfacedObject, IAuditoriaPersistir)
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

constructor TAuditoriaPersistirGeral.Create(
  const APersistence: IAuditPersistence;
  const AContexto: IAuditoriaContexto;
  const AView: IAuditoriaView
);
begin
  FPersistence := APersistence;
  FContexto := AContexto;
  FView := AView;
end;

procedure TAuditoriaPersistirGeral.Persistir;
var
  Fields: TDictionary<string, Variant>;
  Agora: TDateTime;
  LNarrativa: string;
begin
  Agora := Now;
  Fields := TDictionary<string, Variant>.Create;
  try
    Fields.Add('datahora_acao', Agora);
    Fields.Add('data_acao', DateOf(Agora));
    Fields.Add('hora_acao', TimeOf(Agora));

    Fields.Add('usuario_id',        FContexto.GetUsuarioId);
    Fields.Add('usuario_nome',      FContexto.GetUsuarioNome);
    Fields.Add('unidade_id',        FContexto.GetUnidadeId);
    Fields.Add('unidade_nome',      FContexto.GetUnidadeNome);
    Fields.Add('empregador_id',     FContexto.GetEmpregadorId);
    Fields.Add('empregador_nome',   FContexto.GetEmpregadorNome);
    Fields.Add('profissional_id',   FContexto.GetProfissionalId);
    Fields.Add('profissional_nome', FContexto.GetProfissionalNome);

    Fields.Add('modulo', FContexto.GetModulo);
    Fields.Add('tela',   FContexto.GetTela);
    Fields.Add('id_afetado', FContexto.GetIdAfetado);
    Fields.Add('evento',   FContexto.GetEvento);

    LNarrativa := TAuditoriaNarrativa.BuildAlteracao(
      FContexto,
      Agora,
      FView.GetAlteracoes
    );
    Fields.Add('dados_antes',  FView.AsTextoAntes);
    Fields.Add('dados_depois', FView.AsTextoDepois);

    Fields.Add('narrativa', LNarrativa);
    FPersistence.Insert('nemesis.cp_auditoria', Fields);
  finally
    Fields.Free;
  end;
end;

end.

