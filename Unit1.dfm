object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Manipular Arquivos Textos'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 108
    Top = 16
    Width = 80
    Height = 25
    Caption = 'MemoryStream'
    TabOrder = 0
    OnClick = Button1Click
  end
  object BtTextFileTest: TButton
    Left = 194
    Top = 16
    Width = 80
    Height = 25
    Caption = 'TextFile'
    TabOrder = 1
    OnClick = BtTextFileTestClick
  end
  object BtFileStreamTest: TButton
    Left = 280
    Top = 16
    Width = 73
    Height = 25
    Caption = 'FileStream'
    TabOrder = 2
    OnClick = BtFileStreamTestClick
  end
  object BtStringListTest: TButton
    Left = 359
    Top = 16
    Width = 80
    Height = 25
    Caption = 'StringList'
    TabOrder = 3
    OnClick = BtStringListTestClick
  end
  object BtStringStreamTest: TButton
    Left = 445
    Top = 16
    Width = 80
    Height = 25
    Caption = 'StringStream'
    TabOrder = 4
    OnClick = BtStringStreamTestClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 50
    Width = 619
    Height = 241
    ActivePage = TabSheet1
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'Velocidade'
      object Memo1: TMemo
        Left = 0
        Top = 18
        Width = 609
        Height = 195
        TabOrder = 0
      end
    end
    object MemoryStream: TTabSheet
      Caption = 'MemoryStream'
      ImageIndex = 5
      object mnMemory: TMemo
        Left = 2
        Top = 18
        Width = 296
        Height = 195
        TabOrder = 0
      end
      object mnMemoryWhile: TMemo
        Left = 304
        Top = 18
        Width = 304
        Height = 195
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TextFile'
      ImageIndex = 1
      object MnTextFile: TRichEdit
        Left = 3
        Top = 3
        Width = 295
        Height = 207
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object MnTextFileWhile: TRichEdit
        Left = 304
        Top = 3
        Width = 304
        Height = 207
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'FileStream'
      ImageIndex = 2
      object mnFileStream: TMemo
        Left = 2
        Top = 18
        Width = 296
        Height = 195
        TabOrder = 0
      end
      object MnFileStreamWhile: TMemo
        Left = 304
        Top = 18
        Width = 304
        Height = 195
        TabOrder = 1
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'StringList'
      ImageIndex = 3
      object MnStringList: TMemo
        Left = 2
        Top = 18
        Width = 609
        Height = 195
        TabOrder = 0
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'StringStream'
      ImageIndex = 4
      object MnStringStream: TMemo
        Left = 0
        Top = 18
        Width = 298
        Height = 195
        TabOrder = 0
      end
      object MnStringStreamWhile: TMemo
        Left = 304
        Top = 18
        Width = 304
        Height = 195
        TabOrder = 1
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'StreamReader'
      ImageIndex = 6
      object MnStreamReader: TMemo
        Left = 2
        Top = 15
        Width = 287
        Height = 195
        TabOrder = 0
      end
      object MnStreamReaderWhile: TMemo
        Left = 295
        Top = 15
        Width = 306
        Height = 195
        TabOrder = 1
      end
    end
  end
  object BtStreamReader: TButton
    Left = 531
    Top = 16
    Width = 80
    Height = 25
    Caption = 'StreamReader'
    TabOrder = 6
    OnClick = BtStreamReaderClick
  end
  object BtnBench: TButton
    Left = 18
    Top = 16
    Width = 80
    Height = 25
    Caption = 'BenchMark'
    TabOrder = 7
    OnClick = BtnBenchClick
  end
  object OpenDialog1: TOpenDialog
    Left = 40
    Top = 56
  end
end
