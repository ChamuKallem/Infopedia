class WikiPolicy < ApplicationPolicy
  def index?
    true
  end
  def update?
    user.present? && (user.premium? || user.admin? || !record.private)
  end
  def create?
    user.present?
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
