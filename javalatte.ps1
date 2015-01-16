#Visual Studio로 작업하기 위한 환경을 만든다
$GLOBAL:JavaLatteHome="D:\CSWinForm_2009\JavaLatte\";
$env:path += ';c:\Utility\xunit'
function jHelp ()
{
	Write-Host "---------------------------------";
	Write-Host "Home : $JavaLatteHome";
	Write-Host "xtest : Core를 컴파일을 한다";
	Write-Host "xtestdb : 디버그용 xml을 DB로부터 만들어서 xtest를 수행한다";
	Write-Host "---------------------------------";	
}

# 1.csc와 ildasm을 path에 추가한다
#$env:path += ';C:\WINDOWS\Microsoft.NET\Framework\v3.5'
#$env:path += ';C:\Program Files\Microsoft SDKs\Windows\v6.0A\bin'

function gen ()
{	
	Get-Process | where {$_.Name -eq "JavaLatte.Generator"} | kill;	
	gen;
}
function preversion()
{
	Set-Location "$JavaLatteHome\Preversion\bin\Debug";
   [Diagnostics.Process]::Start("$JavaLatteHome\Preversion\bin\Debug\Preversion.exe");
}
#
# JavaLatte.Core를 다시 컴파일할때
# Release로 컴파일한다
#
function newcore()
{
	# gen이 실행되고있으면 죽인다
	Get-Process | where {$_.Name -eq "JavaLatte.Generator"} | kill;	
	Set-Location "$JavaLatteHome\Preversion";

	Write-Host "---------------------------------";
	Write-Host "JavaLatte.Core.Dll 컴파일";
	Write-Host "---------------------------------";	

	#core를 재 컴파일한다
	Msbuild ./JavaLatte.Core.xml  /property:DebugSymbols=false;

	Write-Host "---------------------------------";
	Write-Host "Preversion.exe 컴파일";
	Write-Host "---------------------------------";		
	#preversion을 재 컴파일한다
	msbuild ./Preversion.csproj ;
	
	#gen과 console을 재 컴파일한 후 exe에 복사한다
	Write-Host "---------------------------------";
	Write-Host "JavaLatte.Generator.exe  컴파일 (Release)";
	Write-Host "---------------------------------";			
	Set-Location "$JavaLatteHome\javalatte.Generator"
	msbuild ./JavaLatte.Generator.csproj /property:Configuration=Release
	Copy-Item "$JavaLatteHome\javalatte.Generator\bin\Release\javalatte.Generator.exe" "$JavaLatteHome\exes\generator"

	Write-Host "---------------------------------";
	Write-Host "JavaLatte.Console.exe  컴파일 (Release)";
	Write-Host "---------------------------------";			
	Set-Location "$JavaLatteHome\javalatte.Console"
	msbuild ./JavaLatte.Console.csproj /property:Configuration=Release
	Copy-Item "$JavaLatteHome\javalatte.Console\bin\Release\javalatte.Console.exe" "$JavaLatteHome\exes\console"
}
#
# JavaLatte ExternalLibs를 다시 컴파일할때
#
function newext()
{
	Get-Process | where {$_.Name -eq "JavaLatte.Generator"} | kill;	
	Set-Location "$JavaLatteHome\ExternalLibs";
	#Msbuild ./allcompile.proj  /property:DebugSymbols=false
	$JavaLatteCore="/r:$JavaLatteHome\libs\JavaLatte.Core.dll";
	$Rs232Buffer = "/r:$JavaLatteHome\Libs\Rs232buffer.dll"
	$MySql = "/r:$JavaLatteHome\Libs\MySql.Data.dll"
	$SqlLite = "/r:$JavaLatteHome\Libs\System.Data.SQLite.dll"
	$SqlLiteLinq = "/r:$JavaLatteHome\Libs\System.Data.SQLite.Linq.dll"
	$Oracle="/r:$JavaLatteHome\Libs\Oracle.DataAccess.dll"
	$HtmlAgilityPack = "/r:$JavaLatteHome\Libs\HtmlAgilityPack.dll"
	$BetterImageProcessorQuantization="/r:$JavaLatteHome\Libs\BetterImageProcessorQuantization.dll"
	$Ioniczip="/r:$JavaLatteHome\Libs\Ionic.Zip.dll"
	
	Write-Host "------------------------------------";
	Write-Host ">>ByteLib";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\ByteLib";
	csc /target:library $Rs232Buffer $JavaLatteCore *.cs
	move ByteLib.dll $JavaLatteHome\Libs -Force

	$module="DateTimeLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force

	$module="EncryptLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore  *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force
	
	$module="EnvLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore  *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force

	$module="FileLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore  *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force	

	$module="HtmlLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore  $HtmlAgilityPack  *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force		

	$module="ImageLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore $BetterImageProcessorQuantization *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force		
	
	$module="MathLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force	

	$module="NetworkLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force	
	
	$module="StringLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force	
	
	$module="WinFormLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force		

	
	$module="XmlLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force	

	$module="ZipLib";
	Write-Host "------------------------------------";
	Write-Host ">>$module";
	Write-Host "------------------------------------";
	Set-Location "$JavaLatteHome\ExternalLibs\$module";
	csc /target:library /out:$module.dll $Rs232Buffer $JavaLatteCore  $Ioniczip *.cs
	move "$module.dll" $JavaLatteHome\Libs -Force		
	
	Write-Host "------------------------------------";
	Write-Host ">>ExternalLib.dll";
	Write-Host "------------------------------------";	
	Set-Location "$JavaLatteHome\ExternalLibs";
	Msbuild ./ExternalLibs.csproj /property:Configuration=Release
	Msbuild ./ExternalLibs.csproj /property:Configuration=Debug
	

}
function ext1()
{
	Set-Location "$JavaLatteHome\ExternalLibs\ByteLib";
	csc /target:library /r:$JavaLatteHome\Libs\Rs232buffer.dll /r:$JavaLatteHome\libs\JavaLatte.Core.dll *.cs
}
#
# JavaLatte External을 디버깅용으로 컴파일한다
#
function newextdebug()
{
	Get-Process | where {$_.Name -eq "JavaLatte.Generator"} | kill;	
	Set-Location "$JavaLatteHome\ExternalLibs";
	Msbuild ./allcompile.proj /property:DebugSymbols=true
	Msbuild ./ExternalLibs.csproj /property:Configuration=Debug
}
function copydlls()
{
	#preversion 하위의 external에 모든 dll을 copy한다

	$pHome = "$JavaLatteHome\Preversion"
	$libs = "$JavaLatteHome\Libs";
	#Write-Host $pHome;
	Write-Host "------------------------------------";
	Write-Host ">>Create Preversion/External and copy";
	Write-Host "------------------------------------";
	if (!(Test-Path -path "$pHOme\bin\Debug\External")) 
	{
		Write-Host "Create Preversion/External";
		New-Item "$pHOme\bin\Debug\External" -type directory
	}
	Copy-Item "$Libs\*.dll" "$pHome\bin\Debug\External"
	if(Test-Path "$pHome\bin\Debug\External\JavaLatte.Core.dll")
	{
		Remove-Item "$pHome\bin\Debug\External\JavaLatte.Core.dll";
	}
}
#
#preversion에서 개발한것에 대해서 xtest를 수행해 본다
#아울러 컴파일 또는 테스트에서 나온 문서를 생성한다
#
function xtest(){

	$xHome = "$JavaLatteHome\xtest";
	
	#xtest디렉토리로 이동
	Set-Location "d:\CSWinForm_2009\JavaLatte\xtest"
	Copy-Item "$JavaLatteHome\Libs\xunit.dll" .
	
	#xtest에 있는 모든 .cs파일과 javalatte.core.dll을 삭제한다
	Write-Host "---------------------------------";
	Write-Host "모든 .cs와 javalatte.core.dll삭제";
	Write-Host "---------------------------------";
	Remove-Item *.cs
	if((Test-Path JavaLatte.Core.dll))
	{
		Remove-Item JavaLatte.Core.dll
	}
	Write-Host "---------------------------------";
	Write-Host "필요한 파일들 복사해옴";
	Write-Host "---------------------------------";	
	#preversion에서 copy해 온다
	Copy-Item "$JavaLatteHome\preversion\CWG*.cs" .
	Copy-Item "$JavaLatteHome\preversion\x*.cs" .
	Copy-Item "$JavaLatteHome\preversion\core.rsp" .
	Copy-Item "$JavaLatteHome\JavaLatte.CreateTestXml\bin\Debug\*.xml" .
	if (!(Test-Path -path "$xHome\External"))
	{
		Write-Host "Create xtest/External";
		New-Item "$xHome\External" -type directory
	}
	Copy-Item "$JavaLatteHome\Libs\*.dll" "$xHome\External"
	if(Test-Path "$xHome\External\JavaLatte.Core.dll")
	{
		Remove-Item "$xHome\External\JavaLatte.Core.dll";
	}

	Write-Host "---------------------------------";
	Write-Host "컴파일";
	Write-Host "---------------------------------";	
	#csc로 컴파일한다
	$rsp="@core.rsp"
	csc $rsp
	Write-Host "---------------------------------";
	Write-Host "x-unit 테스트";
	Write-Host "---------------------------------";	
	#x-unit 테스트를 수행한다
	xunit.console.clr4.exe JavaLatte.Core.dll
}
#
# DB에서 xmltest DB에 있는 내용을 가져와서 xml을 만든 후에
# xtest를 돌린다
#
function xtestdb()
{
	
	Write-Host "---------------------------------";
	Write-Host "DB로부터 Data를 가져와서 테스트용 xml을 만듭니다";
	Write-Host "---------------------------------";	
	Set-Location "$JavaLatteHome\JavaLatte.CreateTestXml\bin\Debug";
	./JavaLatte.CreateTestXml.exe;
	xtest;
}
#새로운 버젼이 만들어지고 배포할때
function webcommit()
{
  $exedir = "d:\CSWinForm_2009\JavaLatte\Exes";
  $webdir = "d:\CSWinForm_2009\JavaLatte\Web\Download";
  Set-Location $exedir;
  msbuild ZipAndCopy.proj;
  
  
  Set-Location $webdir;
  Copy-Item D:\CSWinForm_2009\JavaLatte\문서\*.docx .
  Copy-Item D:\CSWinForm_2009\JavaLatte\문서\*.pptx .
  
  $txt = "./CompileDate.txt";
#  $a = gc  $txt | select -Last 3  ;
#  $files = "";
#  foreach ( $s in $a) { 
  #	$files += $s+"*";
#	Write-Host $s;
#  }
  #tortoiseproc.exe /command:add /path:$files /closeonend:1 /notempfile
  #tortoiseproc.exe /command:commit /path:$files /closeonend:1 /notempfile /logmsg:release
  Write-Host "1. ------- svn add files " ;
  gc  $txt | select -Last 3  ;
  Write-Host "2. ------- commit " ;
}
#
# JavaLatte 배포판 만들기
#
function jl_copy {
param ( 
[string] $verNo1 ,
[string] $verNo2 ,
[string] $verNo3 ,
[string] $verNo4 
) 
  $srchome= $JavaLatteHome;
  $srcdir = "$JavaLatteHome\JavaLatte.Generator\bin\Debug";
  Set-Location "$srcdir";
  $appName = "JavaLatte.Generator";
  $iconName = "JavaLatte.ico";
  $deploy_base = "d:\deploy_JavaLatte";
  $deploy_app = "$deploy_base\Application Files";
  Write-Host "$deploy_app";
  $new_deploydir="$deploy_app\\$appName"+"_$verNo1"+"_$verNo2"+"_$verNo3"+"_$verNo4";
  Write-Host "Create $new_deploydir";
  
  #D:\Deploy\Application Files\Mage3_$ver
  #1.디렉토리를 만든다
  	if (!(Test-Path -path "$new_deploydir")) 
	{
		Write-Host "Create $new_deploydir";
		New-Item "$new_deploydir" -type directory
	}else{
		Remove-Item "$new_deploydir" -Recurse -Force
		New-Item "$new_deploydir" -type directory
	}
	Copy-Item "$srchome\\$appName\\$iconName" $srcdir -Force
	xcopy "$srcdir" "$new_deploydir" /S

	Set-Location "$new_deploydir";
	Remove-Item *.application -Recurse -Force
	Remove-Item *.manifest -Recurse -Force
	Remove-Item *.pdb -Recurse -Force
	Remove-Item *.vshost.exe -Recurse -Force
	if ((Test-Path -path "$new_deploydir\\app.publish")) 
	{
		Remove-Item app.publish -Recurse -Force
	}
	$verNumber = $verNo1+"."+$verNo2+"."+$verNo3+"."+$verNo4;
	return
	Write-Host "---------------------------------";
	Write-Host "mage -New Application 응용프로그램 메니페스트만들기";
	Write-Host "---------------------------------";		
	mage -New Application -Processor x86 -ToFile "$appName.exe.manifest" -name "$appName" -Version $verNumber -FromDirectory . -TrustLevel FullTrust -IconFile $iconName
	Write-Host "---------------------------------";
	Write-Host "mage -Sign application manifest 응용프로그램 메니페스트 싸인";
	Write-Host "---------------------------------";		
	mage -Sign "$appName.exe.manifest" -CertFile d:\thp2compact\authkey\KalpaTCW.pfx -Password kalpa987
	Write-Host "---------------------------------";
	Write-Host "mage -Update $application manifest 응용프로그램 메니페스트 업데이트";
	Write-Host "---------------------------------";		
	mage -Update "$appName.exe.manifest" -Version $verNumber -FromDirectory .
	Write-Host "---------------------------------";
	Write-Host "appName.exe.manifest 에 서명 응용프로그램 메니페스트";
	Write-Host "---------------------------------";		
	mage -Sign "$appName.exe.manifest" -CertFile d:\thp2compact\authkey\KalpaTCW.pfx -Password kalpa987  
	Write-Host "---------------------------------";
	Write-Host "root 에서 mage -Update application 배포매니페스트 업데이트";
	Write-Host "---------------------------------";		
	Set-Location "$deploy_base";
	$appNewDir = "$appName"+"_$verNo1"+"_$verNo2"+"_$verNo3"+"_$verNo4";
	mage -Update "$appName.application" -Version $verNumber -AppManifest "Application Files/$appNewDir/$appName.exe.manifest" -AppCodeBase "Application Files/$appNewDir/$appName.exe.manifest" -ProviderUrl "http://www.kalpa.co.kr/thp2compactweb/$appName.application" -Publisher "Kalpa Tech"
	Write-Host "---------------------------------";
	Write-Host "확장자 .deply붙이기";
	Write-Host "---------------------------------";		
	Set-Location "$new_deploydir";
	c:\utility\deployext.exe -add .
	
	Write-Host "---------------------------------";
	Write-Host "mage Sign 응용 배포매니페스트 서명";
	Write-Host "---------------------------------";		
	Set-Location "$deploy_base";
	mage -Sign "$appName.application" -CertFile d:\thp2compact\authkey\KalpaTCW.pfx -Password kalpa987
}

