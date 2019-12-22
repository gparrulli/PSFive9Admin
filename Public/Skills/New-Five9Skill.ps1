<#
.SYNOPSIS
    
    Function used to create a new skill
 

.PARAMETER SkillName
 
    New skill name

.PARAMETER Description
 
    New skill description

.PARAMETER RouteVoiceMails
 
    Whether to route voicemail messages to the skill
   
.EXAMPLE
    
    New-Five9Skill -SkillName "MultiMedia"
    
    # Creates a new skill named MultiMedia
    

#>
function New-Five9Skill
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        [Parameter(Mandatory=$true)][string]$SkillName,
        [Parameter(Mandatory=$false)][string]$Description,
        [Parameter(Mandatory=$false)][bool]$RouteVoiceMails
    )

    $skill = New-Object PSFive9Admin.skill
    $skill.name = $SkillName
    $skill.description = $Description

    if ($RouteVoiceMails -eq $true)
    {
        $skill.routeVoiceMailsSpecified = $true
        $skill.routeVoiceMails = $true
    }


    $skillInfo = New-Object PSFive9Admin.skillInfo
    $skillInfo.skill = $skill
    $skillInfo.users = @()

    $response = $global:DefaultFive9AdminClient.createSkill($skillInfo)

    return $response.skill

}
