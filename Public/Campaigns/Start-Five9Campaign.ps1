<#
.SYNOPSIS
    
    Function to start a campaign
 
.PARAMETER CampaignName
 
    Campaign name to be started

.EXAMPLE
    
    Start-Five9Campaign -CampaignName 'Hot-Leads'

    # starts campaign named 'Hot-Leads'


 
#>
function Start-Five9Campaign
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName
    )

    return $global:DefaultFive9AdminClient.startCampaign($CampaignName)

}
