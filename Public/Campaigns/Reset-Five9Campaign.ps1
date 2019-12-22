<#
.SYNOPSIS
    
    Function to reset a campaign to redial every number, except for numbers on the Do-Not-Call list
 
.PARAMETER CampaignName
 
    Campaign name to be reset

.EXAMPLE
    
    Reset-Five9Campaign -CampaignName 'Hot-Leads'

    # resets campaign named 'Hot-Leads'

#>
function Reset-Five9Campaign
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName
    )

    return $global:DefaultFive9AdminClient.resetCampaign($CampaignName)

}
