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
