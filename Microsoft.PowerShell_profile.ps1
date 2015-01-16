#------------------------------------------------------------
# Prompt
#------------------------------------------------------------
Function prompt {

   $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()

   $windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity

   $windowTitle = "PowerShell - `"$(get-location)`""

   [bool] $isAdministrator = $windowsPrincipal.IsInRole("Administrators") -eq 1

   if ($windowTitle -ne $host.ui.rawui.windowtitle) {

      if ($isAdministrator) {

         $host.UI.RawUI.WindowTitle = "[ADMINISTRATOR] " + $windowTitle

      } else {

         $host.UI.RawUI.WindowTitle = $windowTitle

      }

   }

   Write-Host "$([DateTime]::Now.ToString('HH:mm:ss'))" -nonewline -backgroundcolor White -foregroundcolor Black

   Write-Host ' ' -nonewline

   if ($isAdministrator) {

      Write-Host ("$(get-location)") -backgroundcolor Red

   } else {

      Write-Host ("$(get-location)") -backgroundcolor Blue
   }

   '> '
}

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
#--------------------------------------------------------------
# 외부 ps1의 실행
#--------------------------------------------------------------
# 명령어들
. "$psshome\command.ps1"