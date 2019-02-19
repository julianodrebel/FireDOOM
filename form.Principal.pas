unit form.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    tmrCalculo: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrCalculoTimer(Sender: TObject);
  private
    const Linhas = 60;
    const Colunas = 60;
    const LarguraRect = 4;
    const AlturaRect = 4;
  private
    FArray: array of Integer;
    FPaletaCores: array of array of integer;

    procedure InicializarPaletaDeCores;

    procedure CriarEstruturaDoFogo;
    procedure CriarFonteDoFogo;

    procedure CalcularPropagacaoFogo;
    procedure AtualizarIntensidadeFogo(pIndex: Integer);

    procedure RenderizarFogo;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.AtualizarIntensidadeFogo(pIndex: Integer);
var
  lIndexAbaixo: Integer;
  lIntensidadeFogo: Integer;
  lNovaIntensidade: Integer;
  lDescontoIntensidadeFogo: Integer;
begin
  lDescontoIntensidadeFogo := Random(3);

  lIndexAbaixo := pIndex + Linhas;

  if lIndexAbaixo >= Colunas * Linhas then
    exit;

  lIntensidadeFogo := FArray[lIndexAbaixo];
  lNovaIntensidade := lIntensidadeFogo - lDescontoIntensidadeFogo;

  if lNovaIntensidade < 0 then
    lNovaIntensidade := 0;

  //Efeito sem vento
  //FArray[pIndex] := lNovaIntensidade;

  //Efeito com vento
  FArray[pIndex - lDescontoIntensidadeFogo] := lNovaIntensidade;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  InicializarPaletaDeCores;

  CriarEstruturaDoFogo;

  CriarFonteDoFogo;
end;

procedure TfrmPrincipal.InicializarPaletaDeCores;
var
  lIndex: Integer;
begin
  SetLength(FPaletaCores, 37);

  for lIndex := 0 to Length(FPaletaCores) -1 do
  begin
    SetLength(FPaletaCores[lIndex], 3);
  end;

  FPaletaCores[0][0] := 7;
  FPaletaCores[0][1] := 7;
  FPaletaCores[0][2] := 7;
  FPaletaCores[1][0] := 31;
  FPaletaCores[1][1] := 7;
  FPaletaCores[1][2] := 7;
  FPaletaCores[2][0] := 47;
  FPaletaCores[2][1] := 15;
  FPaletaCores[2][2] := 7;
  FPaletaCores[3][0] := 71;
  FPaletaCores[3][1] := 15;
  FPaletaCores[3][2] := 7;
  FPaletaCores[4][0] := 87;
  FPaletaCores[4][1] := 23;
  FPaletaCores[4][2] := 7;
  FPaletaCores[5][0] := 103;
  FPaletaCores[5][1] := 31;
  FPaletaCores[5][2] := 7;
  FPaletaCores[6][0] := 119;
  FPaletaCores[6][1] := 31;
  FPaletaCores[6][2] := 7;
  FPaletaCores[7][0] := 143;
  FPaletaCores[7][1] := 39;
  FPaletaCores[7][2] := 7;
  FPaletaCores[8][0] := 159;
  FPaletaCores[8][1] := 47;
  FPaletaCores[8][2] := 7;
  FPaletaCores[9][0] := 175;
  FPaletaCores[9][1] := 63;
  FPaletaCores[9][2] := 7;
  FPaletaCores[10][0] := 191;
  FPaletaCores[10][1] := 71;
  FPaletaCores[10][2] := 7;
  FPaletaCores[11][0] := 199;
  FPaletaCores[11][1] := 71;
  FPaletaCores[11][2] := 7;
  FPaletaCores[12][0] := 223;
  FPaletaCores[12][1] := 79;
  FPaletaCores[12][2] := 7;
  FPaletaCores[13][0] := 223;
  FPaletaCores[13][1] := 87;
  FPaletaCores[13][2] := 7;
  FPaletaCores[14][0] := 223;
  FPaletaCores[14][1] := 87;
  FPaletaCores[14][2] := 7;
  FPaletaCores[15][0] := 215;
  FPaletaCores[15][1] := 95;
  FPaletaCores[15][2] := 7;
  FPaletaCores[16][0] := 215;
  FPaletaCores[16][1] := 95;
  FPaletaCores[16][2] := 7;
  FPaletaCores[17][0] := 215;
  FPaletaCores[17][1] := 103;
  FPaletaCores[17][2] := 15;
  FPaletaCores[18][0] := 207;
  FPaletaCores[18][1] := 111;
  FPaletaCores[18][2] := 15;
  FPaletaCores[19][0] := 207;
  FPaletaCores[19][1] := 119;
  FPaletaCores[19][2] := 15;
  FPaletaCores[20][0] := 207;
  FPaletaCores[20][1] := 127;
  FPaletaCores[20][2] := 15;
  FPaletaCores[21][0] := 207;
  FPaletaCores[21][1] := 135;
  FPaletaCores[21][2] := 23;
  FPaletaCores[22][0] := 199;
  FPaletaCores[22][1] := 135;
  FPaletaCores[22][2] := 23;
  FPaletaCores[23][0] := 199;
  FPaletaCores[23][1] := 143;
  FPaletaCores[23][2] := 23;
  FPaletaCores[24][0] := 199;
  FPaletaCores[24][1] := 151;
  FPaletaCores[24][2] := 31;
  FPaletaCores[25][0] := 191;
  FPaletaCores[25][1] := 159;
  FPaletaCores[25][2] := 31;
  FPaletaCores[26][0] := 191;
  FPaletaCores[26][1] := 159;
  FPaletaCores[26][2] := 31;
  FPaletaCores[27][0] := 191;
  FPaletaCores[27][1] := 167;
  FPaletaCores[27][2] := 39;
  FPaletaCores[28][0] := 191;
  FPaletaCores[28][1] := 167;
  FPaletaCores[28][2] := 39;
  FPaletaCores[29][0] := 191;
  FPaletaCores[29][1] := 175;
  FPaletaCores[29][2] := 47;
  FPaletaCores[30][0] := 183;
  FPaletaCores[30][1] := 175;
  FPaletaCores[30][2] := 47;
  FPaletaCores[31][0] := 183;
  FPaletaCores[31][1] := 183;
  FPaletaCores[31][2] := 47;
  FPaletaCores[32][0] := 183;
  FPaletaCores[32][1] := 183;
  FPaletaCores[32][2] := 55;
  FPaletaCores[33][0] := 207;
  FPaletaCores[33][1] := 207;
  FPaletaCores[33][2] := 111;
  FPaletaCores[34][0] := 223;
  FPaletaCores[34][1] := 223;
  FPaletaCores[34][2] := 159;
  FPaletaCores[35][0] := 239;
  FPaletaCores[35][1] := 239;
  FPaletaCores[35][2] := 1;
  FPaletaCores[36][0] := 255;
  FPaletaCores[36][1] := 255;
  FPaletaCores[36][2] := 255;
