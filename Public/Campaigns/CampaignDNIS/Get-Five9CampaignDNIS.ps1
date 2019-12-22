<#
.SYNOPSIS
    
    Function to returns the list of DNIS associated with an inbound campaign
 
.PARAMETER CampaignName
 
    Inbound campaign name

.EXAMPLE
    
    Get-Five9CampaignDNIS -CampaignName 'Hot-Leads'

    # Returns the list of DNIS associated with a campaign
    
#>
function Get-Five9CampaignDNIS
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName
    )

    return $global:DefaultFive9AdminClient.getCampaignDNISList($CampaignName)

}
