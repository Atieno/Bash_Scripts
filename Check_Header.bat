@echo off
REM =====================================================================================
REM	This script selects the Header from POS
REM
REM
REM =====================================================================================
REM DATE		AUTHOR		COMMENT
REM 2016-06-14	M.Tietz		Re-designe of scripts. 
REM							Now the log file and needed variables for executing query
REM							is initialized in separate batch to be able to re-use the 
REM 						scripts for DOS and FRC
REM 2016-06-14	M.Gaviano	converted to new template
REM =====================================================================================
REM
REM #################################################
REM
REM					INITIALIZATION
REM
REM #################################################
REM
Setlocal
SET CHECK_TITLE=CHECK EOD DATE ON STORE
title %CHECK_TITLE%
cd %~dp0
REM
REM INIT GLOBAL VARIABLES AND PASS LOG FILE NAME
call __InitGlobalVars.bat Header

REM #################################################
REM
REM						EXECUTION
REM
REM #################################################
REM
REM
REM PRINT HEADERS AND EXECUTE QUERY
REM HEADERS ARE SUPRESSED IN OSQL COMMAND
REM
REM Print headers and suppress afterwards in OSQL command the header lines
echo #System;dbo.Computer.szComputerName;dbo.Footer.szWorkstationGroupID;dbo.Footer.lRetailStoreID;dbo.Footer.lManualSequenceNumber;dbo.Footer.szShortText;dbo.Footer.szLongText;>%LOG%

FOR /f %%G IN (List.txt) DO (call __execQueryMultiLine.bat %%G "TPCentralDB" "%SCRIPT_FOLDER%\CheckHeader.sql")

Find ".xml" %LOG% > EOD_Date.txt

GOTO END

:END
echo CHECK ON %DATE% >> %LOG%