module ActiveAdmin
  module Views
    class IndexAsGroupedByBelongsToTable < IndexAsTable
      def build(page_presenter, collection)
        parent_association = page_presenter[:association]
        if parent_association.present?
          collection.group_by(&parent_association).sort.each do |parent, group_collection|
            h3 parent.send(page_presenter[:association_title] || :id)
            super page_presenter, group_collection
          end
        else
          super
        end
      end
    end
  end
end