end;

procedure TfrmPrincipal.CalcularPropagacaoFogo;
var
  lLinha: Integer;
  lColuna: Integer;
  lIndexArray: Integer;
begin
  for lColuna := 0 to Colunas -1 do
  begin
    for lLinha := 0 to Linhas -1 do
    begin
      lIndexArray := lColuna + (Linhas * lLinha);

      AtualizarIntensidadeFogo(lIndexArray);
    end;
  end;

  RenderizarFogo;
end;

procedure TfrmPrincipal.CriarEstruturaDoFogo;
var
  lNumeroPixel: Integer;
  lIndex: Integer;
begin
  lNumeroPixel := Linhas * Colunas;

  SetLength(FArray, lNumeroPixel);

  for lIndex := 0 to lNumeroPixel -1 do
  begin
    FArray[lIndex] := 0;
  end;
end;

procedure TfrmPrincipal.CriarFonteDoFogo;
var
  lColuna: Integer;
  lUltimoPixel: Integer;
begin
  lUltimoPixel := Linhas * Colunas;

  for lColuna := 0 to Colunas -1 do
  begin
    FArray[lUltimoPixel - Colunas + lColuna] := 36;
  end;
end;

procedure TfrmPrincipal.RenderizarFogo;
var
  lLinha: Integer;
  lColuna: Integer;
  lIndexArray: Integer;
  lDebug: Boolean;
  lRect: TRect;
  lIndexCor: Integer;
begin
  lDebug := False;
  for lLinha := 0 to Linhas -1 do
  begin
    for lColuna := 0 to Colunas -1 do
    begin
      lIndexArray := lColuna + (Linhas * lLinha);

      if lDebug then
      begin
        Canvas.TextOut(lColuna * AlturaRect, lLinha * LarguraRect, lIndexArray.ToString);

        Canvas.TextOut(lColuna * AlturaRect, lLinha * LarguraRect + 15, FArray[lIndexArray].ToString);
      end
      else
      begin
        lIndexCor := FArray[lIndexArray];

        lRect := TRect.Create(
          lColuna * AlturaRect,
          lLinha * LarguraRect,
          (lColuna * AlturaRect) + AlturaRect,
          (lLinha * LarguraRect) + LarguraRect);

        Canvas.Brush.Color :=
          RGB(FPaletaCores[lIndexCor][0], FPaletaCores[lIndexCor][1], FPaletaCores[lIndexCor][2]);

        Canvas.FillRect(lRect);
      end;
    end;
  end;
end;

procedure TfrmPrincipal.tmrCalculoTimer(Sender: TObject);
begin
  CalcularPropagacaoFogo;
end;

end.
