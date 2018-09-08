module ActiveAdmin
  module Views
    module Pages
      class Base < Arbre::HTML::Document

        alias_method :original_build_head, :build_active_admin_head

        def build_active_admin_head
          original_build_head

          within @head do
            text_node Gon::Base.render_data
          end
        end
      end
    end
  end
end
