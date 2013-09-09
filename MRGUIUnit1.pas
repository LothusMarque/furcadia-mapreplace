unit MRGUIUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin;

type
  TMapReplaceGUIForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Floors: TTabSheet;
    Label1: TLabel;
    lb_ObjTo: TListBox;
    Label2: TLabel;
    lb_objfrom: TListBox;
    TS_Run: TTabSheet;
    OutputMemo: TMemo;
    btn_addObjFrom: TButton;
    edObjectFrom: TEdit;
    btn_OF_Up: TButton;
    btn_OF_Down: TButton;
    btn_OF_Del: TButton;
    btn_OT_Up: TButton;
    btn_OT_Down: TButton;
    btn_OT_Del: TButton;
    btn_ObjToAdd: TButton;
    edObjectTo: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    lb_floorto: TListBox;
    btn_FF_Up: TButton;
    btn_FF_Down: TButton;
    btn_FF_Del: TButton;
    lb_floorfrom: TListBox;
    edFloorFrom: TEdit;
    btn_addFlrFrom: TButton;
    edFloorTo: TEdit;
    btn_addFlrTo: TButton;
    btn_FT_Del: TButton;
    btn_FT_Down: TButton;
    btn_FT_Up: TButton;
    TabSheet3: TTabSheet;
    SpinCustomSeed: TSpinEdit;
    chkCustomSeed: TCheckBox;
    cbMode: TComboBox;
    Label5: TLabel;
    ed_InputFile: TEdit;
    btn_Input: TButton;
    ed_OutputFile: TEdit;
    btn_Output: TButton;
    Label6: TLabel;
    Label7: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    btnExecute: TButton;
    chkVerbose: TCheckBox;
    chkNoBackup: TCheckBox;
    procedure btnExecuteClick(Sender: TObject);
    procedure btn_addObjFromClick(Sender: TObject);
    procedure edObjectFromKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_ObjToAddClick(Sender: TObject);
    procedure lb_objfromClick(Sender: TObject);
    procedure lb_ObjToClick(Sender: TObject);
    procedure lb_floorfromClick(Sender: TObject);
    procedure lb_floortoClick(Sender: TObject);
    procedure btn_OF_DelClick(Sender: TObject);
    procedure btn_OT_DelClick(Sender: TObject);
    procedure btn_OF_UpClick(Sender: TObject);
    procedure btn_OF_DownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edObjectToKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_InputClick(Sender: TObject);
    procedure btn_OutputClick(Sender: TObject);
    procedure btn_FF_UpClick(Sender: TObject);
    procedure btn_FT_UpClick(Sender: TObject);
    procedure btn_FF_DownClick(Sender: TObject);
    procedure btn_FT_DownClick(Sender: TObject);
    procedure btn_FF_DelClick(Sender: TObject);
    procedure btn_FT_DelClick(Sender: TObject);
    procedure edFloorFromKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_addFlrFromClick(Sender: TObject);
    procedure btn_addFlrToClick(Sender: TObject);
    procedure edFloorToKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TS_RunShow(Sender: TObject);
    procedure chkCustomSeedClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RunDosInMemo(DosApp:string;AMemo:TMemo);
    procedure setBtnStatus(listbox: TListbox; upbtn, downbtn, delbtn: TButton);
    procedure DeleteItems(listbox: TListbox);
    procedure MoveItemsUp(listbox: TListbox);
    procedure MoveItemsDown(listbox: TListbox);
    procedure UpdateAllButtons;
  end;

  function RPos(SubStr: string; S: string): integer;

var
  MapReplaceGUIForm: TMapReplaceGUIForm;

implementation

{$R *.dfm}

//sLineBreak
function RPos(SubStr: string; S: string): integer;
//Right-searching Position function.
var
  I: integer;
begin
  i := length(s) - length(substr);
  while i > -1 do
   begin
   if copy(s,i,length(substr)) = substr then
    begin
      result := i;
      exit;
    end;
   i := i - 1;
   end;
result := i;
end;

procedure TMapReplaceGUIForm.btn_addFlrFromClick(Sender: TObject);
begin
if edFloorFrom.Text = '' then exit;
lb_floorfrom.Items.Add(edfloorFrom.Text);
if sender is TButton then
 begin
 EdfloorFrom.Text := '';
 EdfloorFrom.SetFocus;
 end
 else
 if sender is TEdit then
  with sender as TEdit do
   begin
     selectall;
   end;
setBtnStatus(lb_FloorFrom, btn_FF_up, btn_FF_down, btn_FF_del);
end;

