@echo off
color 02
:main
cls
echo Linux to Windows Command Converter
echo.
echo Supported Commands: ls, pwd, cat, rm, mkdir, rmdir, cp, mv, touch, echo, cd, grep, more, find, tail, head, sort, cut, wc
echo.
set /p command=Enter Linux command: 

rem Convert Linux command to Windows command
if "%command:~0,2%"=="ls" (
    call :ls %command:~3%
) else if "%command:~0,3%"=="pwd" (
    call :pwd
) else if "%command:~0,3%"=="cat" (
    call :cat %command:~4%
) else if "%command:~0,2%"=="rm" (
    call :rm %command:~3%
) else if "%command:~0,5%"=="mkdir" (
    call :mkdir %command:~6%
) else if "%command:~0,5%"=="rmdir" (
    call :rmdir %command:~6%
) else if "%command:~0,2%"=="cp" (
    call :cp %command:~3%
) else if "%command:~0,2%"=="mv" (
    call :mv %command:~3%
) else if "%command:~0,5%"=="touch" (
    call :touch %command:~6%
) else if "%command:~0,4%"=="echo" (
    call :echo %command:~5%
) else if "%command:~0,2%"=="cd" (
    call :cd %command:~3%
) else if "%command:~0,4%"=="grep" (
    call :grep %command:~5%
) else if "%command:~0,4%"=="more" (
    call :more %command:~5%
) else if "%command:~0,4%"=="find" (
    call :find %command:~5%
) else if "%command:~0,4%"=="tail" (
    call :tail %command:~5%
) else if "%command:~0,4%"=="head" (
    call :head %command:~5%
) else if "%command:~0,4%"=="sort" (
    call :sort %command:~5%
) else if "%command:~0,3%"=="cut" (
    call :cut %command:~4%
) else if "%command:~0,2%"=="wc" (
    call :wc %command:~3%
) else (
    echo Command not supported.
)

echo.
pause
goto main

:ls
dir %*
goto :eof

:pwd
cd
goto :eof

:cat
type %*
goto :eof

:rm
del %*
goto :eof

:mkdir
mkdir %*
goto :eof

:rmdir
rmdir %*
goto :eof

:cp
copy %*
goto :eof

:mv
move %*
goto :eof

:touch
type nul > %*
goto :eof

:echo
echo %*
goto :eof

:cd
cd %*
goto :eof

:grep
findstr %*
goto :eof

:more
more %*
goto :eof

:find
dir /s /b %*
goto :eof

:tail
type %* | more
goto :eof

:head
for /f "tokens=1,* delims=:" %%A in ('findstr /n "^" %* ^| findstr /b "1:"') do echo %%B
goto :eof

:sort
sort %*
goto :eof

:cut
for /f "tokens=%* delims= " %%A in (%*) do echo %%A
goto :eof

:wc
if "%*"=="-l" (
    find /c /v "" %*
) else if "%*"=="-w" (
    for /f %%A in ('type %* ^| find /c /v ""') do echo %%A
) else if "%*"=="-c" (
    for %%A in (%*) do call :CountChars "%%A"
) else (
    echo Invalid option. Supported options: -l (lines), -w (words), -c (characters)
)
goto :eof

:CountChars
setlocal enabledelayedexpansion
set "count=0"
for /f %%A in ('type %1 ^| find /c /v ""') do set /a count+=%%A
echo !count!
endlocal
goto :eof
