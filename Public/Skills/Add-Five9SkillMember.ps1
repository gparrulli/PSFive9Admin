<#
.SYNOPSIS
    
    Function used to add a member to an existing skill


.PARAMETER Username
 
    Username of user being added to skill

.PARAMETER SkillName
 
    Skill Name that user is being added to

.PARAMETER SkillLevel
 
    Optional parameter. User's priority level in skill. Default value = 1


   
.EXAMPLE
    
    Add-Five9SkillMember -Username "jdoe@domain.com" -SkillName "Multimedia"
    
    # Adds user jdoe@domain.com to skill Multimedia
    

#>
function Add-Five9SkillMember
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        [Parameter(Mandatory=$true)][string]$Username,
        [Parameter(Mandatory=$true)][string]$SkillName,
        [Parameter(Mandatory=$false)][string]$SkillLevel = 1
    )

    $userSkill = New-Object PSFive9Admin.userSkill
    $userSkill.userName = $Username
    $userSkill.skillName = $SkillName
    $userSkill.level = $SkillLevel
    
    $response = $global:DefaultFive9AdminClient.userSkillAdd($userSkill)

    return $response
}



