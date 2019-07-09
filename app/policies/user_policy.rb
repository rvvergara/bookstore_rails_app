class UserPolicy < ApplicationPolicy
  def update?
    @user == @record
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
