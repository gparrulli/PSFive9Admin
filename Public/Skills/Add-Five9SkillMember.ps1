function Add-Five9SkillMember
{
    <#
    .SYNOPSIS
    
        Function used to add a member to an existing skill

    .EXAMPLE
    
        Add-Five9SkillMember -Username "jdoe@domain.com" -Name "Multimedia"
    
        # Adds user jdoe@domain.com to skill Multimedia

    #>
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        # Skill Name that user is being added to
        [Parameter(Mandatory=$true, Position=0)][string]$Name,

        # Username of user being added to skill
        [Parameter(Mandatory=$true, Position=1)][string]$Username,

        # Optional parameter. User's priority level in skill. 
        # Default value = 1
        [Parameter(Mandatory=$false)][string]$SkillLevel = 1
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        $userSkill = New-Object PSFive9Admin.userSkill
        $userSkill.userName = $Username
        $userSkill.skillName = $Name
        $userSkill.level = $SkillLevel
    
        Write-Verbose "$($MyInvocation.MyCommand.Name): Adding user '$Username' to skill '$Name'." 
        $response = $global:DefaultFive9AdminClient.userSkillAdd($userSkill)

        return $response

    }
    catch
    {
        throw $_
    }
}



