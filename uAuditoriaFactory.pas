unit uAuditoriaFactory;

interface

uses
  uAuditoriaIntf,
  uAuditPersistenceIntf,
  uAuditoriaContexto,
  uAuditoriaEvento,
  uAuditoriaView,
  uAuditoriaAlteracao,
  uAuditPersistenceZeos,
  ZConnection;

type
  TAuditoriaFactory = class
  public
    class function CriarContexto(): IAuditoriaContexto;
    class function CriarEvento(const AConn: TZConnection;
                               const AContexto: IAuditoriaContexto): IAuditoriaEvento;
    class function CriarView(): IAuditoriaView;
    class function CriarAlteracao(const AConn: TZConnection;
                                  const AContexto: IAuditoriaContexto;
                                  const AView: IAuditoriaView): IAuditoriaAlteracao;
  end;

implementation

{ TAuditoriaFactory }

class function TAuditoriaFactory.CriarContexto: IAuditoriaContexto;
begin
  Result := TAuditoriaContexto.Create;
end;

class function TAuditoriaFactory.CriarEvento(
  const AConn: TZConnection;
  const AContexto: IAuditoriaContexto
): IAuditoriaEvento;
begin
  Result := TAuditoriaEvento.Create(
    TAuditPersistenceZeos.Create(AConn),
    AContexto
  );
end;

class function TAuditoriaFactory.CriarView: IAuditoriaView;
begin
  Result := TAuditoriaView.Create;
end;

class function TAuditoriaFactory.CriarAlteracao(const AConn: TZConnection;
                                  const AContexto: IAuditoriaContexto;
                                  const AView: IAuditoriaView): IAuditoriaAlteracao;
begin
  Result := TAuditoriaAlteracao.Create(
    TAuditPersistenceZeos.Create(AConn),
    AContexto,
    AView
  );
end;

end.

