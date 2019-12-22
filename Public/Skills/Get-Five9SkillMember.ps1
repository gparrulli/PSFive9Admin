<#
.SYNOPSIS
    
    Function used to get the members of a given skill


.PARAMETER SkillName
 
    Skill Name to get members of

   
.EXAMPLE
    
    Get-Five9SkillMember -SkillName "MultiMedia"
    
    # Gets members of skill MultiMedia
    

#>
function Get-Five9SkillMember
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        [Parameter(Mandatory=$true)][string]$SkillName
    )

    $response = $global:DefaultFive9AdminClient.getSkillInfo($SkillName)

    return $response.users
}



