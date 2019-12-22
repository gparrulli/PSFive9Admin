<#
.SYNOPSIS

    Function returns the attributes of the dialing lists associated with an outbound campaign
 
.PARAMETER CampaignName
 
    Outbound campaign name that list(s) will be returned from

.EXAMPLE
    
    Get-Five9CampaignList -CampaignName 'Hot-Leads'

    # returns lists associated with a campaign


#>
function Get-Five9CampaignList
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName
    )

    return $global:DefaultFive9AdminClient.getListsForCampaign($CampaignName)

}

