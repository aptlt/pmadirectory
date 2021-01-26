# SCRIPT DELETE USERS #

###############################################

# Chargement des classes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

############# CREATION DE LA FENETRE ###############

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Supprimer un utilisateur"
$objForm.Size = New-Object System.Drawing.Size(300,400) 
$objForm.StartPosition = "CenterScreen"
$objForm.BackColor = "#02ACE5"

###############################################

# Liste déroulante users #

$objComboboxUser = New-Object System.Windows.Forms.Combobox
$objComboboxUser.Location = New-Object System.Drawing.Size(30,120) 
$objComboboxUser.Size = New-Object System.Drawing.Size(220,40) 
$objComboboxUser.DropDownStyle = "DropDownList"

function recup_ad_users {
# Fonction appelée pour recupérer la liste des utilisateurs #

# Clear de la liste déroulante si du texte s'y trouve #

$objComboboxUser.Items.Clear()

# Recherche des utilisateurs présents sur l'AD #

$OU = "OU=Utilisateurs,DC=afip,DC=lab"

if ($listUsers -ne $null){
    $listUsers = ""
}

$listUsers = Get-ADUser -Filter * -SearchBase $OU 

# Ajout des Utilisateus dans la Liste

foreach($user in $listUsers.sAMAccountName)
{
    $objComboboxUser.Items.add($user)
}

$objForm.controls.add($objComboboxUser)

}

function delete_user {

# Fonction appelée pour supprimer un utilisateur #

Remove-ADUser -Identity $objComboboxUser.Text -Confirm:$false

############# Texte : "Recapitulatif " ###############

$objRecap = New-Object System.Windows.Forms.Label
$objRecap.Location = New-Object System.Drawing.Size(10,240) 
$objRecap.Size = New-Object System.Drawing.Size(280,100)
$objRecap.Font = New-Object System.Drawing.Font ("Arial", 9, [System.Drawing.FontStyle]::Bold)
$objRecap.ForeColor = "White"
$objRecap.Text = "L'utilisateur " + $objComboboxUser.Text + " a été supprimé avec succès"
$objForm.Controls.Add($objRecap)
Sleep -s 2
$objForm.Controls.Remove($objRecap)

}

###############################################

# Liste déroulante des utilisateurs générés

recup_ad_users

###############################################

############# Texte : "Choisissez l'utilisateur à supprimer" ###############

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(30,90) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Choisissez l'utilisateur à supprimer"
$objForm.Controls.Add($objLabel) 


############# VALIDER QUITTER OU RETOUR ###############

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(30,320)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Précédent"
$CancelButton.ForeColor = "White"
$CancelButton.Add_Click({$objForm.Close();.\gestion_users\choix_action_users.ps1})
$objForm.Controls.Add($CancelButton)

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(105,320)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "Supprimer"
$OKButton.ForeColor = "White"
$OKButton.Add_Click({delete_user;recup_ad_users})
$objForm.Controls.Add($OKButton)


$QuitButton = New-Object System.Windows.Forms.Button
$QuitButton.Location = New-Object System.Drawing.Size(180,320)
$QuitButton.Size = New-Object System.Drawing.Size(75,23)
$QuitButton.Text = "Quitter"
$QuitButton.ForeColor = "White"
$QuitButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($QuitButton)


###############################################


###############################################

# Affichage des éléments

$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()


###############################################