procedure TMapReplaceGUIForm.btn_addFlrToClick(Sender: TObject);
begin
if edFloorto.Text = '' then exit;
lb_floorto.Items.Add(edfloorto.Text);
if sender is TButton then
 begin
 Edfloorto.Text := '';
 Edfloorto.SetFocus;
 end
 else
 if sender is TEdit then
  with sender as TEdit do
   begin
     selectall;
   end;
setBtnStatus(lb_FloorTo, btn_FT_up, btn_FT_down, btn_FT_del);
end;

procedure TMapReplaceGUIForm.btn_addObjFromClick(Sender: TObject);
begin
if edObjectFrom.Text = '' then exit;
lb_objfrom.Items.Add(edObjectFrom.Text);
if sender is TButton then
 begin
 EdObjectFrom.Text := '';
 EdObjectFrom.SetFocus;
 end
 else
 if sender is TEdit then
  with sender as TEdit do
   begin
     selectall;
   end;
setBtnStatus(lb_objfrom, btn_OF_up, btn_OF_down, btn_OF_del);
end;

procedure TMapReplaceGUIForm.btn_ObjToAddClick(Sender: TObject);
begin
if edObjectTo.Text = '' then exit;
lb_objto.Items.Add(edObjectTo.Text);
if sender is TButton then
 begin
 EdObjectTo.Text := '';
 EdObjectTo.SetFocus;
 end
 else
 if sender is TEdit then
  with sender as TEdit do
   begin
     selectall;
   end;
setBtnStatus(lb_objto, btn_OT_up, btn_OT_down, btn_OT_del);
end;

procedure TMapReplaceGUIForm.btn_FF_DelClick(Sender: TObject);
begin
DeleteItems(lb_floorfrom);
end;

procedure TMapReplaceGUIForm.btn_FF_DownClick(Sender: TObject);
begin
MoveItemsDown(lb_FloorFrom);
end;

procedure TMapReplaceGUIForm.btn_FF_UpClick(Sender: TObject);
begin
MoveItemsUp(lb_floorfrom);
end;

procedure TMapReplaceGUIForm.btn_FT_DelClick(Sender: TObject);
begin
DeleteItems(lb_floorto);
end;

procedure TMapReplaceGUIForm.btn_FT_DownClick(Sender: TObject);
begin
MoveItemsDown(lb_FloorTo);
end;

procedure TMapReplaceGUIForm.btn_FT_UpClick(Sender: TObject);
begin
MoveItemsUp(lb_floorto);
end;

procedure TMapReplaceGUIForm.btn_InputClick(Sender: TObject);
begin
with opendialog1 do
 if execute then
  begin
  ed_inputfile.Text := filename;
  end;
end;

procedure TMapReplaceGUIForm.btn_OF_DelClick(Sender: TObject);
begin
DeleteItems(lb_objfrom);
end;

procedure TMapReplaceGUIForm.btn_OF_DownClick(Sender: TObject);
begin
MoveItemsDown(lb_objfrom);
end;

procedure TMapReplaceGUIForm.btn_OF_UpClick(Sender: TObject);
begin
MoveItemsUp(lb_objfrom);
end;

procedure TMapReplaceGUIForm.btn_OT_DelClick(Sender: TObject);
begin
DeleteItems(lb_objto);
end;

procedure TMapReplaceGUIForm.btn_OutputClick(Sender: TObject);
begin
with savedialog1 do
 if execute then
  begin
  ed_outputfile.Text := filename;
  end;
end;

procedure TMapReplaceGUIForm.chkCustomSeedClick(Sender: TObject);
begin
spincustomseed.Enabled := chkCustomSeed.Checked;
end;

procedure TMapReplaceGUIForm.btnExecuteClick(Sender: TObject);
var
 commandline : string;
  I: Integer;

//Local procedure for main code clarity
procedure addListItems(listbox: TListbox);
var
i1: integer;
begin
commandline := commandline +' "';
if listbox.Items.Count > 0 then
 begin
 for I1 := 0 to listbox.Items.Count - 1 do
  begin
  commandline := commandline + listbox.Items[i1];
  if i1 < listbox.Items.Count - 1 then
   commandline := commandline + ',';
  end;
 commandline := commandline +'"';
 end;
end;

begin
commandline := ExtractFilePath(paramstr(0))+'MapReplace.exe';
if chkVerbose.Checked then
 commandline := commandline + ' -verbose';

if chkNoBackup.Checked then
 commandline := commandline + ' -nobackup';

if chkCustomSeed.Checked then
 begin
 commandline := commandline + ' -rndseed ' + inttostr(spinCustomSeed.Value);
 end;

case cbMode.itemindex of
 0: commandline := commandline + ' -mode seq';
 1: commandline := commandline + ' -mode rnd';
end;

