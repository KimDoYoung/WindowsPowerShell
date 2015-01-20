#---------------------------------------------------
# global variables
#---------------------------------------------------
$GLOBAL:psshome="C:\Users\Administrator\Documents\WindowsPowerShell"
$GLOBAL:JAVA_HOME="C:\Program Files\Java\jdk1.8.0_11"
$GLOBAL:MAVEN_HOME="C:\java_utils\apache-maven-3.2.5"

#---------------------------------------------------
# Path
#---------------------------------------------------
$env:path += ';c:\Windows'
$env:path += ';c:\Windows\System32'
$env:path += ';C:\utility'
$env:path += ';$JAVA_HOME\bin;$MAVEN_HOME\bin'
$env:path += ';C:\Program Files (x86)\Git\bin'
# PowerShell Script¸¦ ¸ð¾ÆµÐ °÷ 

#---------------------------------------------------------
# Alias
#---------------------------------------------------------
Set-Alias npp 'C:\Program Files (x86)\Notepad++\notepad++.exe'
Set-Alias evernote "C:\Program Files (x86)\Evernote\Evernote\Evernote.exe"
Set-Alias luna "C:\java_utils\eclipse\eclipse.exe"
Set-Alias subl "C:\Program Files\Sublime Text 3\sublime_text.exe"
Set-Alias ll Get-ChildItem

#------------------------------------------------------------
# Prompt and Command
#------------------------------------------------------------
. "$psshome\prompt.ps1" 
. "$psshome\command.ps1"