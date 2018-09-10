class UserSerializer < BaseSerializer
  attributes :id, :name, :email, :role

  belongs_to :business
end
