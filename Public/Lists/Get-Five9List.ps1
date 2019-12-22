<#
.SYNOPSIS
    
    Function used to get list(s) from Five9

.PARAMETER NamePattern
 
    Returns lists matching a given regex string
   
.EXAMPLE
    
    Get-Five9List -AdminClient $proxy
    
    # Returns all agent groups
    
.EXAMPLE
    
    Get-Five9List -NamePattern "Cold-Call-List"
    
    # Returns list that matches the name "Cold-Call-List"

 
#>
function Get-Five9List
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$false)][string]$NamePattern = '.*'

    )

    $response = $global:DefaultFive9AdminClient.getListsInfo($NamePattern)

    return $response


}

