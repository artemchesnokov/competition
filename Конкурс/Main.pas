unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ClassesUnit, Vcl.Menus,
  Data.DB, Data.Win.ADODB, Vcl.ExtCtrls;

type
  LogFileClass = class
    public
      Event: string;

      procedure CreateLogDirectoryAndFile(Event: string);
      procedure WriteEvent(Event: string);
      procedure ShowMessageEvent(Event: string);
    end;

  TForm1 = class(TForm)
    OKButton: TButton;
    PauseButton: TButton;
    EscapeButton: TButton;
    WeightEdit: TEdit;
    ReceptionComboBox: TComboBox;
    TemperatureEdit: TEdit;
    TimeEdit: TEdit;
    WeightLabel: TLabel;
    ReceptionLabel: TLabel;
    TemperatureLabel: TLabel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    MainMenu: TMainMenu;
    FileMainMenu: TMenuItem;
    AddPrescriptionSubMenu: TMenuItem;
    QuitSubMenu: TMenuItem;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    ADODataSet1id: TAutoIncField;
    ADODataSet1product_type: TWideStringField;
    ADODataSet1product_weight: TBCDField;
    ADODataSet1temperature: TIntegerField;
    ADODataSet1cooking_time: TIntegerField;
    ProductTypeTextBox: TEdit;
    Label2: TLabel;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    ADOQuery4: TADOQuery;
    ADOQuery5: TADOQuery;
    Timer1: TTimer;
    TimerLabel: TLabel;
    TimerDataSet: TADODataSet;
    TimerQuery: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKButtonClick(Sender: TObject);
    procedure QuitSubMenuClick(Sender: TObject);
    procedure ReceptionComboBoxDropDown(Sender: TObject);
    procedure ReceptionComboBoxChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure EscapeButtonClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Event: LogFileClass;
  EndTime: LongInt;
  paused: boolean;
implementation

{$R *.dfm}

{$REGION 'LogFileClass'}
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
{$ENDREGION}


procedure TForm1.FormShow(Sender: TObject);
begin
  Event := LogFileClass.Create;
  TimerLabel.Height := 47;
  TimerLabel.Width := 221;
  TimerLabel.Caption := '00:00:00';
  TimerLabel.Font.Size := 30;
  Timer1.Enabled := False;
end;

