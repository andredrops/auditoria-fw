unit uAuditoriaGeral;

interface

uses
  uIAuditoria, uAuditoriaBase, uIAuditPersistence;

type
  TAuditoriaGeral = class(TAuditoriaBase)
  protected
    function TableName: string;
  public
    class function New(const APersistence: IAuditPersistence): IAuditoriaBase;
  end;

implementation

{ TAuditoriaGeral }

class function TAuditoriaGeral.New(const APersistence: IAuditPersistence): IAuditoriaBase;
begin
  Result := TAuditoriaGeral.Create(APersistence);
end;

function TAuditoriaGeral.TableName: string;
begin
  Result := 'cp_auditoria';
end;

end.

