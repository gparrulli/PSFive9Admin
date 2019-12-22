<#
.SYNOPSIS
    
    Function removes disposition(s) from a Five9 campaign
 
.PARAMETER CampaignName
 
    Campaign that disposition(s) will be removed from

.PARAMETER DispositionName
 
    Single disposition name, or multiple disposition names to be added removed from a campaign


.EXAMPLE
    
    Remove-Five9CampaignDisposition -CampaignName 'MultiMedia' -DispositionName 'Wrong Number'

    # removes a single disposition from a campaign

.EXAMPLE

    $dispositionsToBeRemoved = @('Dead Air', 'Wrong Number')
    Remove-Five9CampaignDisposition -CampaignName 'MultiMedia' -DispositionName $dispositionsToBeRemoved
    
    # removes multiple dispositions from a campaign
    
 
#>
function Remove-Five9CampaignDisposition
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName,
        [Parameter(Mandatory=$true)][string[]]$DispositionName
    )

    return $global:DefaultFive9AdminClient.removeDispositionsFromCampaign($CampaignName, $DispositionName)

}

