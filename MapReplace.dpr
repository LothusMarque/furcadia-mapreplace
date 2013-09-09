program MapReplace;

{$APPTYPE CONSOLE}
{
Written by Lothus Marque/Eric Pettersen

Released under the terms of the Mozilla Public License 2.0.
}

uses
  Windows,
  SysUtils,
  Classes,
  FurcMap in 'FurcMap.pas';

type
 TReplaceMode = (RM_Sequential, RM_Random);

var
 map: TFurcMapReader;
 floorin,floorout : TList;
 itemin, itemout : TList;
 fin,fout:string;
 ic,cd: integer;
 replacemode : TReplaceMode;
 verbose: boolean;
 pu: boolean;
 nobackup : boolean;

const
 DefRandomSeed = 82769556; //Just to keep it repeatable

procedure doBackup(outfile : string);
//If the current output file exists, make a backup of it.
//Overwrites old backups.
var
 bufile: string;
begin
if not nobackup and FileExists(outfile) then
 begin
 bufile := ChangeFileExt(outfile,'.bak.map');
 CopyFile(pchar(outfile),pchar(bufile),false);
 Writeln('Backup Made: '+bufile);
 end;
end;

procedure printUsage;
begin
if not pu then
 begin
 writeln('Usage: '+sLineBreak+extractfilename(paramstr(0))+' [-floorsfrom (floors)] [-floorsto (floors)] [-itemsfrom (items)] [-itemsto (items)] [-rndseed (seed)] [-mode (seq|rnd)] [-verbose] [-nobackup] -in (file) -out (file)');
 writeln(slinebreak+'-Parameter tags can be in any order.'+sLineBreak+'Items/Floors syntax: "2,3-5,8,10" indicates a group list of 2,3,4,5,8,10.');
 pu := true;
 end;
end;

function parseList(values: string; list : TList): boolean;
//Written out here mostly for fun, to be honest. There are other ways.
var
 plength1,rcheck,t2,t3,code,code2 : integer;
 tstr,ls,rs : string;
  I: Integer;
begin
//We could have any number of values to add to the list
while length(values) > 0 do
 begin
 plength1 := pos(',',values);
 if plength1 = 0 then
  plength1 := length(values)+1;
 if plength1 > 0 then
  begin
  tstr := copy(values,1,plength1-1);
  //Check tstr for range values, otherwise add it to list.
  rcheck := pos('-',tstr);
  if rcheck > 0 then
   begin //Add a range of values
   ls := copy(tstr,1,rcheck-1);
   rs := copy(tstr,rcheck+1,length(tstr));
   val(ls,t2,code);
   val(rs,t3,code2);
   if (code <> 0) or (code2 <> 0) then
    begin
    result := false;
    exit;
    end;
   for I := t2 to t3 do list.Add(pointer(i));  //Add the range items individually
   end
  else
   begin //Add single value
   val(tstr,t2,code);
   if code <> 0 then
    begin
    result := false;
    exit;
    end;
   list.Add(pointer(t2));
   end;
  //Clear value segment
  delete(values,1,plength1);
  end;
 end;
result := true;
end;

function parseParameters: boolean;
//This function sets everything up, and allows parameters to be in any order
//as long as values come right after their particular identifier.
var
  i : integer;
  failed : boolean;
  cmd : string;
  found: boolean;
begin
failed := false;
found := false;
i := 1;
while i <= paramcount do
 begin
 found := false;
 //Floors In
 cmd := lowercase(paramstr(i));
 if cmd = '-floorsfrom' then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   failed := not parseList(paramstr(i),floorin);
   end
  else
     failed:= true;
  end;
 //Floors Out
 if (not failed) and (cmd = '-floorsto') then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   failed := not parseList(paramstr(i),floorout);
   end
  else
     failed:= true;
  end;
 //Objects In
 if (not failed) and (cmd = '-itemsfrom') then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   failed := not parseList(paramstr(i),itemin);
   end
  else
     failed := true;
  end;
 //Objects Out
 if (not failed) and (cmd = '-itemsto') then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   failed := not parseList(paramstr(i),itemout);
   end
   else failed := true;
  end;
 //Input File
 if (not failed) and (cmd = '-in') then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   fin := paramstr(i);
   end
   else failed := true;
  end;
 //Output File
 if (not failed) and (cmd = '-out') then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   fout := paramstr(i);
   end
   else failed := true;
  end;
 //Random seed
 if (not failed) and (cmd = '-rndseed') then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   val(paramstr(i), RandSeed, cd);
   end
   else failed := true;
  end;
 //Mode
 if (not failed) and (cmd = '-mode') then
  begin
  found := true;
  i := i + 1;
  if paramstr(i) <> '' then
   begin
   if (lowercase(paramstr(i)) = 'seq') then
     begin
     ReplaceMode := RM_Sequential;
     end
   else if (lowercase(paramstr(i)) = 'rnd') then
    begin
     ReplaceMode := RM_Random;
    end;
   end
   else failed := true;
  end;
