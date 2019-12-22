<#
.SYNOPSIS
    
    Function used to delete a user
 

.PARAMETER Username
 
    New skill name

   
.EXAMPLE
    
    Remove-Five9Skill -Username 'jdoe@domain.com'
    
    # Deletes user with username "jdoe@domain.com"
    

#>
function Remove-Five9Skill
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        [Parameter(Mandatory=$true)][string]$Username
    )

    $response = $global:DefaultFive9AdminClient.deleteUser($Username)

    return $response

}
