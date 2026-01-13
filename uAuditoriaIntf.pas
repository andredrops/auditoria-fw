unit uAuditoriaIntf;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Vcl.Forms,
  uAuditoriaAlteracaoItem;

type

  IAuditoriaEvento = interface
    ['{E60602E1-2E5F-4716-9806-B5020C85DEBA}']
    function SetOperacao(const AValue: string): IAuditoriaEvento;
    function SetDescricao(const AValue: string): IAuditoriaEvento;
    procedure Gerar;
  end;


type
  IAuditoriaContexto = interface
    ['{BBE52D80-611E-4506-BDAD-575D954ADA9B}']

    function SetModulo(const AValue: string): IAuditoriaContexto;
    function GetModulo: string;

    function SetTela(const AValue: string): IAuditoriaContexto;
    function GetTela: string;

    function SetOrigem(const AValue: string): IAuditoriaContexto;
    function GetOrigem: string;

    function SetUsuario(const AValue: string): IAuditoriaContexto; // compatibilidade
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



  IAuditoriaView = interface
    ['{42EE887A-8CE2-45E4-A64C-6CA7093E5EC6}']

    function AddToBlacklist(AComponent: TComponent): IAuditoriaView;

    procedure CapturarEstadoInicial(AForm: TCustomForm);
    function GerarAuditoria(AForm: TCustomForm): IAuditoriaView;

    function GetAlteracoes: TList<TAuditoriaAlteracaoItem>;
    function AsTextoAntes: string;
    function AsTextoDepois: string;
    function AsTextoCompleto: string;
  end;

  IAuditoriaAlteracao = interface
  ['{A03EEAC8-88CC-4CD9-AB7C-366A27797E32}']
    procedure Persistir;
  end;


  IAuditoria = interface
    ['{01B9A8DC-417E-41CE-9E1E-6F97B354EBCB}']
    function Contexto: IAuditoriaContexto;
    function Evento: IAuditoriaEvento;
    function View: IAuditoriaView;
    procedure Clear;
  end;

implementation

end.

