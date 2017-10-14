@echo off
set vs_exe_dir="C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv"
%vs_exe_dir% %1 /build "Debug|Win32" /project %2
exit