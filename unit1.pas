unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    chooseitem: TButton;
    Button2: TButton;
		additem: TButton;
		clear: TButton;
		clearlist1: TButton;
		edititem: TButton;
		newitemedit: TEdit;
    savebutton: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure chooseitemClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
		procedure additemClick(Sender: TObject);
		procedure clearClick(Sender: TObject);
		procedure clearlist1Click(Sender: TObject);
		procedure edititemClick(Sender: TObject);
		procedure Label1Click(Sender: TObject);
		procedure ListBox1Click(Sender: TObject);
    procedure savebuttonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  savefilename,loadfilename, datafromfile : string;
  datalinecol : TStringList;
  filein, fileout : text;
  numberOfOptions, i : integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
begin
if OpenDialog1.Execute then
begin
  loadfilename := OpenDialog1.Filename;
  assignfile (filein, loadfilename);
   reset (filein);
   listbox1.Clear;
   listbox1.items.LoadFromFile(loadfilename);
   //while not eof(filein) do
   //begin
   //  readln (filein, datafromfile);
   //  ListBox1.items.add(datafromfile)
   //end;
   closefile(filein);
   label1.caption:=''
end;
end;

procedure TForm1.additemClick(Sender: TObject);
begin
	if length(newitemedit.Text)>0 then
  begin
	    listbox1.items.add(newitemedit.Text);
      newitemedit.Text:='';
	end;
end;

procedure TForm1.clearClick(Sender: TObject);
begin
  newitemedit.Text:='';
end;

procedure TForm1.clearlist1Click(Sender: TObject);
begin
  listbox1.Clear;
end;

procedure TForm1.edititemClick(Sender: TObject);
begin
  if listbox1.ItemIndex>-1 then
  begin
     newitemedit.Text:=listbox1.GetSelectedText;
     listbox1.items.delete(listbox1.ItemIndex);
	end;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
	//numberofoptions:=listbox1.items.IndexOf(label1.caption);
	//listbox1.as;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.savebuttonClick(Sender: TObject);
begin
	if SaveDialog1.Execute then
	begin
	  savefilename := SaveDialog1.Filename;
    if ((savefilename=loadfilename) or (not(fileexists(savefilename)))) then
	   begin
     assignfile(fileout, savefilename);
	   rewrite(fileout);
     for i := 0 to (listbox1.items.Count-1) do
     begin
       datafromfile:= listbox1.items.valuefromindex[i];
	     writeln(fileout, datafromfile);
		 end;
		 //listbox1.items.SaveToFile(savefilename);
     closefile(fileout);
     label1.caption:='File Saved Successfully!' ;
		 end
    else label1.Caption:='SORRY, file NOT saved due to overwrite protections.';
	end;
end;

procedure TForm1.chooseitemClick(Sender: TObject);
begin
  randomize;
  numberofoptions:=random(listbox1.Count);
  datafromfile:=listbox1.Items.ValueFromIndex[numberofoptions];
  Label1.Caption:=datafromfile;
end;

end.

