function New-Five9Prompt
{
    <#
    .SYNOPSIS
    
        Function used to create a new WAV or TTS prompt in Five9

    .EXAMPLE

        New-Five9Prompt -Name 'WAV_Greeting' -Type: WAV -FilePath 'C:\recordings\my_greeting.wav'

        # Creates a new WAV prompt using a local file

    .EXAMPLE

        New-Five9Prompt -Name 'TTS_Greeting' -Type: TTS -Text "Thanks for calling! Please hold while we transfer your call."

        # Creates a new TTS prompt
 
    .EXAMPLE
    
        New-Five9Prompt -Name date_prompt -Text "2020-02-04" -Type: TTS -Voice: Tom -SayAs: Date -SayAsFormat: Date_DMY
    
        # Creates a new TTS prompt using additional parameters


    #>
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        # New prompt name
        [Parameter(Mandatory=$true, Position=0)][string]$Name,

        # Description of new prompt
        [Parameter(Mandatory=$false)][string]$Description,

        <# 
        New prompt type

        Options are:
            • WAV
            • TTS
        #>
        [Parameter(Mandatory=$true)][ValidateSet("WAV", "TTS")][string]$Type,

        # If -Type is set to "WAV", use this parameter to specify the file path
        [Parameter(Mandatory=$false)][string]$FilePath,

        # If -Type is set to "TTS", use this parameter to specify the text to convert to TTS
        [Parameter(Mandatory=$false)][string]$Text,

        # Voice used to pronounce the TTS prompt. Only used for TTS prompts.
        [Parameter(Mandatory=$false)][ValidateSet('Samantha','Donna','Jennifer','Jill','Tom')][string]$Voice,

        <# 
        Describes how letters, numbers, and symbols are pronounced. Only used for TTS prompts.

        Options are :
            • Default
            • Words
            • Acronym
            • Address
            • Cardinal
            • Currency
            • Date
            • Decimal
            • Digits
            • Duration
            • Fraction
            • Letters
            • Measure
            • Name
            • Net
            • Telephone
            • Ordinal
            • Spell
            • Time
        #>
        [Parameter(Mandatory=$false)][ValidateSet('Default','Words','Acronym','Address','Cardinal','Currency','Date','Decimal','Digits','Duration','Fraction','Letters','Measure','Name','Net','Telephone','Ordinal','Spell','Time')][string]$SayAs,

        <#
        Date and time format of the prompt. Only used for TTS prompts.

        Options are:
            • NoFormat
            • Default
            • Date_MDY
            • Date_DMY
            • Date_YMD
            • Date_YM
            • Date_MY
            • Date_DM
            • Date_MD
            • Date_Y
            • Date_M
            • Date_D
            • Duration_HMS
            • Duration_HM
            • Duration_MS
            • Duration_H
            • Duration_M
            • Duration_S
            • Net_URI
            • Net_EMAIL
            • Time_HMS
            • Time_HM
            • Time_H
        #>
        [Parameter(Mandatory=$false)][ValidateSet('NoFormat','Default','Date_MDY','Date_DMY','Date_YMD','Date_YM','Date_MY','Date_DM','Date_MD','Date_Y','Date_M','Date_D','Duration_HMS','Duration_HM','Duration_MS','Duration_H','Duration_M','Duration_S','Net_URI','Net_EMAIL','Time_HMS','Time_HM','Time_H')][string]$SayAsFormat

    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        $promptInfo = New-Object PSFive9Admin.promptInfo
        $promptInfo.name = $Name
        $promptInfo.description = $Description


        if ($Type -eq "WAV")
        {
            
            if ($PSBoundParameters.Keys -notcontains "FilePath")
            {
                throw "Parameter '-FilePath' must be specified when uploading a WAV prompt."
                return
            }

            $wavFile = $null
            try
            {
                $wavFile = Get-Item $FilePath
            }
            catch
            {

            }

            if ($wavFile -eq $null)
            {
                throw "Could not find file '$FilePath'"
                return
            }
            

            if ($wavFile.Extension -ne '.wav')
            {
                throw "File being uploaded must be WAVE audio, ITU G.711 mu-law, mono 8000 Hz. You can convert file by going to 'https://G711.org/' and selecting type 'u-law (8Khz, Mono, u-law)'."
                return
            }
 
            
            try
            {
                $metadata = $null
                $metadata = Get-FileMetaData -FilePath $FilePath
            }
            catch
            {

            }

            if ($metadata -and $metadata.'Bit rate' -ne '64kbps')
            {
                throw "File being uploaded must be WAVE audio, ITU G.711 mu-law, mono 8000 Hz."
                return
            }


            $promptInfo.type = "PreRecorded"
            $promptInfo.typeSpecified = $true


            $Wav = [IO.File]::ReadAllBytes($FilePath)
            $Base64Wav = [Convert]::ToBase64String($Wav)
            $ConvertedWav = [System.Convert]::FromBase64String($Base64Wav)

            Write-Verbose "$($MyInvocation.MyCommand.Name): Creating new WAV prompt. '$($wavFile.Name)' > '$Name'." 
            return $global:DefaultFive9AdminClient.addPromptWavInline($promptInfo, $ConvertedWav)

        }
        elseif ($Type -eq "TTS")
        {
            if ($Text.Length -lt 1)
            {
                throw "Parameter '-Text' must be specified when creating a TTS prompt."
                return
            }

            $promptInfo.type = "TTSGenerated"
            $promptInfo.typeSpecified = $true
            
            $ttsInfo = New-Object PSFive9Admin.ttsInfo
            $ttsInfo.text = $Text

            if ($PSBoundParameters.Keys -contains "SayAs")
            {
                $ttsInfo.sayAs = $SayAs
                $ttsInfo.sayAsSpecified = $true
            }

            if ($PSBoundParameters.Keys -contains "SayAsFormat")
            {
                $ttsInfo.sayAsFormat = $SayAsFormat
                $ttsInfo.sayAsFormatSpecified = $true
            }

            if ($PSBoundParameters.Keys -contains "Voice")
            {
                $ttsInfo.voice = $Voice
            }
 

            Write-Verbose "$($MyInvocation.MyCommand.Name): Creating new TTS prompt '$Name'." 
            return $global:DefaultFive9AdminClient.addPromptTTS($promptInfo, $ttsInfo)

        }


    }
    catch
    {
        throw $_
    }
}
