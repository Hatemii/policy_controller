class UserPolicy < ApplicationPolicy
  def show?
    user.role == "admin" || self_record
  end

  def update?
    user.role == "admin" || self_record
  end

  private

    def self_record
      user.id == record.id
    end
end
