unit uAuditoriaAlteracao;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Generics.Collections,

  uAuditoriaIntf,
  uAuditPersistenceIntf,
  uAuditoriaTipos;

type
  TAuditoriaAlteracao = class(TInterfacedObject, IAuditoriaAlteracao)
  private
    class var FInstance: IAuditoriaAlteracao;

    FPersistence: IAuditPersistence;
    FContexto: IAuditoriaContexto;
    FView: IAuditoriaView;
    FApenasEvento: Boolean;

  public
    class function GetInstance(): IAuditoriaAlteracao;

    function ApenasEvento: IAuditoriaAlteracao;

    constructor Create(
      const APersistence: IAuditPersistence;
      const AContexto: IAuditoriaContexto;
      const AView: IAuditoriaView
    );

    procedure Persistir;
  end;

implementation

uses
  System.DateUtils, uAuditoriaNarrativa, uAuditoriaPersistirGeral, uAuditoriaPersistirSuporte, uBaseDAO, uAuditoriaFactory, uAuditoriaView, uAuditoriaContexto;

{ TAuditoriaAlteracao }

function TAuditoriaAlteracao.ApenasEvento: IAuditoriaAlteracao;
begin
  FApenasEvento := True;
  Result := Self;
end;

constructor TAuditoriaAlteracao.Create(
  const APersistence: IAuditPersistence;
  const AContexto: IAuditoriaContexto;
  const AView: IAuditoriaView
);
begin
  FPersistence := APersistence;
  FContexto := AContexto;
  FView := AView;
  FApenasEvento:= False;
end;

class function TAuditoriaAlteracao.GetInstance: IAuditoriaAlteracao;
begin
  if not Assigned(FInstance) then
    FInstance := TAuditoriaFactory.CriarAlteracao(FDBaseDAO,
                                                  TAuditoriaContexto.GetInstance,
                                                  TAuditoriaView.GetInstance);
  Result := FInstance;
end;

procedure TAuditoriaAlteracao.Persistir;
var
  Persistidor: IAuditoriaPersistir;
begin
  if (FPersistence = nil)  then
    Exit;

  if Assigned(FView) then
    if (FView.GetAlteracoes.Count = 0) and (FApenasEvento = False) then
        Exit;

  case FContexto.GetPoliticaAuditoria of
    apApenasGeral:
      if not FContexto.EhSuporte then
        Persistidor := TAuditoriaPersistirGeral.Create(
          FPersistence, FContexto, FView
        );

    apApenasSuporte:
      if FContexto.EhSuporte then
        Persistidor := TAuditoriaPersistirSuporte.Create(
          FPersistence, FContexto, FView
        );

    apGeralESuporte:
      begin
        if FContexto.EhSuporte then
          Persistidor := TAuditoriaPersistirSuporte.Create(
            FPersistence, FContexto, FView
          )
        else
          Persistidor := TAuditoriaPersistirGeral.Create(
            FPersistence, FContexto, FView
          );
      end;
  end;

  if Assigned(Persistidor) then
    Persistidor.Persistir;
end;


end.

