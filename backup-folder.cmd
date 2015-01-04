@ECHO OFF
REM : **************************************************************************
REM : Description: This is part of the right click context menu zip-and-backup program.
REM :              First run "add-backup-context-option.reg"
REM :              This will allow any fodler in Windows to be zipped and copied to a backup folder.
REM : Author:      Roger Woodman
REM : **************************************************************************
@ECHO OFF

REM : Destination path where the folder will be backed up to.  This should be on a differnt physical disk
SET backupDirectory="D:\#folder-backups"

REM : Path to the zip and backup batch file
SET zipAndBackupPath="C:\zip-and-backup\"

REM : Source path of the folder to be backed up.  All subfolders are backed up automatically
SET pathToBackup=%~1
REM : The top level folder to be backed up will be used to name the zip file
SET backupFileName=%~nx1

REM : Call the zip-and-backup batch file and pass the source path, the name of the zip file and the destination path
CALL "%zipAndBackupPath%\zip-and-backup.cmd" "%pathToBackup%\*.*" "%backupFileName%" %backupDirectory%
