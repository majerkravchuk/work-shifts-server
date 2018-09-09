module ActiveAdmin
  class UserFormGenerator
    attr_accessor :current_user, :current_business, :resource, :role

    def initialize(current_user, current_business, resource, role)
      @current_user = current_user
      @current_business = current_business
      @resource = resource
      @role = role
    end

    def generate_form_proc
      proc do |f|
        f.inputs do
          f.input :name
          f.input :email
          f.input :password
          f.input :password_confirmation
          f.input :position, as: :select, collection: position_list, include_blank: false unless resource.admin?
          f.input :facilities, as: :check_boxes, collection: facilities_list
        end
        f.actions
      end
    end

    def position_list
      return [] if resource.admin?
      meth = "#{role}_positions"
      positions = current_user.admin? ? current_business.send(meth) : current_user.send(meth)
      positions.map { |p| [p.name.capitalize, p.id] }
    end

    def facilities_list
      current_business.facilities.map do |facility|
        [
          facility.name,
          facility.id,
          { checked: resource.facilities.include?(facility) }
        ]
      end
    end
  end
end
