class CurrentUserSerializer < BaseSerializer
  attributes :id, :name, :email, :role

  belongs_to :business
end
