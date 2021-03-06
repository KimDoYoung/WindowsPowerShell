﻿#
# 명령어들 
#
#----------------------------------------------------------
# 'go' command and dess
#----------------------------------------------------------
if( $GLOBAL:go_dir -eq $null ) 
{
  $GLOBAL:go_dir = @{};
}
function go ([string] $location) 
{
	if( $go_dir.ContainsKey($location) ) 
	{
		set-location $go_dir[$location];
	} else {
		write-output "다음과 같은 디렉토리가 정해져있읍니다:";
		write-output $go_dir;
	}
}
$GLOBAL:go_dir = @{};
$go_dir.Add("pss", "$psshome")
$go_dir.Add("program", "C:\Program Files")
$go_dir.Add("program86", "C:\Program Files (x86)")
$go_dir.Add("dev", "C:\workspace\dev")
$go_dir.Add("host", "C:\Windows\System32\drivers\etc")
$go_dir.Add("apache", "C:\jmes\Apache24")
$go_dir.Add("jstest", "C:\Users\Administrator\Dropbox\jsTest")
#add directroy 
function adddir($nm)
{
  $now = pwd;
  $go_dir.Add($nm,$now);
}

#----------------------------------------------------------
# 'run' command 
#----------------------------------------------------------
if( $GLOBAL:run_exes -eq $null ) 
{
    $GLOBAL:run_exes = @{};
}
function run([string] $exe) 
{
  if( $run_exes.ContainsKey($exe) ) {
     Invoke-item ($run_exes[$exe])
  } else {
    write-output "다음과 같은 유틸리티들이 등록되어 있읍니다:";
    write-output $run_exes;
  }
}
$GLOBAL:run_exes = @{};
# system
$run_exes.Add("appwiz","c:\windows\system32\appwiz.cpl")
$run_exes.Add("compmgmt","c:\windows\system32\compmgmt.msc")
$run_exes.Add("service","c:\windows\system32\services.msc")
$run_exes.Add("disk","c:\windows\system32\diskmgmt.msc")
$run_exes.Add("control","c:\windows\system32\control.exe")
$run_exes.Add("desk","c:\windows\system32\desk.cpl")
$run_exes.Add("sound","c:\windows\system32\mmsys.cpl")
$run_exes.Add("network","c:\windows\system32\ncpa.cpl")
$run_exes.Add("internet","c:\windows\system32\inetcp.cpl")
$run_exes.Add("device","c:\windows\system32\devmgmt.msc")
$run_exes.Add("sys","c:\windows\system32\sysdm.cpl")
$run_exes.Add("version","c:\windows\system32\winver.exe")
$run_exes.Add("vol","c:\windows\system32\sndvol32.exe")
$run_exes.Add("perform","c:\windows\system32\perfmon.msc")
$run_exes.Add("remote","c:\windows\system32\mstsc.exe")
$run_exes.Add("event","c:\windows\system32\eventvwr.msc")
$run_exes.Add("sharefold","c:\windows\system32\fsmgmt.msc")
$run_exes.Add("usr","c:\windows\system32\lusrmgr.msc")

$run_exes.Add("doc","C:\Program Files (x86)\Microsoft Office\Office12\WINWORD.EXE")
$run_exes.Add("xls","C:\Program Files (x86)\Microsoft Office\Office12\EXCEL.EXE")
$run_exes.Add("ppt","C:\Program Files (x86)\Microsoft Office\Office12\POWERPNT.EXE")

$run_exes.Add("xscrchk","C:\Utility\xscrchk.exe")
$run_exes.Add("mysql","C:\Program Files (x86)\SQLyog Enterprise\SQLyogEnt.exe")

$run_exes.Add("movie","C:\Utility\MovieRename.exe")
$run_exes.Add("br","C:\Program Files (x86)\Brackets\Brackets.exe")
#----------------------------------------------------------
# Utility functions
#----------------------------------------------------------
function backcolor(
  [string]$color = $(throw "specify backgroud color name")
){
    $Host.UI.RawUI.BackgroundColor = $color
	Clear-Host
}
function term([String]$name='Default Settings') {
    c:\utility\putty -load $name
}
function gitbash() {
    backcolor 'Black'
    $cmd = "C:\Program Files (x86)\Git\bin\sh.exe"
    $arg1 = "--login"
    $arg2 = "-i"
    & $cmd $arg1 $arg2
}
function killjava(){
  taskkill /im java.exe /f
}

function backup {
	$today = (Get-Date).ToString("yyyy_MM_dd_HH_mm_ss")
	$srcFolders = @(
		"c:\workspace\dev"
	)
	$desFolder = "c:\temp\backup_$today"
	if(!(Test-Path -Path $desFolder)) {
		New-Item -ItemType Directory -Force -Path $desFolder
	}
	foreach($srcFolder in $srcFolders){
		Copy-Item $srcFolder $desFolder -recurse -force
	}
	#zip -q -r $des_file c:/jmes/web/admin
}
function xcopy(
	[string]$src = $(throw "specify the source folder"),
	[string]$des = $(throw "specify the destination folder")
){
	$src = $src -replace '\*S'
	if(test-path $des){
		switch -regex($src){
			'\\S' {$src = "$src*"; break}
			'\w$' {$src = "$src\*"; break}
			default {break}
		}
	}
	Copy-Item $src $des -recurse -force
}
