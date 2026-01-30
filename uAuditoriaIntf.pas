unit uAuditoriaIntf;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Vcl.Forms,
  uAuditoriaAlteracaoItem,
  uAuditoriaTipos;

type
  IAuditoriaContexto = interface
    ['{BBE52D80-611E-4506-BDAD-575D954ADA9B}']

    function EhSuporte: Boolean;
    function GetPoliticaAuditoria: TAuditoriaPolitica;

    function AtivarPoliticaApenasSuporte(): IAuditoriaContexto;
    function AtivarPoliticaApenasGeral(): IAuditoriaContexto;

    function SetUsuarioId(const AValue: Int64): IAuditoriaContexto;
    function GetUsuarioId: Int64;
    function SetUsuarioNome(const AValue: string): IAuditoriaContexto;
    function GetUsuarioNome: string;

    function SetUnidadeId(const AValue: Int64): IAuditoriaContexto;
    function SetUnidadeNome(const AValue: string): IAuditoriaContexto;
    function GetUnidadeId: Int64;
    function GetUnidadeNome: string;

    function SetEmpregadorId(const AValue: Int64): IAuditoriaContexto;
    function GetEmpregadorId: Int64;
    function SetEmpregadorNome(const AValue: string): IAuditoriaContexto;
    function GetEmpregadorNome: string;

    function SetProfissionalId(const AValue: Int64): IAuditoriaContexto;
    function GetProfissionalId: Int64;
    function SetProfissionalNome(const AValue: string): IAuditoriaContexto;
    function GetProfissionalNome: string;

    function SetModulo(const AValue: string): IAuditoriaContexto;
    function GetModulo: string;

    function SetTela(const AValue: string): IAuditoriaContexto;
    function GetTela: string;

    function SetIdAfetado(const AValue: string): IAuditoriaContexto;
    function GetIdAfetado: string;

    function SetEvento(const AValue: string): IAuditoriaContexto;
    function GetEvento: string;
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
    function ApenasEvento: IAuditoriaAlteracao;
    procedure Persistir;
  end;

  IAuditoriaPersistir = interface
    ['{63A83D14-4E69-4DD3-A106-8DC2C99127F5}']
    procedure Persistir;
  end;


implementation


end.

