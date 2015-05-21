program Мультиварка;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  ClassesUnit in 'ClassesUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
