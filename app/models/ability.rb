class Ability
  include CanCan::Ability

  def initialize(user)
		user ||= User.new
		if user.admin?
			can :manage, :all
		elsif user.member?
			can :read, :all
			can :create, Comment
			can :destroy, Comment, user_id: user.id
		else
			can :read, :all
		end
  end
end
