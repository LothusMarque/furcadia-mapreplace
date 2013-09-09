program MRGUI;

uses
  Forms,
  MRGUIUnit1 in 'MRGUIUnit1.pas' {MapReplaceGUIForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMapReplaceGUIForm, MapReplaceGUIForm);
  Application.Run;
end.
