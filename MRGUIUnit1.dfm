object MapReplaceGUIForm: TMapReplaceGUIForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MapReplace GUI Utility'
  ClientHeight = 270
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 3
    Top = 4
    Width = 441
    Height = 263
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet3: TTabSheet
      Caption = 'Start'
      ImageIndex = 3
      object Label5: TLabel
        Left = 6
        Top = 68
        Width = 67
        Height = 13
        Caption = 'Replace Mode'
      end
      object Label6: TLabel
        Left = 6
        Top = 11
        Width = 49
        Height = 13
        Caption = 'Input File:'
      end
      object Label7: TLabel
        Left = 6
        Top = 38
        Width = 57
        Height = 13
        Caption = 'Output File:'
      end
      object SpinCustomSeed: TSpinEdit
        Left = 96
        Top = 92
        Width = 145
        Height = 22
        Enabled = False
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object chkCustomSeed: TCheckBox
        Left = 6
        Top = 94
        Width = 87
        Height = 17
        Caption = 'Custom Seed:'
        TabOrder = 1
        OnClick = chkCustomSeedClick
      end
      object cbMode: TComboBox
        Left = 96
        Top = 65
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Sequential'
        Items.Strings = (
          'Sequential'
          'Random')
      end
      object ed_InputFile: TEdit
        Left = 96
        Top = 8
        Width = 253
        Height = 21
        TabOrder = 3
      end
      object btn_Input: TButton
        Left = 355
        Top = 6
        Width = 75
        Height = 25
        Caption = 'Browse...'
        TabOrder = 4
        OnClick = btn_InputClick
      end
      object ed_OutputFile: TEdit
        Left = 96
        Top = 35
        Width = 253
        Height = 21
        TabOrder = 5
      end
      object btn_Output: TButton
        Left = 355
        Top = 33
        Width = 75
        Height = 25
        Caption = 'Browse...'
        TabOrder = 6
        OnClick = btn_OutputClick
      end
      object chkNoBackup: TCheckBox
        Left = 6
        Top = 120
        Width = 125
        Height = 17
        Caption = 'Do not make backups'
        TabOrder = 7
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Objects'
      object Label1: TLabel
        Left = 8
        Top = 4
        Width = 72
        Height = 13
        Caption = 'Objects (From)'
      end
      object Label2: TLabel
        Left = 230
        Top = 4
        Width = 60
        Height = 13
        Caption = 'Objects (To)'
      end
      object lb_ObjTo: TListBox
        Left = 234
        Top = 22
        Width = 139
        Height = 179
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
        OnClick = lb_ObjToClick
      end
      object lb_objfrom: TListBox
        Left = 8
        Top = 23
        Width = 139
        Height = 179
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 1
        OnClick = lb_objfromClick
      end
      object btn_addObjFrom: TButton
        Left = 153
        Top = 207
        Width = 43
        Height = 25
        Caption = 'Add'
        TabOrder = 2
        OnClick = btn_addObjFromClick
      end
      object edObjectFrom: TEdit
        Left = 8
        Top = 208
        Width = 139
        Height = 21
        TabOrder = 3
        OnKeyUp = edObjectFromKeyUp
      end
      object btn_OF_Up: TButton
        Left = 153
        Top = 23
        Width = 43
        Height = 25
        Caption = #233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btn_OF_UpClick
      end
      object btn_OF_Down: TButton
        Left = 153
        Top = 48
        Width = 43
        Height = 25
        Caption = #234
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btn_OF_DownClick
      end
      object btn_OF_Del: TButton
        Left = 153
        Top = 73
        Width = 43
        Height = 25
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btn_OF_DelClick
      end
      object btn_OT_Up: TButton
        Left = 379
        Top = 23
        Width = 43
        Height = 25
        Caption = #233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object btn_OT_Down: TButton
        Left = 379
        Top = 48
        Width = 43
        Height = 25
        Caption = #234
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object btn_OT_Del: TButton
        Left = 379
        Top = 73
        Width = 43
        Height = 25
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = btn_OT_DelClick
      end
      object btn_ObjToAdd: TButton
        Left = 379
        Top = 207
        Width = 43
        Height = 25
        Caption = 'Add'
        TabOrder = 10
        OnClick = btn_ObjToAddClick
      end
      object edObjectTo: TEdit
        Left = 234
        Top = 207
        Width = 139
        Height = 21
        TabOrder = 11
        OnKeyUp = edObjectToKeyUp
      end
    end
    object Floors: TTabSheet
      Caption = 'Floors'
      ImageIndex = 1
      object Label3: TLabel
        Left = 8
        Top = 4
        Width = 64
        Height = 13
        Caption = 'Floors (From)'
      end
      object Label4: TLabel
        Left = 230
        Top = 4
        Width = 52
        Height = 13
        Caption = 'Floors (To)'
      end
      object lb_floorto: TListBox
        Left = 234
        Top = 22
        Width = 139
        Height = 179
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
        OnClick = lb_floortoClick
      end
      object btn_FF_Up: TButton
        Left = 153
        Top = 23
        Width = 43
        Height = 25
        Caption = #233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btn_FF_UpClick
      end
      object btn_FF_Down: TButton
        Left = 153
        Top = 48
        Width = 43
        Height = 25
        Caption = #234
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btn_FF_DownClick
      end
      object btn_FF_Del: TButton
        Left = 153
        Top = 73
        Width = 43
        Height = 25
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btn_FF_DelClick
      end
      object lb_floorfrom: TListBox
        Left = 8
        Top = 23
        Width = 139
        Height = 179
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 4
        OnClick = lb_floorfromClick
      end
      object edFloorFrom: TEdit
        Left = 8
        Top = 208
        Width = 139
        Height = 21
        TabOrder = 5
        OnKeyUp = edFloorFromKeyUp
      end
      object btn_addFlrFrom: TButton
        Left = 153
        Top = 207
        Width = 43
        Height = 25
        Caption = 'Add'
        TabOrder = 6
        OnClick = btn_addFlrFromClick
      end
      object edFloorTo: TEdit
        Left = 234
        Top = 207
        Width = 139
        Height = 21
        TabOrder = 7
        OnKeyUp = edFloorToKeyUp
      end
      object btn_addFlrTo: TButton
        Left = 379
        Top = 207
        Width = 43
        Height = 25
        Caption = 'Add'
        TabOrder = 8
        OnClick = btn_addFlrToClick
      end
      object btn_FT_Del: TButton
        Left = 379
        Top = 73
        Width = 43
        Height = 25
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = btn_FT_DelClick
      end
      object btn_FT_Down: TButton
        Left = 379
        Top = 48
        Width = 43
        Height = 25
        Caption = #234
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = btn_FT_DownClick
      end
      object btn_FT_Up: TButton
        Left = 379
        Top = 23
        Width = 43
        Height = 25
        Caption = #233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = btn_FT_UpClick
      end
    end
    object TS_Run: TTabSheet
      Caption = 'Run/Output'
      ImageIndex = 2
      OnShow = TS_RunShow
      object OutputMemo: TMemo
        Left = 3
        Top = 28
        Width = 422
        Height = 204
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnExecute: TButton
        Left = 176
        Top = 0
        Width = 75
        Height = 25
        Caption = 'Execute!'
        TabOrder = 1
        OnClick = btnExecuteClick
      end
      object chkVerbose: TCheckBox
        Left = 3
        Top = 5
        Width = 87
        Height = 17
        Caption = 'Verbose'
        TabOrder = 2
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'map'
    Filter = 'Furcadia Map|*.map|All Files|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 302
    Top = 56
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'map'
    Filter = 'Furcadia Map|*.map|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 338
    Top = 56
  end
end
