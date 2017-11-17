////BY FABIANO S. PASSIANOTO ///////
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    BtTextFileTest: TButton;
    BtFileStreamTest: TButton;
    BtStringListTest: TButton;
    BtStringStreamTest: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Memo1: TMemo;
    mnFileStream: TMemo;
    MnStringList: TMemo;
    MnStringStream: TMemo;
    MemoryStream: TTabSheet;
    mnMemory: TMemo;
    BtStreamReader: TButton;
    TabSheet6: TTabSheet;
    MnStreamReader: TMemo;
    MnStreamReaderWhile: TMemo;
    mnMemoryWhile: TMemo;
    MnTextFile: TRichEdit;
    MnFileStreamWhile: TMemo;
    MnStringStreamWhile: TMemo;
    BtnBench: TButton;
    MnTextFileWhile: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure BtTextFileTestClick(Sender: TObject);
    procedure BtFileStreamTestClick(Sender: TObject);
    procedure BtStringListTestClick(Sender: TObject);
    procedure BtStringStreamTestClick(Sender: TObject);
    procedure BtStreamReaderClick(Sender: TObject);
    procedure BtnBenchClick(Sender: TObject);
  private
    { Private declarations }
    procedure TestMemoryStream(aDisplay: Boolean; aFileName: TFileName);
    procedure TestTextFile(aDisplay: Boolean; aFileName: TFileName);
    procedure TestFileStream(aDisplay: Boolean; aFileName: TFileName);
    procedure TestStringList(aDisplay: Boolean; aFileName: TFileName);
    procedure TestStringStream(aDisplay: Boolean; aFileName: TFileName);
    procedure TestStreamReader(aDisplay: Boolean; aFileName: TFileName);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Self.TestMemoryStream(true, OpenDialog1.FileName);
  end;
end;

procedure TForm1.TestFileStream(aDisplay: Boolean; aFileName: TFileName);
var
  FS: TFileStream;
  S: AnsiString;
  NS: String;
  NS1: UTF8String;
  Offset: int64;
  Freq, Start, End_: int64;
  ch: AnsiChar;

begin
  TRY
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);
    FS := TFileStream.Create(aFileName, fmOpenRead);
    SetLength(S, FS.Size);
    FS.Read(S[1], FS.Size);
    NS := String(S);
    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' FileStream demorou p/ LER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';
    mnFileStream.Clear;

    if aDisplay then
      mnFileStream.Text := NS;

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);
    // percorrer linha a linha
    FS.Position := 0;
    while FS.Position < FS.Size do
    begin
      FS.Read(ch, 1);
      if ch = #13 then
      begin
        if aDisplay then
          MnFileStreamWhile.Lines.Add(trim(NS1));
        NS1 := '';
      end
      else
        NS1 := NS1 + string(ch);
    end;
    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' FileStream demorou p/ PERCORRER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';

  finally
    FS.Free;
  end;

end;

procedure TForm1.TestMemoryStream(aDisplay: Boolean; aFileName : TFileName);
var
  i: Integer;
  C: Byte;
  S: string;
  D: Word;
  TheMStream: TMemoryStream;
  Freq, Start, End_: int64;

  NS1: UTF8String;
  ch: AnsiChar;

begin
  // TMemoryStream existe especificamente para fornecer acesso a dados na memória como uma seqüência de bytes,
  // que podem ser dados binários ou dados de texto / personagem ou uma mistura de ambos
  try
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);
    TheMStream := TMemoryStream.Create;
    TheMStream.LoadFromFile(aFileName);
    SetString(S, PAnsiChar(TheMStream.Memory), TheMStream.Size);
    if aDisplay then
      mnMemory.Text := S;
    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' MemoryStream  p/ LER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';

    TheMStream.Position := 0;
    TheMStream.Seek(0, soFromBeginning); // Reposicionar o MemoryStream para o inicio

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);
    mnMemoryWhile.Text := '';
    while TheMStream.Position < TheMStream.Size do
    begin
      TheMStream.Read(ch, 1);
      if ch = #13 then
      begin
        if aDisplay then
          mnMemoryWhile.Lines.Add(trim(NS1));
        NS1 := '';
      end
      else
        NS1 := NS1 + string(ch);
    end;
    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' MemoryStream p/ PERCORRER ' + FloatToStr((End_ - Start) / Freq) +
      ' segundos.';

  finally
    TheMStream.Free;
  end;

end;

procedure TForm1.TestStreamReader(aDisplay: Boolean; aFileName: TFileName);
var
  TheStreamReader: TStreamReader;
  Freq, Start, End_: int64;
