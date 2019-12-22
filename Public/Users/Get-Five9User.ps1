<#
.SYNOPSIS
    
    Function used to return Five9 user(s) using a 

.PARAMETER NamePattern
 
    Optional regex parameter. If used, function will return only users matching regex string
   
.EXAMPLE
    
    Get-Five9User -AdminClient $proxy
    
    # Returns all Users
    
.EXAMPLE
    
    Get-Five9User -NamePattern "jdoe@domain.com"
    
    # Returns user who matches the string "jdoe@domain.com"

#>
function Get-Five9User
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        [Parameter(Mandatory=$false)][string]$NamePattern = '.*'
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop


        Write-Verbose "$($MyInvocation.MyCommand.Name): Returning Five9 users using pattern '$($NamePattern)'"
        $response = $global:DefaultFive9AdminClient.getUsersInfo($NamePattern)

        return $response
    }
    catch
    {
        Write-Error $_
    }

}



