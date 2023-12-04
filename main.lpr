program main;
{$codepage utf8}
{$mode objfpc}{$H+}
uses
	playerUnit;

var
	p : Player;
begin 
	initPlayer();
	setName('Sacha');
	writeln(getName);
end.