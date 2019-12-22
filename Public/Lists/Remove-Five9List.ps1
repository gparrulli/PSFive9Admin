<#
.SYNOPSIS
    
    Function used to delete a new Five9 list

.PARAMETER Name

    Name of new list to be removed
   
.EXAMPLE
    
    Remove-Five9List -Name "Cold-Call-List"

    # Deletes list named "Cold-Call-List"

 
#>
function Remove-Five9List
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name

    )

    $response = $global:DefaultFive9AdminClient.deleteList($Name)

    return $response


}

