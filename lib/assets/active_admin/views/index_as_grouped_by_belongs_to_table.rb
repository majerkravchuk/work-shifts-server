module ActiveAdmin
  module Views
    class IndexAsGroupedByBelongsToTable < IndexAsTable
      def build(page_presenter, collection)
        parent_association = page_presenter[:association]
        if parent_association.present?
          grouped_collection = collection.where
                                         .not("#{page_presenter[:association]}_id".to_sym => nil)
                                         .group_by(&parent_association)
                                         .sort_by{ |key, value| key.name }

          Hash[grouped_collection].each do |parent, group_collection|
            h3 parent.send(page_presenter[:association_title] || :id)
            super page_presenter, group_collection
          end

          h3 'Сommon'
          super page_presenter, collection.where("#{page_presenter[:association]}_id".to_sym => nil)
        else
          super
        end
      end
    end
  end
end
