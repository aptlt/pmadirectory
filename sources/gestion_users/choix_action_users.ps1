# SCRIPT CHOIX DE L'ACTION UTILISATEUR #

###############################################

# Chargement des classes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

############# CREATION DE LA FENETRE ###############

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Menu choix"
$objForm.Size = New-Object System.Drawing.Size(300,400) 
$objForm.StartPosition = "CenterScreen"
$objForm.BackColor = "#02ACE5"

###############################################


############# Texte : "Choisir l'action a effectuer" ###############

# Texte affiché #

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,50) 
$objLabel.Size = New-Object System.Drawing.Size(280,30) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Choisissez la modification à effectuer"
$objLabel.Font = New-Object System.Drawing.Font ("Tahoma", 9, [System.Drawing.FontStyle]::Bold)
$objForm.Controls.Add($objLabel) 

# Bouton ajouter des utilisateurs #

$AddUserButton = New-Object System.Windows.Forms.Button
$AddUserButton.Location = New-Object System.Drawing.Size(10,100)
$AddUserButton.Size = New-Object System.Drawing.Size(260,30)
$AddUserButton.Text = "Ajouter des utilisateurs"
$AddUserButton.Font = New-Object System.Drawing.Font ("Tahoma", 10, [System.Drawing.FontStyle]::Bold)
$AddUserButton.ForeColor = "White"
$AddUserButton.Add_Click({.\gestion_users\ajout_users.ps1;$objForm.Close()})
$objForm.Controls.Add($AddUserButton)

# Bouton désactiver un utilisateurs #

$DisableUserButton = New-Object System.Windows.Forms.Button
$DisableUserButton.Location = New-Object System.Drawing.Size(10,145)
$DisableUserButton.Size = New-Object System.Drawing.Size(260,30)
$DisableUserButton.Text = "Activer/Désactiver des utilisateurs"
$DisableUserButton.Font = New-Object System.Drawing.Font ("Tahoma", 10, [System.Drawing.FontStyle]::Bold)
$DisableUserButton.ForeColor = "White"
$DisableUserButton.Add_Click({.\gestion_users\enable_disable_users.ps1;$objForm.Close()})
$objForm.Controls.Add($DisableUserButton)

# Bouton supprimer un utilisateurs #

$DelUserButton = New-Object System.Windows.Forms.Button
$DelUserButton.Location = New-Object System.Drawing.Size(10,190)
$DelUserButton.Size = New-Object System.Drawing.Size(260,30)
$DelUserButton.Text = "Supprimer des utilisateurs"
$DelUserButton.Font = New-Object System.Drawing.Font ("Tahoma", 10, [System.Drawing.FontStyle]::Bold)
$DelUserButton.ForeColor = "White"
$DelUserButton.Add_Click({.\gestion_users\delete_users.ps1;$objForm.Close()})
$objForm.Controls.Add($DelUserButton)


###############################################

############# VALIDER QUITTER OU RETOUR ###############

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(30,320)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Précédent"
$CancelButton.ForeColor = "White"
$CancelButton.Add_Click({$objForm.Close();.\panel_menu.ps1})
$objForm.Controls.Add($CancelButton)


$QuitButton = New-Object System.Windows.Forms.Button
$QuitButton.Location = New-Object System.Drawing.Size(180,320)
$QuitButton.Size = New-Object System.Drawing.Size(75,23)
$QuitButton.Text = "Quitter"
$QuitButton.ForeColor = "White"
$QuitButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($QuitButton)

###############################################

# Affichage des éléments

$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()


###############################################