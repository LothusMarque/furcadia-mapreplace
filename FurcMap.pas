unit FurcMap;
{
Written by Lothus Marque/Eric Pettersen
===Released under the terms of the Mozilla Public License 2.0.===

Provides helper classes for working with Furcadia map files.

TFurcMapReader
Supports the full complement of floors, items, walls, regions, and effects.
Always saves with regions/effects.
Maintains unknown header values, does not support encrypted maps.
}
interface
uses
 Sysutils, classes, Windows;

type
  EFurcExcept = class(Exception);
  EFurcMapEncrypted = class(EFurcExcept);
  EFurcMapBadHeader = class(EFurcExcept);
  EFurcMapNotMap = class(EFurcExcept);
  
  TFurcWall = record
   NW : byte;
   NE : byte;
  end;

  TFurcMapSpace = record
   floor : word;
   obj : word;
   wall : TFurcWall;
   region: word;
   effect: word;
  end;

 TFurcMapReader = class(TObject)
  protected
   FHeader : TStringList;
   FFloorData : TMemoryStream;
   FObjectData : TMemoryStream;
   FWallData : TMemoryStream;
   FRegionData : TMemoryStream;
   FEffectData: TMemoryStream;
   FWidth : integer;  //X
   FHeight : integer; //Y
   procedure LoadHeader(source : TStream);
   function Getfloor(X, Y: Integer): word;
   procedure SetFloor(X, Y: Integer; value : word);
   function GetObject(X, Y: Integer): word;
   procedure SetObject(X, Y: Integer; value : word);
   function GetWall(X, Y: Integer): TFurcWall;
   procedure SetWall(X, Y: Integer; value : TFurcWall);
   function GetRegion(X, Y: Integer): word;
   procedure SetRegion(X, Y: Integer; value : word);
   function GetEffect(X, Y: Integer): word;
   procedure SetEffect(X, Y: Integer; value : word);
  public
   constructor Create;
   destructor Destroy; override;
   procedure LoadFromFile(filename : string);
   procedure SaveToFile(filename : string);
   procedure Redim(x, y : integer);
   procedure Newmap(x, y: integer);
   property Width : integer read FWidth;
   property Height : integer read FHeight;
   //property Header[entry : string]: string read FHeader.Values write FHeader.Values;
   property Floors[X, Y: integer]: word read GetFloor write SetFloor;
   property Objects[X, Y: integer]: word read GetObject write SetObject;
   property Walls[X, Y: integer]: TFurcWall read GetWall write SetWall;
   property Regions[X, Y: integer]: word read GetRegion write SetRegion;
   property Effects[X, Y: integer]: word read GetEffect write SetEffect;
  end;

implementation

const
 CON_FurcHeadEnd = 'BODY';
 CON_FurcVersion = 'MAP V';
 CON_NewMapVersion = 'MAP V01.40 Furcadia';
 CON_Encrypted = 'encoded';
 CON_Width = 'width';
 CON_Height = 'height';
 CON_Revision = 'revision';
 CON_Patchtype = 'patcht';
 CON_PatchSource = 'patchs';
 CON_Encoded = 'encoded';
 CON_NoLoad = 'noload'; //This should be set only if the map is actually encrypted
 CON_CreateRev = '570';
 CON_CreateType = '0';
 CON_MapEnc = 'Map appears to be encrypted!';
 CON_HeaderExplode = 5000;
//FBJ Constants
 FurcFBJWalk = 1;
 FurcFBJGet = 2;
 FurcFBJSit = 4;
 FurcFBJX = 8;
 FurcFBJY = 16;

constructor TFurcMapReader.Create;
begin
FWidth := 0;
FHeight := 0;
FHeader := TStringlist.Create;
FFloorData := TMemoryStream.Create;
FObjectData := TMemoryStream.Create;
FWallData := TMemoryStream.Create;
FRegionData := TMemoryStream.Create;
FEffectData := TMemoryStream.Create;
end;

destructor TFurcMapReader.Destroy;
begin
FHeader.Free;
FFloorData.Free;
FObjectData.Free;
FWallData.Free;
FRegionData.Free;
FEffectData.Free;
inherited Destroy;
end;

procedure TFurcMapReader.LoadHeader(source : TStream);
var
 buf1 : byte;
 buf2 : ansistring;
 stopit : boolean;
 c1 : integer;
 err, line : integer;
begin
//Load the MAP header
stopit := false;
c1 := 0;
line := 0;
err := 0;
while (stopit <> true) or (c1 < 3000) do //Safety valve, just in case something goes wrong
 begin
 source.Read(buf1,sizeof(buf1));
 case buf1 of
   10 : begin
        if (line = 0) and (copy(buf2,1,5) <> CON_FurcVersion) then
         begin
         err := 2;
         break;
         end;
        if buf2 <> CON_FurcHeadEnd then
         begin
         Fheader.Add(buf2);
         inc(line);
         buf2 := '';
         end
        else
         begin
         break; //We're done with the header
         end;
        end;
  else
   buf2 := buf2 + ansichar(buf1);
  end;
 inc(c1);
 end;