//Objects-From
if lb_objfrom.Items.Count > 0 then
 begin
 commandline := commandline + ' -itemsfrom';
 addListItems(lb_objfrom);
 end;
//Objects-To
if lb_objto.Items.Count > 0 then
 begin
 commandline := commandline + ' -itemsto';
 addListItems(lb_objto);
 end;
//Floors-From
if lb_floorfrom.Items.Count > 0 then
 begin
 commandline := commandline + ' -floorsfrom';
 addListItems(lb_floorfrom);
 end;
//Floors-To
if lb_floorto.Items.Count > 0 then
 begin
 commandline := commandline + ' -floorsto';
 addListItems(lb_floorto);
 end;
//Filenames
if ed_inputfile.Text <> '' then
 commandline := commandline + ' -in "'+ed_inputfile.Text+'"';
if ed_outputfile.Text <> '' then
 commandline := commandline + ' -out "'+ed_outputfile.Text+'"';
//Clear and run!
PageControl1.ActivePage := TS_Run;
OutputMemo.Clear;
OutputMemo.Lines.Add('Executing: '+commandline);
OutputMemo.Lines.Add('');
OutputMemo.Repaint;
RunDosInMemo(commandline,OutputMemo);
end;

procedure TMapReplaceGUIForm.edFloorFromKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_Return then
 begin
   btn_addFlrFromClick(sender);
 end;
end;

procedure TMapReplaceGUIForm.edFloorToKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_Return then
 begin
   btn_addFlrToClick(sender);
 end;
end;

procedure TMapReplaceGUIForm.edObjectFromKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_Return then
 begin
   btn_addObjFromClick(sender);
 end;
end;

procedure TMapReplaceGUIForm.edObjectToKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_Return then
 begin
   btn_ObjToAddClick(sender);
 end;
end;

procedure TMapReplaceGUIForm.FormCreate(Sender: TObject);
begin
Randomize;
UpdateAllButtons;
PageControl1.ActivePageIndex := 0;
SpinCustomSeed.Value := Random(2000000000);
end;

procedure TMapReplaceGUIForm.lb_floorfromClick(Sender: TObject);
begin
setBtnStatus(TListBox(sender), btn_FF_up, btn_FF_down, btn_FF_del);
end;

procedure TMapReplaceGUIForm.lb_floortoClick(Sender: TObject);
begin
setBtnStatus(TListBox(sender), btn_FT_up, btn_FT_down, btn_FT_del);
end;

procedure TMapReplaceGUIForm.lb_objfromClick(Sender: TObject);
begin
setBtnStatus(TListBox(sender), btn_OF_up, btn_OF_down, btn_OF_del);
end;

procedure TMapReplaceGUIForm.lb_ObjToClick(Sender: TObject);
begin
setBtnStatus(TListBox(sender), btn_OT_up, btn_OT_down, btn_OT_del);
end;

procedure TMapReplaceGUIForm.DeleteItems(listbox: TListbox);
var
 i : integer;
begin
i := 0;
while i < listbox.Items.Count do
 begin
 if listbox.Selected[i] then
  listbox.Items.Delete(i)
 else
  i := i + 1;
 end;
listbox.OnClick(listbox);
end;

procedure TMapReplaceGUIForm.MoveItemsUp(listbox: TListbox);
var
 I : integer;
 ii : integer;
begin
with listbox do
 begin
 if selcount <= 0 then
  exit;
 I := 0;
 while (not Selected[I]) and (I < items.Count) do
  I := I + 1;
 if I = 0 then
  exit;
 for ii := 0 to items.count - 1 do
  if Selected[ii] then
   begin
   if ii <> 0 then
    begin
    items.Exchange(ii,ii-1); //First we switch their boarding passes
    selected[ii-1] := true;
    end;
   end;
 end;
listbox.OnClick(listbox);
end;

procedure TMapReplaceGUIForm.MoveItemsDown(listbox: TListbox);
var
 I: integer;
 ii : integer;
begin
with listbox do
 begin
 I := items.count-1;
 while (not Selected[I]) and (I >= 0) do
  I := I - 1;
 if I = items.count-1 then
  exit;
 for ii := -1 + Items.Count downto 0 do
  if Selected[ii] then
   begin
   if ii <> items.count-1 then
    begin
    items.Exchange(ii,ii+1);
    selected[ii+1] := true;
    end;
   end;
 end;
listbox.OnClick(listbox);
end;

