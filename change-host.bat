@ECHO OFF

SET host=%1

IF NOT EXIST ".\python\" (
    ECHO Please setup python venv first
    EXIT
)

%~dp0\python\Scripts\python.exe %~dp0\change-host.py %host%
