@echo off
set winrar_path="C:\Program Files\WinRAR"
set server_bin_path=D:\baccarat_bin
set rar_path=D:\temp
REM 关闭服务器
tskill gatewayserver
tskill dbserver
tskill loginserver
tskill BaccaratServer
REM 解压
if exist %winrar_path%(
%winrar_path%\winrar.exe e %rar_path%\Debug.rar %server_bin_path%\
)else(
	echo not find winrar, make sure you have installed winrar.
	pause
	exit
)
REM 启动服务器
if exist %server_bin_path%(
	%server_bin_path%\startserver.bat
)else(
	echo not find startserver.bat.
	pause
	exit
)
echo start server successfully.
exit