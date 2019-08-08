class UserPolicy < ApplicationPolicy
  def update?
    if @user.access_level < 3
      return @user == @record
    end
    true
  end

  def permitted_attributes
    if @user.access_level > 1 && @user != @record
      [:access_level]
    else
      [:username, :email, :first_name, :last_name, :password, :password_confirmation]
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
