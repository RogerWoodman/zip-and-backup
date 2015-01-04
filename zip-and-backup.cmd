@ECHO OFF
REM : **************************************************************************
REM : Description: This is part of the right click context menu zip-and-backup program.
REM :              First run "add-backup-context-option.reg"
REM :              7-Zip is used to zip the files.  7-Zip is highly recommeneded.
REM : Author:      Roger Woodman
REM : **************************************************************************
@ECHO OFF

REM : 7-Zip path
SET sevenZipPath=C:\Program Files (x86)\7-Zip\7z.exe

REM : Get the current date and split into year, month, days
FOR /F "TOKENS=1,2 DELIMS=/ " %%A IN ('DATE /T') DO SET dd=%%A
FOR /F "TOKENS=2,3 DELIMS=/ " %%A IN ('DATE /T') DO SET mm=%%A
FOR /F "TOKENS=3* DELIMS=/ " %%A IN ('DATE /T') DO SET yy=%%A

REM : GEt the current time and split into hours and minutes
FOR /F "TOKENS=1,2 DELIMS=: " %%A IN ('TIME /T') DO SET hour=%%A
FOR /F "TOKENS=2,3 DELIMS=: " %%A IN ('TIME /T') DO SET min=%%A

REM : set date=%dd%-%mm%-%yy%
SET date=%yy%-%mm%-%dd%
SET time=%hour%-%min%

REM : Full backup destination path
SET backupPath=%1
SET filename=%~2
SET backupFileName=%date%-%time% - %filename%.zip
SET outputPath=%~3

REM : Print the destination and source path
ECHO "--------------------------------"
ECHO  "%outputPath%\%backupFileName%" %backupPath%
ECHO "--------------------------------"

REM : Call 7-Zip and pass the source and destination paths
CALL "%sevenZipPath%" a -tzip "%outputPath%\%backupFileName%" %backupPath% -r

REM : check the integrity of the zip file and ouput the results to a file
CALL "%sevenZipPath%" t "%outputPath%\%backupFileName%" *.* -r > "%outputPath%\%date% - BackupResults.txt"

REM : If the zip file is not created, then go to the error routine
@IF NOT EXIST "%outputPath%\%backupFileName%" GOTO :ERROR

REM : If everything went well then go to the success routine
GOTO :SUCCESS

:ERROR
   @ECHO.
   @ECHO ############################################
   @ECHO !!                                        !!
   @ECHO !!   AN ERROR OCCURED PREVENTING BACKUP   !!
   @ECHO !!                                        !!
   @ECHO ############################################
   @ECHO.   
   @ECHO.
   @ECHO.
   PAUSE
   GOTO :END
:SUCCESS
   @ECHO.   
   @ECHO ********************************************
   @ECHO :)         Backup Successful              :)
   @ECHO ********************************************
   @ECHO.
   @ECHO.
   @ECHO.   
   PAUSE
:END

REM : Aleep for a short time afer user presses enter.  This can be removed
"C:\WINDOWS\system32\cscript.exe" %~dp0\sleep.vbs