function jl_makeApplication {
param ( 
[string] $verNo1 ,
[string] $verNo2 ,
[string] $verNo3 ,
[string] $verNo4 
) 
	#$srchome= "$JavaLatteHome";
	#$srcdir = "$KComHome\bin\Release";
    $authkeyfile = "$JavaLatteHome\publicKey\javalatte.pfx";  
  
    $appName = "JavaLatte.Generator";
	$iconName = "javalatte.ico";
	$manifestName = "$appName.exe.manifest";
	$applicationName = "$appName.application";
	$provideUrl = "http://www.kalpa.co.kr/JavaLatte/$appName.application";
  
	$deploy_base = "d:\deploy_JavaLatte";
	$deploy_app = "$deploy_base\Application Files";
	$new_deploydir="$deploy_app\\$appName"+"_$verNo1"+"_$verNo2"+"_$verNo3"+"_$verNo4";
	$versionNumber="$verNo1"+".$verNo2"+".$verNo3"+".$verNo4";
   Set-Location $new_deploydir;
   mage -New Application -Processor x86 -ToFile "$manifestName" -name "$appName" -Version $versionNumber -FromDirectory . -TrustLevel FullTrust -IconFile $iconName;
	mage -Sign $manifestName -CertFile $authkeyfile -Password kalpa987                                 
	#3. Root에 가서한다
	Set-Location $deploy_base;
	mage -New Deployment -Processor x86 -Install true -Publisher "Kalpa Tech" -AppCodeBase "$new_deploydir/$manifestName" -ProviderUrl "$provideUrl" -AppManifest "$new_deploydir/$manifestName" -ToFile $applicationName;
	Get-Content $applicationName -encoding UTF8 | %{$_ -replace "<deployment install=`"true`">","<deployment install=`"true`"  mapFileExtensions=`"true`" trustURLParameters=`"true`">"} | Out-File -Encoding UTF8 Mage3.tmp
	remove-item $applicationName;
	copy-item Mage3.tmp $applicationName;
	remove-item Mage3.tmp;
	Set-Location $new_deploydir;
	c:\utility\deployext.exe -add .
	Set-Location $deploy_base;
	#6. 다시 싸인한다.
	mage -Sign $applicationName -CertFile $authkeyfile -Password kalpa987
}
#
# JavaLatte 배포판 만들기
#
function jl_mage {
param ( 
[string] $verNo1 ,
[string] $verNo2 ,
[string] $verNo3 ,
[string] $verNo4 
) 
	#$srchome= "$JavaLatteHome";
	$srcdir = "$JavaLatteHome\JavaLatte.Generator\bin\Debug";
	$authkeyfile = "$JavaLatteHome\publicKey\javalatte.pfx";  
	$appName = "JavaLatte.Generator";
	$iconName = "javalatte.ico";
	$manifestName = "$appName.exe.manifest";
	$applicationName = "$appName.application";
	$provideUrl = "http://www.kalpa.co.kr/JavaLatte/$appName.application";
  
	$deploy_base = "d:\deploy_JavaLatte";
	$deploy_app = "$deploy_base\Application Files";
	$new_deploydir="$deploy_app\\$appName"+"_$verNo1"+"_$verNo2"+"_$verNo3"+"_$verNo4";
  

  
	Set-Location "$new_deploydir";

	#4응용프로그램 메니페스트만들기	
	$verNumber = $verNo1+"."+$verNo2+"."+$verNo3+"."+$verNo4;
	Write-Host "---------------------------------";
	Write-Host "mage -New Application 응용프로그램 메니페스트만들기";
	Write-Host "---------------------------------";		
	mage -New Application -Processor x86 -ToFile "$manifestName" -name "$appName" -Version $verNumber -FromDirectory . -TrustLevel FullTrust -IconFile $iconName
	#mage -New Application -Processor x86 -ToFile JavaLatte.Generator.exe.manifest -name "JavaLatte.Generator" -Version 1.1.1.5 -FromDirectory . -TrustLevel FullTrust -IconFile javalatte.ico
	Write-Host "---------------------------------";
	Write-Host "mage -Sign application manifest 응용프로그램 메니페스트 싸인";
	Write-Host "---------------------------------";		
	mage -Sign "$manifestName" -CertFile "$authkeyfile" -Password kalpa987
	#mage -Sign .\JavaLatte.Generator.exe.manifest -CertFile d:\thp2compact\authkey\KalpaTCW.pfx -Password kalpa987   
	Write-Host "---------------------------------";
	Write-Host "mage -Update";
	Write-Host "---------------------------------";	
	mage -Update "$manifestName" -Version $verNumber -FromDirectory .
	
	Write-Host "---------------------------------";
	Write-Host "mage -Update sign";
	Write-Host "---------------------------------";	
	mage -Sign $manifestName -CertFile $authkeyfile -Password kalpa987   
	
	Write-Host "---------------------------------";
	Write-Host "루트로돌아간다.";
	Write-Host "---------------------------------";	
	Set-Location "$deploy_base";
	
	Write-Host "---------------------------------";
	Write-Host "application update";
	Write-Host "---------------------------------";	
	$appNewDir = "$appName"+"_$verNo1"+"_$verNo2"+"_$verNo3"+"_$verNo4";
	mage -Update $applicationName -Version $verNumber -AppManifest "Application Files/$appNewDir/$manifestName" -AppCodeBase "Application Files/$appNewDir/$manifestName" -ProviderUrl "http://www.kalpa.co.kr/javalatte/JavaLatte.Generator.application" -Publisher "Kalpa Tech"
	
	Set-Location $new_deploydir;
	c:\utility\deployext.exe -add .
	Set-Location $deploy_base;
	
	Write-Host "---------------------------------";
	Write-Host "application sign";
	Write-Host "---------------------------------";	
	mage -Sign $applicationName -CertFile $authkeyfile -Password kalpa987
	
	return;
	
}
function upws {
 Set-Location c:\workspace\WanSync-Daemon
 ant
 Set-Location c:\utility
 psftp root@192.168.0.32 -b c:\utility\wansync.txt
 del c:\workspace\WanSync-Daemon\*.jar
}