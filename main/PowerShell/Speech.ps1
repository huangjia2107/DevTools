<#
 若不能运行，则执行下列语句，以修改
 Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#>

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

function  Get-Childs($key) {
    Get-ChildItem -Path $key | Select-Object -ExpandProperty Name
}

<#
   Reg Type        PS Type
   --------        -------
   REG_DWORD       System.Int32          DWord
   REG_SZ          System.String         String
   REG_QWORD       System.Int64          QWord
   REG_BINARY      System.Byte[]         Binary
   REG_MULTI_SZ    System.String[]       MultiString
   REG_EXPAND_SZ   System.String         ExpandString

   Unknown, String, ExpandString, Binary, DWord, MultiString, QWord, None
#>
function Get-RegType($psType) {
    switch ($psType) {
        "Int32" { "DWord" }
        "Int64" { "QWord" }
        "Byte[]" { "Binary" }
        "String" { "String" }
        "String[]" { "MultiString" }
        "ExpandString" { "ExpandString" }
        default { "String" }
    }
}

function Get-RegTypeFromItem($item, $prop) {
    if ($prop -eq "(default)") {
        "String"
    }
    else {
        Get-RegType $item.GetValueKind($prop)
    }
}

$IsDo = 0

$speechPath = "HKLM:\Software\Microsoft\Speech\Voices\Tokens"
$ocSpeechPath = "HKLM:\Software\Microsoft\Speech_OneCore\Voices\Tokens"

$attrFolder = "Attributes"

# 检查目标路径
if (!(Test-Path $speechPath)) {
    Write-Host "Error: No found [$($speechPath)]" -ForegroundColor:Red
    return
}

# 检查源路径
if (!(Test-Path $ocSpeechPath)) {
    Write-Host "Error: No found [$($ocSpeechPath)]" -ForegroundColor:Red
    return
}

# 从源获取相应的键值
foreach ($ocVoice in Get-Childs $ocSpeechPath) {

    # 语音名称
    $voiceName = [System.IO.Path]::GetFileName($ocVoice)

    # 目标语音目录
    $voiceTarget = "$($speechPath)\$($voiceName)"

    # 忽略已经存在的
    if (Test-Path $voiceTarget) {
        Write-Host "Warning: Already existed [$($voiceTarget)]" -ForegroundColor:Yellow
        continue
    }

    Write-Host "------------------------------------------------Voice------------------------------------------------"

    # 不存在则创建
    Write-Host "New Voice [$($voiceTarget)]" -ForegroundColor:Green
    if ($IsDo) {
        New-Item -ItemType Directory -Path $voiceTarget
    }
    

    # 源语音目录
    $voiceSource = "$($ocSpeechPath)\$($voiceName)"

    # 源语音键值
    $voiceProps = (Get-ItemProperty $voiceSource).psobject.properties
    # 源语音对象，以此获取值数据类型
    $voiceItem = Get-Item $voiceSource

    # 属性
    foreach ($voiceProp in $voiceProps) {

        # 忽略 PowerShell 属性
        if ($voiceProp.Name.StartsWith("PS")) {
            continue
        }

        $propName = $voiceProp.Name
        $propValue = $voiceProp.Value.Replace("C:\Windows", "%windir%")
        $propType = Get-RegTypeFromItem $voiceItem $voiceProp.Name

        Write-Host "Set Property, Name: $($propName), Type: $($propType), Value: $($propValue)"
        
        # 添加属性键值
        if ($IsDo) {
            Set-ItemProperty -Path $voiceTarget -Name $propName -Type $propType -Value $propValue
        }
    }

    Write-Host "------------------------------------------------Attributes------------------------------------------------"

    $voiceTargetAttr = "$($voiceTarget)\$($attrFolder)"

    Write-Host "New Attribute [$($voiceTargetAttr)]" -ForegroundColor:Green
    if ($IsDo) {
        New-Item -ItemType Directory -Path $voiceTargetAttr
    }

    $voiceSourceAttr = "$($voiceSource)\$($attrFolder)"
    # 源语音键值
    $voiceAttrProps = (Get-ItemProperty $voiceSourceAttr).psobject.properties
    # 源语音对象，以此获取值数据类型
    $voiceAttrItem = Get-Item $voiceSourceAttr
   
    # 属性
    foreach ($voiceAttrProp in $voiceAttrProps) {

        # 忽略 PowerShell 属性
        if ($voiceAttrProp.Name.StartsWith("PS")) {
            continue
        }

        $attrPropName = $voiceAttrProp.Name
        $attrPropValue = $voiceAttrProp.Value
        $attrPropType = Get-RegTypeFromItem $voiceAttrItem $voiceAttrProp.Name

        Write-Host "Set Property, Name: $($attrPropName), Type: $($attrPropType), Value: $($attrPropValue)"
    
        # 添加属性键值
        if ($IsDo) {
            Set-ItemProperty -Path $voiceTargetAttr -Name $attrPropName -Type $attrPropType -Value $attrPropValue
        }
    }
}

