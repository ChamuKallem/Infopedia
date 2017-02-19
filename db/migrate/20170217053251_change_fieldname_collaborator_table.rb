class ChangeFieldnameCollaboratorTable < ActiveRecord::Migration
  def change
    rename_column :collaborators, :wikis_id, :wiki_id
  end
end