//Verbose
 if (not failed) and (cmd = '-verbose') then
  begin
   found := true;
   verbose := true;
   writeln('Maximum Verbosity.');
  end;
 //No backup
 if (not failed) and (cmd = '-nobackup') then
  begin
   found := true;
   verbose := true;
   writeln('Backup disabled.');
  end;
 //End of parameter scan blocks
 i := i + 1;
 if (failed) or (not found) then
  break;
 end; //End of while
if (failed) or (not found) then
 begin
 PrintUsage;
 end;
result := not failed;
end;

function checkReplace(testvalue: integer; listing : TList) : boolean;
var
 I : integer;
begin
for I := 0 to listing.Count - 1 do
 if integer(listing[i]) = testvalue then
  begin
  result := true;
  exit;
  end;
result := false;
end;

function ProcessMap(mapper: TFurcMapReader):boolean;
var
 xpos,ypos : integer;
 fseqrep, iseqrep, temp1, rt1 : integer;
begin
fseqrep := 0; //Floors sequence
iseqrep := 0; //Item sequence
 for Xpos := 0 to (mapper.Width{ div 2}) do
 if (odd(xpos)) then
  for Ypos := 0 to Mapper.Height-1 do
   begin
   //Floor replace pass
   temp1 := mapper.Floors[Xpos,YPos];
   if checkreplace(temp1, floorin) then
    begin
     case replacemode of
      RM_Sequential: begin
                     mapper.Floors[xpos,ypos] := integer(floorout[fseqrep]);
                     fseqrep := fseqrep + 1;
                     if fseqrep >= floorout.Count then
                      fseqrep := 0;
                     end;
      RM_Random: begin
                 rt1 := Random(floorout.Count);
                 mapper.Floors[xpos,ypos] := integer(floorout[rt1]);
                 end;
     end;
     if (verbose) then
       Writeln('Floor '+inttostr(temp1)+' @ ['+inttostr(xpos*2)+','+inttostr(ypos)+'] changed to '+inttostr(mapper.Floors[xpos,ypos]));
    end;
   //Item replace pass
   temp1 := mapper.Objects[Xpos,YPos];
   if checkreplace(temp1, itemin) then
    begin
     case replacemode of
      RM_Sequential: begin
                     mapper.Objects[xpos,ypos] := integer(itemout[iseqrep]);
                     iseqrep := iseqrep + 1;
                     if iseqrep >= itemout.Count then
                      iseqrep := 0;
                     end;
      RM_Random: begin
                 rt1 := Random(itemout.Count);
                 mapper.Objects[xpos,ypos] := integer(itemout[rt1]);
                 end;
     end;
    if (verbose) then
       Writeln('Item '+inttostr(temp1)+' @ ['+inttostr(xpos-1)+','+inttostr(ypos)+'] changed to '+inttostr(mapper.Objects[xpos,ypos]));
    end;
   end;
result := true;
end;

begin
pu := false;
writeln('Furcadia Map Range Replacement Utility');
writeln('Copyright 2013 Lothus Marque');
writeln;
//Create storage and manipulation systems
Randomize;
//RandSeed = DefRandomSeed;
floorin := TList.Create;
floorout := TList.Create;
itemin := TList.Create;
itemout := Tlist.Create;
map := TFurcMapReader.Create;
//Into the breach, men!
  try
  //Parse parameters
  if parseParameters then
   begin
   if fin <> '' then //We need an input file!
    begin
    if fout = '' then
     begin
     fout := changefileext(fin,'-out'+extractfileext(fin));
     writeln('Warning: Output not specified, defaulting to '+extractfilename(fout));
     end;
   //Debug output, make sure our parameter parsing is good.
   if verbose then
    begin
    writeln(sLineBreak+'--Parameters--');
    write('FloorIn: ');
    for ic := 0 to floorin.Count - 1 do
     write(inttostr(integer(floorin[Ic]))+' ');
    writeln;
    write('FloorOut: ');
    for ic := 0 to floorout.Count - 1 do
     write(inttostr(integer(floorout[Ic]))+' ');
    writeln;
    write('ItemIn: ');
    for ic := 0 to itemin.Count - 1 do
     write(inttostr(integer(itemin[Ic]))+' ');
    writeln;
    write('ItemOut: ');
    for ic := 0 to itemout.Count - 1 do
     write(inttostr(integer(itemout[Ic]))+' ');
    writeln;
    writeln('In: '+fin);
    writeln('Out: '+fout);
    case replacemode of
      RM_Sequential: Writeln('Mode: Sequential');
      RM_Random: Writeln('Mode: Random');
    end;
    Writeln('Random Seed: '+inttostr(randseed));
    writeln('--------------');
    end;
    //Do processing here
    Writeln('Loading map...');
    map.LoadFromFile(fin); //Load our map
    doBackup(fout);
    Writeln('Processing...');
    ProcessMap(map);
    map.SaveToFile(fout); //Aaand save time!
    end
    else PrintUsage;
   end;
  if not pu then writeln('Done!');
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
//Clean up
  floorin.Free;
  floorout.Free;
  itemin.Free;
  itemout.Free;
  map.Free;
//Wait
//  Readln;
end.