if ($IsDo) {
    # Kangkang
    $speechKangkangPath = "$($speechPath)\MSTTS_V110_zhCN_KangkangM"
    if (Test-Path $speechKangkangPath) {
        Set-ItemProperty -Path $speechKangkangPath -Name "VoicePath" -Type "ExpandString" -Value "%windir%\Speech_OneCore\Engines\TTS\zh-CN\M2052Kangkang"
    }

    # Hongyu
    $speechHongyuPath = "$($speechPath)\MSTTS_V110_zhCN_HongyuM"
    if (Test-Path $speechHongyuPath) {
        return
    }

    New-Item -ItemType Directory -Path $speechHongyuPath

    Set-ItemProperty -Path $speechHongyuPath -Name "(default)" -Type "String" -Value "Microsoft Hongyu - Chinese(Simplified, PRC)"
    Set-ItemProperty -Path $speechHongyuPath -Name "804" -Type "String" -Value "Microsoft Hongyu - Chinese(Simplified, PRC)"
    Set-ItemProperty -Path $speechHongyuPath -Name "CLSID" -Type "String" -Value "{179F3D56-1B0B-42B2-A962-59B7EF59FE1B}"
    Set-ItemProperty -Path $speechHongyuPath -Name "LangDataPath" -Type "ExpandString" -Value "%windir%\Speech_OneCore\Engines\TTS\zh-CN\MSTTSLoczhCN.dat"
    Set-ItemProperty -Path $speechHongyuPath -Name "VoicePath" -Type "ExpandString" -Value "%windir%\Speech_OneCore\Engines\TTS\zh-CN\M2052Hongyu"

    $speechHongyuAttrPath = "$($speechHongyuPath)\$($attrFolder)"
    New-Item -ItemType Directory -Path $speechHongyuAttrPath

    Set-ItemProperty -Path $speechHongyuAttrPath -Name "Age" -Type "String" -Value "Adult"
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "DataVersion" -Type "String" -Value "11.0.2013.1022"
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "Gender" -Type "String" -Value "Female"
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "Language" -Type "String" -Value "804"
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "Name" -Type "String" -Value "Microsoft Hongyu"
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "SayAsSupport" -Type "String" -Value "spell=NativeSupported; cardinal=GlobalSupported; ordinal=NativeSupported; date=GlobalSupported; time=GlobalSupported; telephone=NativeSupported; computer=NativeSupported; address=NativeSupported; percentage=NativeSupported; currency=NativeSupported; message=NativeSupported; url=NativeSupported; alphanumeric=NativeSupported"
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "SharedPronunciation" -Type "String" -Value ""
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "Vendor" -Type "String" -Value "Microsoft"
    Set-ItemProperty -Path $speechHongyuAttrPath -Name "Version" -Type "String" -Value "11.0"
}

cmd /c pause | out-null