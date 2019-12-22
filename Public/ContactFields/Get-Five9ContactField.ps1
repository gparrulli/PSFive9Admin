<#
.SYNOPSIS
    
    Function used to return contact field(s) from Five9

.PARAMETER Name

    Name of existing contact field. If omitted, all contact fields will be returned

.EXAMPLE

    Get-Five9ContactField -AdminClient $proxy

    # Returns all contact fields

.EXAMPLE
    
    Get-Five9ContactField -Name "first_name"
    
    # Returns contact field with name ""first_name"

#>
function Get-Five9ContactField
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$false)][string]$NamePattern = '.*'
    )

    return $global:DefaultFive9AdminClient.getContactFields($NamePattern)

}