if c1 > CON_HeaderExplode then err := 1;
if err <> 0 then
 case err of
  1 : raise Exception.Create('Too much data read, bad header?');
  2 : raise Exception.Create('Not a recognised Furcadia MAP file');
 end;
end;

function TFurcMapReader.Getfloor(X, Y: Integer): word;
var
 calc : integer;
 data : word;
begin //Get a floor value
if (x >= FWidth) or (y >= FHeight) then
 begin
 result := 0;
 exit;
 end;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FFloorData.Position := calc; //Move there
FFloordata.Read(data,sizeof(data)); //Read it up
result := data;
end;

procedure TFurcMapReader.SetFloor(X, Y: Integer; value : word);
var
 calc : integer;
begin //Set a floor value
if (x >= FWidth) or (y >= FHeight) then
 exit;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FFloorData.Position := calc; //Move there
FFloordata.Write(value,sizeof(value)); //Place the new data
end;

function TFurcMapReader.GetObject(X, Y: Integer): word;
var
 calc : integer;
 data : word;
begin //Get an Object value
if (x >= FWidth) or (y >= FHeight) then
 begin
 result := 0;
 exit;
 end;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FObjectData.Position := calc; //Move there
FObjectdata.Read(data,sizeof(data)); //Read it up
result := data;
end;

procedure TFurcMapReader.SetObject(X, Y: Integer; value : word);
var
 calc : integer;
begin //Set an Object value
if (x >= FWidth) or (y >= FHeight) then
 exit;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FObjectData.Position := calc; //Move there
FObjectdata.Write(value,sizeof(value)); //Place the new data
end;

function TFurcMapReader.GetWall(X, Y: Integer): TFurcWall;
var
 calc : integer;
 data : byte;
begin //Get a Wall value
if (x >= FWidth) or (y >= FHeight) then
 begin
 result.NE := 0;
 result.NW := 0;
 exit;
 end;
if odd(X) then
 X := X - 1;
 calc := (FHeight * X + Y); //Figure out where we've gotta move to get it
//else                       //((X div 2)*2) //(What the hell was I thinking?)
// calc :=
FWallData.Position := calc; //Move there
FWalldata.Read(data,sizeof(data)); //Read it up
result.NW := data;
calc := calc + FHeight; //Get the next piece
FWallData.Position := calc; //Move there
FWalldata.Read(data,sizeof(data)); //Read it up
result.NE := data;
end;

procedure TFurcMapReader.SetWall(X, Y: Integer; value : TFurcWall);
var
 calc : integer;
 buffer : byte;
begin //Set a Wall value
if (x >= FWidth) or (y >= FHeight) then
 exit;
if odd(X) then
 X := X - 1;
calc := (FHeight * X + Y); //Figure out where we've gotta move to get it
FWallData.Position := calc; //Move there
buffer := value.NW;
FWalldata.Write(buffer,sizeof(buffer)); //Place the new data
calc := calc + FHeight;
buffer := value.NE;
FWallData.Position := calc; //Move there
FWalldata.Write(buffer,sizeof(buffer)); //Place the new data }
end;

function TFurcMapReader.GetRegion(X, Y: Integer): word;
var
 calc : integer;
 data : word;
begin //Get a Region value
if (x >= FWidth) or (y >= FHeight) then
 begin
 result := 0;
 exit;
 end;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FRegionData.Position := calc; //Move there
FRegiondata.Read(data,sizeof(data)); //Read it up
result := data;
end;

procedure TFurcMapReader.SetRegion(X, Y: Integer; value : word);
var
 calc : integer;
begin //Set an Object value
if (x >= FWidth) or (y >= FHeight) then
 exit;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FRegionData.Position := calc; //Move there
FRegiondata.Write(value,sizeof(value)); //Place the new data
end;

function TFurcMapReader.GetEffect(X, Y: Integer): word;
var
 calc : integer;
 data : word;
begin //Get a Region value
if (x >= FWidth) or (y >= FHeight) then
 begin
 result := 0;
 exit;
 end;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FEffectData.Position := calc; //Move there
FEffectdata.Read(data,sizeof(data)); //Read it up
result := data;
end;

procedure TFurcMapReader.SetEffect(X, Y: Integer; value : word);
var
 calc : integer;
begin //Set an Object value
if (x >= FWidth) or (y >= FHeight) then
 exit;
calc := ((FHeight * (X div 2) + Y) * 2); //Figure out where we've gotta move to get it
FEffectData.Position := calc; //Move there
FEffectdata.Write(value,sizeof(value)); //Place the new data
end;

