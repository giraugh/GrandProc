::--- Create compiled zip ---::
xcopy /s /y /q game cdep\compiled\
cd cdep
del /s /q /f compiled.love
del /s /q /f compiled.zip
copy "zip.exe" "compiled/zip.exe"
cd compiled
zip -r ../compiled.zip * .*
cd ../
zip -d compiled.zip zip.exe
rd /S /Q compiled
::---                                ---::

::--- Make it a .love file (and put it in the love directory) ---::
ren compiled.zip compiled.love
copy "compiled.love" "../love/compiled.love"
del /s /q /f "compiled.love"
cd ../love
copy /b love.exe+compiled.love compiled.exe
cd ../
::---                                ---::