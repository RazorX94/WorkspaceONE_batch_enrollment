@echo Off
REM Define Windows 10 version to be show in text setup
set var_winversion=Pro
REM Define Product key Windows 10 related to your version
set var_Pkeys=<Product Keys>
REM Define intallation folder path to download AirWatchAgent
set var_path=C:\WorkspaceONE
REM Define your UEM server URL
set var_server=<devices services URL>
REM Define GroupID
set var_LGName=<GroupID>
REM Define User staging Account or UPN
set var_username=<Staging Account>
REM Define Password Account or Secret
set var_password=<Password>
echo "Activation de la licence volume Windows 10 %var_winversion%"
slmgr.vbs /ipk %var_Pkeys%
echo "Creation du dossier d'installation"
mkdir %var_path%
cd %var_path%
echo "Telechargement de l'agent"
curl -O https://storage.googleapis.com/getwsone-com-prod/downloads/AirwatchAgent.msi
echo "Enrollement du terminal dans Workspace ONE vers %var_server% cette etape peut prendre plusieurs minutes"
echo "GroupID d'enrolement %var_LGName%"
msiexec /i AirWatchAgent.msi /qr ENROLL=Y SERVER=%var_server% LGName=%var_LGName% USERNAME=%var_username% PASSWORD=%var_password% ASSIGNTOLOGGEDINUSER=Y DOWNLOADWSBUNDLE=TRUE /L*V %var_path%\WSOneEnroll.log
echo "Attendez la fin du script, l'agent doit se lancer."
pause