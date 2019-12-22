<#
.SYNOPSIS
    
    Function used to delete a skill


.PARAMETER SkillName
 
    Skill name to be deleted

   
.EXAMPLE
    
    Remove-Five9Skill -SkillName "MultiMedia"
    
    # Deletes skill named MultiMedia
    

#>
function Remove-Five9Skill
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        [Parameter(Mandatory=$true)][string]$SkillName
    )

    $response = $global:DefaultFive9AdminClient.deleteSkill($SkillName)

    return $response

}
