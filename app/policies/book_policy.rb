class BookPolicy < ApplicationPolicy
  def create?
    @user.access_level > 1
  end

  def update?
    @user.access_level > 1
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
