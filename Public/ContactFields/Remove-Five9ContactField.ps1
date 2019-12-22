<#
.SYNOPSIS
    
    Function used to remove an existing contact field

.PARAMETER Name

    Name of contact field to be removed

.NOTES

    • All campaigns must be stopped before removing a contact field

.EXAMPLE
    Remove-Five9ContactField -Name 'hair_color'

    # Removes contact field named "hair_color"



#>
function Remove-Five9ContactField
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name
    )

    return $global:DefaultFive9AdminClient.deleteContactField($Name)
}
