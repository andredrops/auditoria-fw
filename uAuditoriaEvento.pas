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
    class var FInstance: IAuditoriaEvento;

    FPersistence: IAuditPersistence;
    FContexto: IAuditoriaContexto;

    FOperacao: string;
    FDescricao: string;

    procedure Persistir;
  public
    class function GetInstance(): IAuditoriaEvento;

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
  System.DateUtils, uAuditoriaTipos, uAuditoriaPersistirGeral, uAuditoriaPersistirSuporte, uBaseDAO, uAuditoriaFactory;

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
  Self.Persistir();
end;


class function TAuditoriaEvento.GetInstance: IAuditoriaEvento;
begin
  if not Assigned(FInstance) then
    FInstance := TAuditoriaFactory.CriarEvento(FDBaseDAO, TAuditoriaContexto.GetInstance);
  Result := FInstance;
end;

procedure TAuditoriaEvento.Persistir;
var
  Persistidor: IAuditoriaPersistir;
begin
  if FPersistence = nil then
    Exit;

  case FContexto.GetPoliticaAuditoria of
    apApenasGeral:
      if not FContexto.EhSuporte then
        Persistidor := TAuditoriaPersistirGeral.Create(
          FPersistence, FContexto, nil
        );

    apApenasSuporte:
      if FContexto.EhSuporte then
        Persistidor := TAuditoriaPersistirSuporte.Create(
          FPersistence, FContexto, nil
        );

    apGeralESuporte:
      begin
        if FContexto.EhSuporte then
          Persistidor := TAuditoriaPersistirSuporte.Create(
            FPersistence, FContexto, nil
          )
        else
          Persistidor := TAuditoriaPersistirGeral.Create(
            FPersistence, FContexto, nil
          );
      end;
  end;

  if Assigned(Persistidor) then
    Persistidor.Persistir;
end;


end.

