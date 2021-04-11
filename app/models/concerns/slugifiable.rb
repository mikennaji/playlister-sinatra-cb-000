module Slugifiable

    module InstanceMethods
        def slug
            self.name.downcase.gsub("&","and").gsub(" ","-").gsub(/[^a-z-]/,"")
        end
    end

    module ClassMethods
        def find_by_slug(slug)
            self.all.detect {|i| i.slug == slug}
        end
    end

end
