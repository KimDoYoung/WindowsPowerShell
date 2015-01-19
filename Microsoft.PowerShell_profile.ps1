#---------------------------------------------------
# 환경변수
#---------------------------------------------------

$GLOBAL:psshome="C:\Users\Administrator\Documents\WindowsPowerShell"
$GLOBAL:JAVA_HOME="C:\Program Files\Java\jdk1.8.0_11"
$GLOBAL:MAVEN_HOME="C:\java_utils\apache-maven-3.2.5"

#---------------------------------------------------
# 환경변수
#---------------------------------------------------
$env:path += ';c:\Windows'
$env:path += ';c:\Windows\System32'
$env:path += ';C:\utility'
$env:path += ';$JAVA_HOME\bin;$MAVEN_HOME\bin'
$env:path += ';C:\Program Files (x86)\Git\bin'
# PowerShell Script를 모아둔 곳 

#---------------------------------------------------------
# Alias
#---------------------------------------------------------
Set-Alias npp 'C:\Program Files (x86)\Notepad++\notepad++.exe'
Set-Alias evernote "C:\Program Files (x86)\Evernote\Evernote\Evernote.exe"
Set-Alias luna "C:\java_utils\eclipse\eclipse.exe"
Set-Alias subl "C:\Program Files\Sublime Text 3\sublime_text.exe"
Set-Alias ll Get-ChildItem
#--------------------------------------------------------------
# 외부 ps1의 실행
#--------------------------------------------------------------
# 명령어들
#------------------------------------------------------------
# Prompt
#------------------------------------------------------------
. "$psshome\prompt.ps1" 
. "$psshome\command.ps1"