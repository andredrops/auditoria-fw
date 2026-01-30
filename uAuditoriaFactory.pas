unit uAuditoriaFactory;

interface

uses
  uAuditoriaIntf,
  uAuditPersistenceIntf,
  uAuditoriaContexto,
  uAuditoriaView,
  uAuditoriaAlteracao,
  uAuditPersistenceZeos,
  ZConnection, uAuditoriaTipos;

type

  TAuditoriaFactory = class
  public
    class function CriarContexto(const AEhSuporte: Boolean;
                                 const APolitica: TAuditoriaPolitica): IAuditoriaContexto;
    class function CriarView(): IAuditoriaView;
    class function CriarAlteracao(const AConn: TZConnection;
                                  const AContexto: IAuditoriaContexto;
                                  const AView: IAuditoriaView): IAuditoriaAlteracao;
    class function PoliticaApenasGeral: TAuditoriaPolitica;
    class function PoliticaApenasSuporte: TAuditoriaPolitica;
    class function PoliticaGeralESuporte: TAuditoriaPolitica;

  end;

implementation

{ TAuditoriaFactory }

class function TAuditoriaFactory.CriarContexto(const AEhSuporte: Boolean;
                                               const APolitica: TAuditoriaPolitica): IAuditoriaContexto;
begin
  Result := TAuditoriaContexto.Create(AEhSuporte, APolitica);
end;

class function TAuditoriaFactory.CriarView: IAuditoriaView;
begin
  Result := TAuditoriaView.Create;
end;

class function TAuditoriaFactory.PoliticaApenasGeral: TAuditoriaPolitica;
begin
  Result := apApenasGeral;
end;

class function TAuditoriaFactory.PoliticaApenasSuporte: TAuditoriaPolitica;
begin
  Result := apApenasSuporte;
end;

class function TAuditoriaFactory.PoliticaGeralESuporte: TAuditoriaPolitica;
begin
  Result := apGeralESuporte;
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