procedure TFurcMapReader.LoadFromFile(filename : string);
var
 reader : TFileStream;
 xsiz,ysiz, posi : integer;
 stuff: byte;
 tmp : string;
begin
 //Empty current map
 fheader.clear;
 FFloorData.Clear;
 FObjectData.Clear;
 FWallData.Clear;
 FRegionData.Clear;
 FEffectData.Clear;
 FWidth := 0;
 FHeight := 0;
 //Start loading
 reader := TFileStream.Create(filename,fmOpenRead);
 try
 LoadHeader(reader);
 xsiz := strtoint(fheader.Values[CON_Width]);
 ysiz := strtoint(fheader.Values[CON_Height]);
 OutputDebugString(pchar(inttostr(xsiz)+','+inttostr(ysiz)));
FWidth := xSiz * 2;
FHeight := ySiz;
//tmp := fheader.Values[CON_Encrypted];
tmp := fheader.Values[CON_NoLoad];
 if (tmp <> '0') and (tmp <> '') then //Explode
  begin
  raise EFurcMapEncrypted.Create(CON_MapEnc);
  exit;
  end;
 FFloorData.CopyFrom(reader, ((xsiz * ysiz) * 2));
 FObjectData.CopyFrom(reader,((xsiz * ysiz) * 2));
 FWallData.CopyFrom(reader, ((xsiz * ysiz) * 2));
outputdebugstring(pchar(inttostr(reader.Size)+','+inttostr(reader.Position)));
 if (reader.Position <> reader.Size) then
  begin
  outputdebugstring('Map has extra data! Assuming it has Regions+Effects!');
  FRegionData.CopyFrom(reader,((xsiz * ysiz) * 2));
  FEffectData.CopyFrom(reader,((xsiz * ysiz) * 2));
  end
 else
  begin //No data, initialize to zero.
  stuff := 0;
  FRegionData.SetSize((xsiz * ysiz)*2);
  FEffectData.SetSize((xsiz * ysiz)*2);
  for posi := 0 to FRegiondata.Size do
   FRegionData.Write(stuff,1);
  for posi := 0 to FEffectdata.Size do
   FEffectData.Write(stuff,1);
  end;
 finally
 reader.free;
 end;
end;

procedure TFurcMapReader.SaveToFile(filename : string);
var
 writer : TFileStream;
 cnt : integer;
 buffer1 : ansistring;
begin
writer := TFileStream.Create(filename, fmCreate);
 try
 for cnt := 0 to fHeader.count-1 do
  begin
  buffer1 := fHeader[cnt]+#10;
  writer.Write(PAnsiChar(Buffer1)^,length(buffer1));
  end;
 buffer1 := CON_FurcHeadEnd+#10;
 writer.Write(PansiChar(Buffer1)^,length(buffer1));
 writer.CopyFrom(FFloorData,0);
 writer.CopyFrom(FObjectData,0);
 writer.CopyFrom(FWallData,0);
 writer.CopyFrom(FRegionData,0);
 writer.CopyFrom(FEffectData,0);
 finally
 writer.free;
 end;
//showmessage('Done!');
end;

procedure TFurcMapReader.Redim(x, y : integer);
begin
//Resize the map, keeping available data intact
//Probably will have to do it with an actual line-by-line copy/insertion of each plane.
raise Exception.Create('Function not implemented!');
end;

procedure TFurcMapReader.Newmap(x, y: integer);
var
 posi : integer;
 stuff : byte;
begin//Wipe the map and create a new, empty map at a given size
//Empty current map
fheader.clear;
FFloorData.Clear;
FObjectData.Clear;
FWallData.Clear;
FRegionData.Clear;
FEffectData.Clear;
X := x div 2;
FWidth := Y;
FHeight := X * 2;
FHeader.Add(CON_NewMapVersion);
FHeader.Values[CON_Height] := inttostr(Y);
FHeader.Values[CON_Width] := inttostr(X);
FHeader.Values[CON_Revision] := CON_CreateRev;
FHeader.Values[CON_PatchType] := CON_CreateType;
FHeader.Values[CON_PatchSource] := '';
FFloorData.SetSize((X*Y)*2);
FObjectData.SetSize((X*Y)*2);
FWallData.SetSize((X*Y)*2);
FRegionData.SetSize((X*Y)*2);
FEffectData.SetSize((X*Y)*2);
//Blank it all!
//FillChar might be better later.
stuff := 0;
for posi := 0 to FFloordata.Size do
 FFloorData.Write(stuff,1);
for posi := 0 to FObjectdata.Size do
 FObjectData.Write(stuff,1);
for posi := 0 to FWalldata.Size do
 FWallData.Write(stuff,1);
for posi := 0 to FRegiondata.Size do
 FRegionData.Write(stuff,1);
for posi := 0 to FEffectdata.Size do
 FEffectData.Write(stuff,1);

end;



end.
