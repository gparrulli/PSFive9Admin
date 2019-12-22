<#
.SYNOPSIS
    
    Function used to modify a skill

.PARAMETER SkillName
 
    Skill to modify's name

.PARAMETER Description
 
    New description

.PARAMETER RouteVoiceMails
 
    Whether to route voicemail messages to the skill
   

.EXAMPLE
    
    Set-Five9Skill -SkillName "MultiMedia" -Description "Skill used for MultiMedia" -RouteVoiceMails: $true
    
    # Modifies the skill MultiMedia's properties
    

#>
function Set-Five9Skill
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
    elseif ($RouteVoiceMails -eq $false)
    {
        $skill.routeVoiceMailsSpecified = $true
        $skill.routeVoiceMails = $false
    }


    $response = $global:DefaultFive9AdminClient.modifySkill($skill)

    return $response.skill

}