procedure TMapReplaceGUIForm.setBtnStatus(listbox: TListbox; upbtn, downbtn, delbtn: TButton);
begin
//Handle enable/disable for a full control set in one nice place
with listbox do
 begin
 if listbox.SelCount = 0 then
  begin
  upbtn.Enabled := false;
  downbtn.Enabled := false;
  delbtn.Enabled := false;
  exit;
  end
 else
  begin
  delbtn.Enabled := true;
  end;
 //Check for selection locations
 if listbox.SelCount > 0 then
  begin
  upbtn.Enabled := not listbox.Selected[0];
  downbtn.Enabled := not listbox.Selected[listbox.Count-1];
  end;
 end;
end;

procedure TMapReplaceGUIForm.TS_RunShow(Sender: TObject);
begin
btnexecute.Left := btnexecute.Parent.ClientWidth div 2 - btnexecute.width div 2;
end;

procedure TMapReplaceGUIForm.UpdateAllButtons;
begin
//Prepare all standard buttons
setBtnStatus(lb_floorFrom, btn_FF_up, btn_FF_down, btn_FF_del);
setBtnStatus(lb_floorto, btn_FT_up, btn_FT_down, btn_FT_del);
setBtnStatus(lb_objfrom, btn_OF_up, btn_OF_down, btn_OF_del);
setBtnStatus(lb_objto, btn_OT_up, btn_OT_down, btn_OT_del);
end;

procedure TMapReplaceGUIForm.RunDosInMemo(DosApp:String;AMemo:TMemo);
//Borrowed from About.com, because it works, even if it isn't pretty.
//Original code was posted without any license for all users by Zarko Gajic.
//Modified significantly by Lothus Marque
  const
     ReadBuffer = 2400;
  var
   Security : TSecurityAttributes;
   ReadPipe,WritePipe : THandle;
   start : TStartUpInfo;
   ProcessInfo : TProcessInformation;
   Buffer : Pansichar;
   BytesRead : DWord;
   BytesAvail : DWord;
   Apprunning : DWord;
   tstr : string;
   lnposi : integer;
  begin
   With Security do begin
    nlength := SizeOf(TSecurityAttributes);
    binherithandle := true;
    lpsecuritydescriptor := nil;
   end;
   if Createpipe (ReadPipe, WritePipe,
                  @Security, 0) then begin
    Buffer := AllocMem(ReadBuffer + 1);
    FillChar(Start,Sizeof(Start),#0);
    start.cb := SizeOf(start);
    start.hStdOutput := WritePipe;
    start.hStdInput := ReadPipe;
    start.dwFlags := STARTF_USESTDHANDLES +
                         STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    UniqueString(DosApp);
    if CreateProcess(nil,
           PChar(DosApp),
           @Security,
           @Security,
           true,
           NORMAL_PRIORITY_CLASS,
           nil,
           nil,
           start,
           ProcessInfo)
    then
    begin
    try
    AMemo.Lines.BeginUpdate;
    tstr := '';
     repeat
      Apprunning := WaitForSingleObject(ProcessInfo.hProcess,100);
      Repeat
        BytesRead := 0;
        ReadFile(ReadPipe,Buffer[0],ReadBuffer,BytesRead,nil);
        Buffer[BytesRead]:= #0;
        //OemToAnsi(Buffer,Buffer);
        tstr := tstr + string(buffer);
        lnposi := rpos(sLineBreak, tstr); //The buffer will not always have complete lines at the end
        Amemo.Lines.Add(copy(tstr,1,lnposi-1));
        delete(tstr, 1, lnposi+1);
      until (BytesRead < ReadBuffer);
      Application.ProcessMessages;
     until (Apprunning <> WAIT_TIMEOUT);//STILL_ACTIVE); //WAIT_TIMEOUT

    BytesAvail := 0;
    //if PeekNamedPipe(ReadPipe, nil, 0, nil, @BytesAvail, nil) then
    // outputdebugstring(pchar('Pipe checked: '+inttostr(BytesAvail)));
    if BytesAvail > 0 then
    Repeat
        BytesRead := 0;
        ReadFile(ReadPipe,Buffer[0],ReadBuffer,BytesRead,nil);
        //outputdebugstring('Last read processed!');
        Buffer[BytesRead]:= #0;
        tstr := tstr + string(buffer);
        //OemToAnsi(Buffer,Buffer);
        Amemo.Lines.Add(tstr);
      until (BytesRead < ReadBuffer)
    else
    //If there's anything left over in the buffer, this takes care of it.
    //An extra blank line won't hurt.
     AMemo.lines.add(tstr);
    //outputdebugstring(pchar(tstr));

    finally
    AMemo.Lines.EndUpdate;
    end;
   end;
   FreeMem(Buffer);
   CloseHandle(ProcessInfo.hProcess);
   CloseHandle(ProcessInfo.hThread);
   CloseHandle(ReadPipe);
   CloseHandle(WritePipe);
   end;
  end;

end.
