<#
.SYNOPSIS
    
    Function add a skill(s) to a Five9 campaign
 
.PARAMETER CampaignName
 
    Campaign name to add skill(s) to

.PARAMETER Skill

    Single skill name, or array of multiple skill names to be added to a campaign


.EXAMPLE
    
    Add-Five9CampaignDNIS -CampaignName 'Hot-Leads' -Skill 'Skill-1'

    # adds a single skill to a campaign

.EXAMPLE

    $skillsToBeAdded = @('Skill-1', 'Skill-2', 'Skill-3')
    Add-Five9CampaignDNIS -CampaignName 'Hot-Leads' -Skill $skillsToBeAdded
    
    # adds array of multiple skills to a campaign
    
 
#>
function Add-Five9CampaignSkill
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName,
        [Parameter(Mandatory=$true)][string[]]$Skill
    )

    return $global:DefaultFive9AdminClient.addSkillsToCampaign($CampaignName, $Skill)

}
