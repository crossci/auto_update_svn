@echo off
set workspace=C:\workspace\server
set svn_dir="C:\Program Files\TortoiseSVN\bin"
set vs_exe_dir="C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv"
set sln_path=%workspace%\游戏服务器.sln
set ftp_ip=42.236.90.242
set ftp_user=crossci
set ftp_password=test
REM 上传的压缩文件名字
set upload_file_name=Debug.rar
REM 上传的压缩文件
set upload_file=%workspace%\bin\%upload_file_name%
REM 压缩工具安装目录
set winrar_path="C:\Program Files\WinRAR"
REM 远程执行的脚本
set remote_bat_path="C:\Users\Administrator\Desktop\auto_start_server.bat"

echo update svn...
%svn_dir%\svn update %workspace% --accept "tc"

REM echo compile
start /b compile %sln_path% Channel
start /b compile %sln_path% ChannelLibrary
start /b compile %sln_path% EventServer
start /b compile %sln_path% MemoryStream
start /b compile %sln_path% TimerManage

start /b /wait compile %sln_path% BaccaratServer
start /b /wait compile %sln_path% DBServer
start /b /wait compile %sln_path% GatewayServer
start /b /wait compile %sln_path% LoginServer

%winrar_path%\winrar.exe a -r -ep1 %upload_file_name% %workspace%\bin\Debug\*.*
echo open %ftp_ip%>>upload.bat 
echo user %ftp_user% %ftp_password%>>upload.bat 
echo send %upload_file_name%>>upload.bat
echo quit>>upload.bat
ftp -n -s:"upload.bat" 

del upload.bat 
del %upload_file_name%

REM psexec \\%ftp_ip% -u "administrator" -p "rubzc@i7eotyqita" "C:\Users\Administrator\Desktop\auto_start_server.bat"
REM psexec \\192.168.1.9 -u "administrator" -p "079" ipconfig
REM psexec \\42.236.90.242 -u "administrator" -p "" "C:\Users\Administrator\Desktop\auto_start_server.bat"
REM "C:\Program Files\WinRAR"\winrar.exe x debug.rar temp/
