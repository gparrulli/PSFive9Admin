<#
.SYNOPSIS
    
    Function to add disposition(s) to a Five9 campaign
 
.PARAMETER CampaignName
 
    Campaign name that disposition(s) will be added to

.PARAMETER DispositionName
 
    Single disposition name, or multiple disposition names to be added to a campaign

.PARAMETER IsSkipPreviewDisposition

    For campaigns running in preview mode, whether the dispositions that are added should be used as skip call preview dispositions
   

.EXAMPLE
    
    Add-Five9CampaignDisposition -CampaignName 'MultiMedia' -DispositionName 'Wrong Number'

    # adds a single disposition to a campaign

.EXAMPLE

    $dispositionsToBeAdded = @('Dead Air', 'Wrong Number')
    Add-Five9CampaignDisposition -CampaignName 'MultiMedia' -DispositionName $dispositionsToBeAdded
    
    # adds multiple dispositions to a campaign
    
 
#>
function Add-Five9CampaignDisposition
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$CampaignName,
        [Parameter(Mandatory=$true)][string[]]$DispositionName,
        [Parameter(Mandatory=$false)][bool]$IsSkipPreviewDisposition = $false
    )

    return $global:DefaultFive9AdminClient.addDispositionsToCampaign($CampaignName,$DispositionName,$IsSkipPreviewDisposition, $IsSkipPreviewDisposition)

}
