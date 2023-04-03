class UserPolicy < ApplicationPolicy

  relation_scope do |relation|
    relation.all
  end

  scope_for :company_users do |relation, company_id: |
    relation.where(company_id: company_id)
  end

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
