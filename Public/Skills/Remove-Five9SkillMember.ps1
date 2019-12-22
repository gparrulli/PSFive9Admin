<#
.SYNOPSIS
    
    Function used to remove a member from an existing skill


.PARAMETER Username
 
    Username of user being removed from skill

.PARAMETER SkillName
 
    Skill Name that user is being removed from

   
.EXAMPLE
    
    Remove-Five9SkillMember -Username "jdoe@domain.com" -SkillName "Multimedia"
    
    # Removes user jdoe@domain.com from skill Multimedia
    

#>
function Remove-Five9SkillMember
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        [Parameter(Mandatory=$true)][string]$Username,
        [Parameter(Mandatory=$true)][string]$SkillName
    )

    $userSkill = New-Object PSFive9Admin.userSkill
    $userSkill.userName = $Username
    $userSkill.skillName = $SkillName
    
    $response = $global:DefaultFive9AdminClient.userSkillRemove($userSkill)


    return $response
}



