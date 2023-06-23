class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    # Define abilities for different user roles
    if user.role == 'admin'
      can :manage, :all # Admin has full access
    elsif user.role == 'member'
      can :read, User
      can :manage, User, id: user.id
      can :read, Post
      can :manage, Post, author_id: user.id
      can :read, Comment
      can :manage, Comment, author_id: user.id
      can :create, Like
    else
      can :read, :all # Guest user can only read
    end
  end
end
