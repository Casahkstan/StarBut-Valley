program main;
{$mode objfpc}{$H+}
uses
	playerUnit;

var
	p : Player;
begin 
	initPlayer(p);
	setName(p, 'Sacha');
	writeln(getName(p));
end.