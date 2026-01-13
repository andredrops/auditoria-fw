unit uAuditoriaContexto;

interface

uses
  uAuditoriaIntf;

type
  TAuditoriaContexto = class(TInterfacedObject, IAuditoriaContexto)
  private
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

  public
    function SetModulo(const AValue: string): IAuditoriaContexto;
    function GetModulo: string;

    function SetTela(const AValue: string): IAuditoriaContexto;
    function GetTela: string;

    function SetOrigem(const AValue: string): IAuditoriaContexto;
    function GetOrigem: string;

    function SetUsuario(const AValue: string): IAuditoriaContexto;
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

    function SetSuporteLogin(const AValue: string): IAuditoriaContexto;
    function SetSuporteNome(const AValue: string): IAuditoriaContexto;
    function SetAmbiente(const AValue: Integer): IAuditoriaContexto;
    function GetSuporteLogin: string;
    function GetSuporteNome: string;
    function GetAmbiente: Integer;
  end;

implementation

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

function TAuditoriaContexto.SetOrigem(const AValue: string): IAuditoriaContexto;
begin
  FOrigem := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetOrigem: string;
begin
  Result := FOrigem;
end;

function TAuditoriaContexto.SetUsuario(const AValue: string): IAuditoriaContexto;
begin
  FUsuarioNome := AValue;
  Result := Self;
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

function TAuditoriaContexto.GetEmpregadorId: Int64;
begin
  Result := FEmpregadorId;
end;

function TAuditoriaContexto.GetEmpregadorNome: string;
begin
  Result := FEmpregadorNome;
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

function TAuditoriaContexto.GetProfissionalId: Int64;
begin
  Result := FProfissionalId;
end;

function TAuditoriaContexto.GetProfissionalNome: string;
begin
  Result := FProfissionalNome;
end;

function TAuditoriaContexto.SetSuporteLogin(const AValue: string): IAuditoriaContexto;
begin
  FSuporteLogin := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetSuporteNome(const AValue: string): IAuditoriaContexto;
begin
  FSuporteNome := AValue;
  Result := Self;
end;

function TAuditoriaContexto.SetAmbiente(const AValue: Integer): IAuditoriaContexto;
begin
  FAmbiente := AValue;
  Result := Self;
end;

function TAuditoriaContexto.GetSuporteLogin: string;
begin
  Result := FSuporteLogin;
end;

function TAuditoriaContexto.GetSuporteNome: string;
begin
  Result := FSuporteNome;
end;

function TAuditoriaContexto.GetAmbiente: Integer;
begin
  Result := FAmbiente;
end;

end.

