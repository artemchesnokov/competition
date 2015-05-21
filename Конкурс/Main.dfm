object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1052#1091#1083#1100#1090#1080#1074#1072#1088#1082#1072
  ClientHeight = 272
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    388
    272)
  PixelsPerInch = 96
  TextHeight = 13
  object WeightLabel: TLabel
    Left = 24
    Top = 77
    Width = 17
    Height = 13
    Caption = #1042#1077#1089
  end
  object ReceptionLabel: TLabel
    Left = 207
    Top = 31
    Width = 36
    Height = 13
    Caption = #1056#1077#1094#1077#1087#1090
  end
  object TemperatureLabel: TLabel
    Left = 207
    Top = 119
    Width = 66
    Height = 13
    Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
  end
  object Label1: TLabel
    Left = 207
    Top = 77
    Width = 110
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1087#1088#1080#1075#1086#1090#1086#1074#1083#1077#1085#1080#1103
  end
  object Label2: TLabel
    Left = 24
    Top = 31
    Width = 44
    Height = 13
    Caption = #1055#1088#1086#1076#1091#1082#1090
  end
  object TimerLabel: TLabel
    Left = 84
    Top = 216
    Width = 28
    Height = 13
    Anchors = [akTop]
    Caption = '00:00'
    ExplicitLeft = 96
  end
  object OKButton: TButton
    Left = 24
    Top = 173
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 0
    OnClick = OKButtonClick
  end
  object PauseButton: TButton
    Left = 180
    Top = 173
    Width = 75
    Height = 25
    Caption = #1055#1072#1091#1079#1072
    TabOrder = 1
    OnClick = PauseButtonClick
  end
  object EscapeButton: TButton
    Left = 277
    Top = 173
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = EscapeButtonClick
  end
  object WeightEdit: TEdit
    Left = 24
    Top = 96
    Width = 145
    Height = 21
    TabOrder = 3
  end
  object ReceptionComboBox: TComboBox
    Left = 207
    Top = 50
    Width = 145
    Height = 21
    TabOrder = 4
    OnChange = ReceptionComboBoxChange
    OnDropDown = ReceptionComboBoxDropDown
  end
  object TemperatureEdit: TEdit
    Left = 207
    Top = 138
    Width = 145
    Height = 21
    TabOrder = 5
  end
  object TimeEdit: TEdit
    Left = 207
    Top = 92
    Width = 145
    Height = 21
    TabOrder = 6
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 8
    Width = 145
    Height = 17
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1084#1091#1083#1100#1090#1080#1074#1072#1088#1082#1091
    TabOrder = 7
  end
  object ProductTypeTextBox: TEdit
    Left = 24
    Top = 50
    Width = 145
    Height = 21
    TabOrder = 8
  end
  object MainMenu: TMainMenu
    Left = 568
    Top = 65520
    object FileMainMenu: TMenuItem
      Caption = #1060#1072#1081#1083
      object AddPrescriptionSubMenu: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1094#1077#1087#1090
      end
      object QuitSubMenu: TMenuItem
        Caption = #1042#1099#1093#1086#1076'...'
        OnClick = QuitSubMenuClick
      end
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=q7nrg8jxBN;Persist Security Info=Tr' +
      'ue;User ID=artemchesnokov;Initial Catalog=microvaweDataBase;Data' +
      ' Source=yyui82w7o9.database.windows.net'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 528
    Top = 65520
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandText = 'Prescriptions'
    CommandType = cmdTable
    Parameters = <>
    Left = 472
    Top = 65520
    object ADODataSet1id: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object ADODataSet1product_type: TWideStringField
      FieldName = 'product_type'
      Size = 50
    end
    object ADODataSet1product_weight: TBCDField
      FieldName = 'product_weight'
      Precision = 3
      Size = 1
    end
    object ADODataSet1temperature: TIntegerField
      FieldName = 'temperature'
    end
    object ADODataSet1cooking_time: TIntegerField
      FieldName = 'cooking_time'
    end
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 353
    Top = 48
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Top = 48
  end
  object ADOQuery3: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Top = 96
  end
  object ADOQuery4: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 352
    Top = 88
  end
  object ADOQuery5: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 360
    Top = 136
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 120
    Top = 128
  end
  object TimerDataSet: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 80
    Top = 128
  end
  object TimerQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 104
    Top = 184
  end
end
