#!/bin/bash 

xcopy /e /i minecraft minecraft.old

echo "Copying source"
# xcopy /e /i src\common "%MCPPATH%"\src\minecraft
rsync -avP src\common mcp\src\minecraft

echo "Calling MCP"
cd mcp

runtime\bin\python\python_mcp runtime\recompile.py
runtime\bin\python\python_mcp runtime\reobfuscate.py --srgnames

title Restoring MC source backup
cd "%MCPPATH%"\src
:remove
if exist minecraft (
  rd /s /q minecraft
  if errorlevel 1 goto remove
) else (
  goto rename
)
:rename
if exist minecraft.old (
  ren minecraft.old minecraft
  if errorlevel 1 goto remove
) else (
  goto arename
)
:arename

title Packaging classes
cd "%MCPPATH%"\reobf\minecraft
7z a -x!miscperipherals/api ..\..\miscperipherals.zip miscperipherals com/jacob

if exist "%MCPPATH%"\signjar.bat (
  title Signing jar
  cd "%MCPPATH%"
  rem call signjar
)

title Adding API
cd "%MCPPATH%"\reobf\minecraft
7z a ..\..\miscperipherals.zip miscperipherals\api
cd "%GITPATH%"\src\common
7z a ..\..\miscperipherals.zip miscperipherals\api

title Packaging resources
cd "%GITPATH%"\resources
7z a "%MCPPATH%"\miscperipherals.zip *

title Done
pause