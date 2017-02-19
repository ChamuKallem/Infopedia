class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? || wiki.user_id = user.id
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          puts "Each wiki info"
          puts wiki.title
          wiki.collaborators.each do |c|
            puts "I am a user"
            puts user.id
            puts c.user_id
            puts (wiki.collaborators.map(&:user_id).include? user.id)
          end
          if wiki.private? || (wiki.collaborators.map(&:user_id).include? user.id)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
  def index?
    true
  end
  def update?
    user.present? && (user.premium? || user.admin? || (wiki.collaborators.map(&:user_id).include? user.id) )
  end
  def create?
    user.present?
  end
  def show?
    true
  end
  def edit?
    user.present?
    # user.present?
  end

  def destroy?
    user.present? && user.admin?
  end
  private
    def wiki
        record
    end
end