procedure TForm1.QuitSubMenuClick(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.ReceptionComboBoxChange(Sender: TObject);
begin
  Form1.ADOQuery2.Close;
  Form1.ADOQuery2.SQL.Clear;
  Form1.ADOQuery2.SQL.Add('SELECT product_type FROM Prescriptions WHERE prescription_name=:product');
  Form1.ADOQuery2.Parameters.ParamByName('product').Value := ReceptionComboBox.Text;
  Form1.ADOQuery2.Open;
  while not ADOQuery2.Eof do
    begin
      ProductTypeTextBox.Text := ADOQuery2.Fields[0].Text;
      ADOQuery2.Next;
    end;

  Form1.ADOQuery3.Close;
  Form1.ADOQuery3.SQL.Clear;
  Form1.ADOQuery3.SQL.Add('SELECT product_weight FROM Prescriptions WHERE prescription_name=:product');
  Form1.ADOQuery3.Parameters.ParamByName('product').Value := ReceptionComboBox.Text;
  Form1.ADOQuery3.Open;
  while not ADOQuery3.Eof do
    begin
      WeightEdit.Text := ADOQuery3.Fields[0].Text;
      ADOQuery3.Next;
    end;

  Form1.ADOQuery4.Close;
  Form1.ADOQuery4.SQL.Clear;
  Form1.ADOQuery4.SQL.Add('SELECT cooking_time FROM Prescriptions WHERE prescription_name=:product');
  Form1.ADOQuery4.Parameters.ParamByName('product').Value := ReceptionComboBox.Text;
  Form1.ADOQuery4.Open;
  while not ADOQuery4.Eof do
    begin
      TimeEdit.Text := ADOQuery4.Fields[0].Text;
      ADOQuery4.Next;
    end;

  Form1.ADOQuery5.Close;
  Form1.ADOQuery5.SQL.Clear;
  Form1.ADOQuery5.SQL.Add('SELECT temperature FROM Prescriptions WHERE prescription_name=:product');
  Form1.ADOQuery5.Parameters.ParamByName('product').Value := ReceptionComboBox.Text;
  Form1.ADOQuery5.Open;
  while not ADOQuery5.Eof do
    begin
      TemperatureEdit.Text := ADOQuery5.Fields[0].Text;
      ADOQuery5.Next;
    end;
end;


 procedure TForm1.OKButtonClick(Sender: TObject);
begin
  if CheckBox1.Checked = false then
    begin
      Event.ShowMessageEvent('�� �� �������� �����������!');
    end;
  if (ProductTypeTextBox.Text = '') OR (WeightEdit.Text = '') OR (TimeEdit.Text = '') OR (TemperatureEdit.Text = '') then
  begin
    Event.ShowMessageEvent('������� �� ��� ������!');
  end;
  if (CheckBox1.Checked = True) AND (ProductTypeTextBox.Text <> '') AND (WeightEdit.Text <> '') AND (TimeEdit.Text <> '')
        AND (TemperatureEdit.Text <> '')  then
  begin
      EndTime := StrToInt(TimeEdit.Text) * 60;
      Timer1.Enabled := True;
      Event.WriteEvent('������ ������������� �����: '+ ReceptionComboBox.Text);
      ProductTypeTextBox.Enabled := false;
      WeightEdit.Enabled := false;
      ReceptionComboBox.Enabled := false;
      TimeEdit.Enabled := false;
      TemperatureEdit.Enabled := false;
      OKButton.Enabled := false;
  end;
  end;


procedure TForm1.PauseButtonClick(Sender: TObject);
begin
  if PauseButton.Caption='�����' then
  begin
    paused := True;
    PauseButton.Caption:='����������';
  end else
  begin
    paused := False;
    PauseButton.Caption:='�����';
  end;
end;

procedure TForm1.ReceptionComboBoxDropDown(Sender: TObject);
begin
  ReceptionComboBox.Items.Clear;
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('SELECT * FROM Prescriptions');
  ADOQuery1.Open;
  while not ADOQuery1.Eof do
    begin
      ReceptionComboBox.Items.Add(ADOQuery1.Fields[5].Text);
      ADOQuery1.Next;
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var H,M,S: Byte;
begin
  if paused then exit;
  Dec(EndTime);

//  Form1.TimerQuery.Close;
//  Form1.TimerQuery.SQL.Clear;
//  Form1.TimerQuery.SQL.Add('SELECT Time FROM Timer');
//  Form1.TimerQuery.Open;
//  while not TimerQuery.Eof do
//    begin
//      EndTime := StrToInt(TimerQuery.Fields[0].Text);
//      TimerQuery.Next;
//    end;


  S := EndTime mod 60;
  M := EndTime div 60 mod 60;
  H := EndTime div 3600;
  TimerLabel.Caption := IntToStr(H) + ':' + IntToStr(M) + ':' + IntToStr(S);

//  Form1.TimerQuery.Close;
//  Form1.TimerQuery.SQL.Clear;
//  Form1.TimerQuery.SQL.Add('UPDATE Timer SET Time=:param1');
//  Form1.TimerQuery.Parameters.ParamByName('param1').Value := EndTime;
//  Form1.TimerQuery.Open;

  if EndTime = 0 then
  begin
      ShowMessage('��������� ��������!');
      Event.WriteEvent('�����: '+ ReceptionComboBox.Text + '������������!');
      ProductTypeTextBox.Enabled := true;
      WeightEdit.Enabled := true;
      ReceptionComboBox.Enabled := true;
      TimeEdit.Enabled := true;
      TemperatureEdit.Enabled := true;
      Timer1.Enabled := False;
  end;
end;

procedure TForm1.EscapeButtonClick(Sender: TObject);
begin
      if Timer1.Enabled = false then
      begin
        Event.ShowMessageEvent('������ �������� ��, ���� �� ��������!');
      end;
      ProductTypeTextBox.Enabled := true;
      WeightEdit.Enabled := true;
      ReceptionComboBox.Enabled := true;
      TimeEdit.Enabled := true;
      TemperatureEdit.Enabled := true;
      Timer1.Enabled := False;
      TimerLabel.Caption := '00:00:00';
      EndTime := 0;
      OKButton.Enabled := true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Event.Destroy;
end;
end.
