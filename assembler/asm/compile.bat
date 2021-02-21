set file_name=test

masm exercise\%file_name%;

if errorlevel 1 pause

link %file_name%;

debug %file_name%.exe
del %file_name%.OBJ
del %file_name%.EXE

