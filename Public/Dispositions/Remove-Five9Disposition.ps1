<#
.SYNOPSIS
    
    Function used to delete a Five9 disposition

.PARAMETER Name

    Name of existing disposition to be removed

   
.EXAMPLE
    
    Remove-Five9Disposition -Name "Default-Disposition"

    # Deletes existing disposition named "Default-Disposition"

    
 
#>
function Remove-Five9Disposition
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name
    )


    $response = $global:DefaultFive9AdminClient.removeDisposition($Name)

    return $response

}

