<#
.SYNOPSIS

    Function to remove list(s) from an outbound campaign
 
.PARAMETER CampaignName
 
    Outbound campaign name that list(s) will be removed from

.PARAMETER ListName
 
    Name of list(s) to be removed from a campaign


.EXAMPLE
    
    Remove-Five9CampaignList -CampaignName 'Hot-Leads' -ListName 'Hot-Leads-List'

    # remove a list from a campaign

.EXAMPLE
    
    $listsToBeRemoved = @('Hot-Leads-List', 'Cold-Leads-List')
    Remove-Five9CampaignList -CampaignName 'Hot-Leads' -ListName $listsToBeRemoved

    # removes multiple lists from a campaign

#>
function Remove-Five9CampaignList
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName,
        [Parameter(Mandatory=$true)][string[]]$ListName
    )

    return $global:DefaultFive9AdminClient.removeListsFromCampaign($CampaignName, $ListName)

}

