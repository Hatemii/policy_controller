class UserPolicy < ApplicationPolicy
  def show?
    user.id == record.id
  end

  def update?
    user.role == "admin"
  end
end
