<#
.SYNOPSIS
    
    Function to remove skill(s) from a Five9 campaign
 
.PARAMETER CampaignName
 
    Campaign name that skill(s) will be removed from

.PARAMETER Skill

    Single skill name, or array of multiple skill names to be removed from a campaign


.EXAMPLE
    
    Remove-Five9CampaignDNIS -CampaignName 'Hot-Leads' -Skill 'Skill-1'

    # removes a single skill from a campaign

.EXAMPLE

    $skillsToBeRemoved = @('Skill-1', 'Skill-2', 'Skill-3')
    Remove-Five9CampaignDNIS -CampaignName 'Hot-Leads' -Skill $skillsToBeRemoved
    
    # removes array of multiple skills from a campaign
    
 
#>
function Remove-Five9CampaignSkill
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName,
        [Parameter(Mandatory=$true)][string[]]$Skill
    )

    return $global:DefaultFive9AdminClient.removeSkillsFromCampaign($CampaignName, $Skill)

}
