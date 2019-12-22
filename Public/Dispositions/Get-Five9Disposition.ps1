<#
.SYNOPSIS
    
    Function used to get disposition(s) from Five9

.PARAMETER NamePattern
 
    Optional parameter. Returns only dispositions matching a given regex string
   
.EXAMPLE
    
    Get-Five9Disposition -AdminClient $proxy
    
    # Returns all dispositions
    
.EXAMPLE
    
    Get-Five9Disposition -NamePattern "No Answer"
    
    # Returns disposition named "No Answer"
    
 
#>
function Get-Five9Disposition
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$false)][string]$NamePattern = '.*'
    )
    
    return $global:DefaultFive9AdminClient.getDispositions($NamePattern)

}
