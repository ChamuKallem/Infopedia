class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  delegate :users, to: :collaborators
  def collaborators
    Collaborator.where(wiki_id: id)
  end


end
