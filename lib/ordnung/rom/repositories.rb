require 'rom-repository'

module Ordnung
  module Repositories

    class Files < ::ROM::Repository[:files]
      commands :create
      def [](id_or_name, extension_id = nil, directory_id = nil)
        if (extension_id && directory_id)
          files.where(name: id_or_name, extension_id: extension_id, directory_id: directory_id).first
        else
          files.by_pk(id_or_name).one!
        end
      end
    end
    class Extensions < ::ROM::Repository[:extensions]
      commands :create
      def by_id(id)
        extensions.by_pk(id).one!
      end
      def by_name(name)
        extensions.where(name: name).first
      end
    end
    class Directories < ::ROM::Repository[:directories]
      commands :create
      def [](id)
        directories.by_pk(id).one!
      end
      def id(d)
        sql = directories.where(name: d.name, parent: d.parent)
        .select(:id)
        .first
        (sql) ? sql.id : sql
      end
    end

  end # Repositories
end # Ordnung
