unit uAuditoriaContexto;

interface

uses
  uAuditoriaIntf, uAuditoriaTipos;

type
  TAuditoriaContexto = class(TInterfacedObject, IAuditoriaContexto)
  private
    class var FInstance : IAuditoriaContexto;

    FEhSuporte: Boolean;
    FPoliticaAuditoria: TAuditoriaPolitica;

    FModulo: string;
    FTela: string;
    FOrigem: string;

    FUsuarioId: Int64;
    FUsuarioNome: string;

    FUnidadeId: Int64;
    FUnidadeNome: string;

    FEmpregadorId: Int64;
    FEmpregadorNome: string;

    FProfissionalId: Int64;
    FProfissionalNome: string;

    FSuporteLogin: string;
    FSuporteNome: string;
    FAmbiente: Integer;

    FOperacao: string;
    FDescricao: string;
    FEvento: string;
    FIdAfetado: string;

  public
    class function GetInstance(): IAuditoriaContexto;

    function EhSuporte: Boolean;
    function GetPoliticaAuditoria: TAuditoriaPolitica;

    function AtivarPoliticaApenasSuporte(): IAuditoriaContexto;
    function AtivarPoliticaApenasGeral(): IAuditoriaContexto;

    function SetUsuarioId(const AValue: Int64): IAuditoriaContexto;
    function SetUsuarioNome(const AValue: string): IAuditoriaContexto;
    function GetUsuarioId: Int64;
    function GetUsuarioNome: string;

    function SetUnidadeId(const AValue: Int64): IAuditoriaContexto;
    function SetUnidadeNome(const AValue: string): IAuditoriaContexto;
    function GetUnidadeId: Int64;
    function GetUnidadeNome: string;

    function SetEmpregadorId(const AValue: Int64): IAuditoriaContexto;
    function SetEmpregadorNome(const AValue: string): IAuditoriaContexto;
    function GetEmpregadorId: Int64;
    function GetEmpregadorNome: string;

    function SetProfissionalId(const AValue: Int64): IAuditoriaContexto;
    function SetProfissionalNome(const AValue: string): IAuditoriaContexto;
    function GetProfissionalId: Int64;
    function GetProfissionalNome: string;

    function SetModulo(const AValue: string): IAuditoriaContexto;
    function GetModulo: string;

    function SetTela(const AValue: string): IAuditoriaContexto;
    function GetTela: string;

    function SetIdAfetado(const AValue: string): IAuditoriaContexto;
    function GetIdAfetado: string;

    function SetEvento(const AValue: string): IAuditoriaContexto;
    function GetEvento: string;

  public
    constructor Create(const AEhSuporte: Boolean;
                       const APolitica: TAuditoriaPolitica);
  end;

implementation

uses udmDados, uAuditoriaFactory;

function TAuditoriaContexto.SetModulo(const AValue: string): IAuditoriaContexto;
begin
  FModulo := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetModulo: string;
begin
  Result := FModulo;
end;

function TAuditoriaContexto.SetTela(const AValue: string): IAuditoriaContexto;
begin
  FTela := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetTela: string;
begin
  Result := FTela;
end;

function TAuditoriaContexto.SetUsuarioId(const AValue: Int64): IAuditoriaContexto;
begin
  FUsuarioId := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetUsuarioNome(const AValue: string): IAuditoriaContexto;
begin
  FUsuarioNome := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetUsuarioId: Int64;
begin
  Result := FUsuarioId;
end;

function TAuditoriaContexto.GetUsuarioNome: string;
begin
  Result := FUsuarioNome;
end;

function TAuditoriaContexto.SetUnidadeId(const AValue: Int64): IAuditoriaContexto;
begin
  FUnidadeId := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetUnidadeNome(const AValue: string): IAuditoriaContexto;
begin
  FUnidadeNome := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetUnidadeId: Int64;
begin
  Result := FUnidadeId;
end;

function TAuditoriaContexto.GetUnidadeNome: string;
begin
  Result := FUnidadeNome;
end;

function TAuditoriaContexto.SetEmpregadorId(const AValue: Int64): IAuditoriaContexto;
begin
  FEmpregadorId := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetEmpregadorNome(const AValue: string): IAuditoriaContexto;
begin
  FEmpregadorNome := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetEvento(const AValue: string): IAuditoriaContexto;
begin
  FEvento := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetIdAfetado(const AValue: string): IAuditoriaContexto;
begin
  FIdAfetado := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetEmpregadorId: Int64;
begin
  Result := FEmpregadorId;
end;

function TAuditoriaContexto.GetEmpregadorNome: string;
begin
  Result := FEmpregadorNome;
end;

function TAuditoriaContexto.GetEvento: string;
begin
  Result := FEvento;
end;

function TAuditoriaContexto.GetIdAfetado: string;
begin
  Result := FIdAfetado;
end;

class function TAuditoriaContexto.GetInstance: IAuditoriaContexto;
var
  LEhSuporte: Boolean;
begin
  LEhSuporte := dmDados.UsuarioLogin.EhUsuarioSupervisorOuSuporte;

  if not Assigned(FInstance) then
    FInstance := TAuditoriaFactory.CriarContexto(LEhSuporte, TAuditoriaFactory.PoliticaGeralESuporte);

  Result := FInstance;
end;

function TAuditoriaContexto.SetProfissionalId(const AValue: Int64): IAuditoriaContexto;
begin
  FProfissionalId := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetProfissionalNome(const AValue: string): IAuditoriaContexto;
begin
  FProfissionalNome := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetPoliticaAuditoria: TAuditoriaPolitica;
begin
  Result := FPoliticaAuditoria;
end;

function TAuditoriaContexto.GetProfissionalId: Int64;
begin
  Result := FProfissionalId;
end;

function TAuditoriaContexto.GetProfissionalNome: string;
begin
  Result := FProfissionalNome;
end;


function TAuditoriaContexto.AtivarPoliticaApenasGeral: IAuditoriaContexto;
begin
  Result := Self;
  FPoliticaAuditoria := apApenasGeral;
end;

function TAuditoriaContexto.AtivarPoliticaApenasSuporte: IAuditoriaContexto;
begin
  Result := Self;
  FPoliticaAuditoria := apApenasSuporte;
end;

constructor TAuditoriaContexto.Create(const AEhSuporte: Boolean; const APolitica: TAuditoriaPolitica);
begin
  inherited Create;
  FEhSuporte := AEhSuporte;
  FPoliticaAuditoria := APolitica;
end;

function TAuditoriaContexto.EhSuporte: Boolean;
begin
  Result := FEhSuporte;
end;

end.