begin
  // TStreamReader é uma classe de propósito geral para ler dados de texto / caractere de qualquer fluxo.
  // Não suporta qualquer outra forma de dados em um fluxo e não se destina a ser usado com qualquer outra forma de dados.
  try
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);
    TheStreamReader := TStreamReader.Create(aFileName, TEncoding.UTF8);
    MnStreamReader.Text := TheStreamReader.ReadToEnd; // um jeito de ler todo o arquivo.
    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' StreamReader demorou p/ LER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';


    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);

    // reposicionar no inicio
    TheStreamReader.BaseStream.Position := 0;
    TheStreamReader.DiscardBufferedData;

    // percorrer linha a linha
    while not(TheStreamReader.EndOfStream) do
    begin
      if aDisplay then
        MnStreamReaderWhile.Lines.Add(TheStreamReader.ReadLine)
      else
        TheStreamReader.ReadLine;
    end;

    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' StreamReader demorou p/ PERCORRER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';

  finally
    TheStreamReader.Free;
  end;

end;

procedure TForm1.TestStringList(aDisplay: Boolean; aFileName: TFileName);
var
  Ss: TStringList;
  Freq, Start, End_: int64;
begin
  QueryPerformanceFrequency(Freq);
  QueryPerformanceCounter(Start);
  Ss := TStringList.Create;
  Ss.LoadFromFile(aFileName);
  if aDisplay then
    MnStringList.Text := Ss.Text;
  Ss.Free;
  QueryPerformanceCounter(End_);
  Memo1.Text := Memo1.Text + #13#10 + ' StringList p/ LER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';

end;

procedure TForm1.TestStringStream(aDisplay: Boolean; aFileName: TFileName);
var
  Ss: TStringStream;
  Freq, Start, End_: int64;
  i: Integer;
  NS1: String;
  ch: AnsiChar;
begin
  try
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);
    Ss := TStringStream.Create;
    Ss.LoadFromFile(aFileName);
    // MnStringStream.Text := ss.DataString;   //um jeito de ler o arquivo carregado em stream
    MnStringStream.Lines.LoadFromStream(Ss);
    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' StringStream demorou p/ LER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Start);
    Ss.Position := 0;
    MnStringStreamWhile.Clear;
    while Ss.Position < Ss.Size do
    begin
      Ss.Read(ch, 1);
      if ch = #13 then
      begin
        if aDisplay then
          MnStringStreamWhile.Lines.Add(trim(NS1));
        NS1 := '';
      end
      else
        NS1 := NS1 + string(ch);
    end;
    QueryPerformanceCounter(End_);
    Memo1.Text := Memo1.Text + #13#10 + ' StringStream demorou p/ PERCORRER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';

  finally
    Ss.Free;
  end;
end;

procedure TForm1.TestTextFile(aDisplay: Boolean; aFileName: TFileName);
var
  F: TextFile;
  S, Ln: String;
  Freq, Start, End_: int64;
begin
  QueryPerformanceFrequency(Freq);
  QueryPerformanceCounter(Start);
  S := '';
  AssignFile(F, aFileName);
  Reset(F);
  //TODO: CRIAR LEITURA COMPLETA


  //PERCORRER
  MnTextFileWhile.Clear;
  while not Eof(F) do
  begin
    Readln(F, Ln);
    S := S + #13#10 + Ln;
  end;
  if aDisplay then
    MnTextFileWhile.Text := S;
  CloseFile(F);
  QueryPerformanceCounter(End_);
  Memo1.Text := Memo1.Text + #13#10 + ' TextFile demorou p/ PERCORRER ' + FloatToStr((End_ - Start) / Freq) + ' segundos.';

end;

procedure TForm1.BtFileStreamTestClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Self.TestFileStream(true, OpenDialog1.FileName);
  end;
end;

procedure TForm1.BtnBenchClick(Sender: TObject);
var
  F: TextFile;
  S, Ln: String;
begin
  if OpenDialog1.Execute then
  begin
    Memo1.clear;
    Self.TestMemoryStream(False, OpenDialog1.FileName);
    Self.TestTextFile(False, OpenDialog1.FileName);
    Self.TestFileStream(False, OpenDialog1.FileName);
    Self.TestStringList(False, OpenDialog1.FileName);
    Self.TestStringStream(False, OpenDialog1.FileName);
    Self.TestStreamReader(False, OpenDialog1.FileName);
  end;
end;

procedure TForm1.BtStreamReaderClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Self.TestStreamReader(true, OpenDialog1.FileName);
  end;
end;

procedure TForm1.BtStringListTestClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Self.TestStringList(true, OpenDialog1.FileName);
  end;
end;

procedure TForm1.BtStringStreamTestClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Self.TestStringStream(true, OpenDialog1.FileName);
  end;
end;

procedure TForm1.BtTextFileTestClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Self.TestTextFile(true, OpenDialog1.FileName);
  end;
end;

end.
