<#
.SYNOPSIS
    
    Function to stop a campaign
 
.PARAMETER CampaignName
 
    Campaign name that will be stopped

.PARAMETER Force

    Force stops the campaign, which immediately disconnects all active calls

.EXAMPLE
    
    Stop-Five9Campaign -CampaignName 'Hot-Leads'

    # stops campaign named 'Hot-Leads' gracefully

.EXAMPLE
    
    Stop-Five9Campaign -CampaignName 'Hot-Leads' -Force $true

    # stops campaign named 'Hot-Leads' forcefully, which immediately disconnects all active calls

 
#>
function Stop-Five9Campaign
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName,
        [Parameter(Mandatory=$false)][bool]$Force = $false
    )

    if ($Force -eq $true)
    {
        return $global:DefaultFive9AdminClient.forceStopCampaign($CampaignName)
    }
    else
    {
        return $global:DefaultFive9AdminClient.stopCampaign($CampaignName)
    }

    

}
