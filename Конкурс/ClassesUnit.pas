unit ClassesUnit;

interface

uses
     Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
     System.Classes, System.RegularExpressions, System.StrUtils, ShellAPI, ShlObj,
     System.Bindings.Helper, System.Bindings.Expression, System.IOUtils, System.Types,

     Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
     Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.FileCtrl, Vcl.Grids, System.DateUtils, Gauges,

     Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
     Vcl.Bind.Editors, Data.Bind.Components, Vcl.Samples.Spin,

     Xml.XMLIntf, Xml.XMLDoc, Xml.Xmldom, msxml;

type

  LogFileClass = class
  public
    Event: string;

    procedure CreateLogDirectoryAndFile(Event: string);
    procedure WriteEvent(Event: string);
    procedure ShowMessageEvent(Event: string);
  end;

implementation

    { LogFileClass }

procedure LogFileClass.CreateLogDirectoryAndFile;
var
  LogTextFile: TextFile;
  Directory, LogFileName, EventText: string;
begin
  EventText := '';
  Directory := ExtractFilePath(ParamStr(0)) + 'Logs';
  if DirectoryExists(Directory) = false then
{$I-}
    MkDir(Directory);
{$I+}
  LogFileName := FormatDateTime('YYYY-MM-DD', Now) + '.txt';
  AssignFile(LogTextFile, Directory + '\' + LogFileName);
  if IOResult = 0 then
    if FileExists(Directory + '\' + LogFileName) = false then
      Rewrite(LogTextFile);
  try
    FileMode := 1;
    Append(LogTextFile);
    if Event <> '' then
    begin
      EventText := FormatDateTime('YYYY-MM-DD|HH:mm:ss', Now) + '  ||    ' + Event;
      WriteLn(LogTextFile, EventText);
    end;
  finally
    CloseFile(LogTextFile);
  end;
end;

procedure LogFileClass.ShowMessageEvent(Event: string);
begin
  Self.CreateLogDirectoryAndFile(Event);
  MessageDlg(Event, mtError, [mbOK], 0);
end;


procedure LogFileClass.WriteEvent(Event: string);
begin
  Self.CreateLogDirectoryAndFile(Event);
end;
end.
