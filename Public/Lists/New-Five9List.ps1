<#
.SYNOPSIS
    
    Function used to create a new Five9 list

.PARAMETER Name

    Name of new list
   
.EXAMPLE
    
    New-Five9List -Name "Cold-Call-List"

    # Creates a new list

 
#>
function New-Five9List
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name

    )

    $response = $global:DefaultFive9AdminClient.createList($Name)

    return $response


}

