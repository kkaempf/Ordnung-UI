require 'rom-repository'

module Ordnung
  module Repositories

    class Files < ::ROM::Repository[:files]
      commands :create
      def [](id)
        files.by_pk(id).one!
      end
      def id(f)
        sql = files.where(name: f.name, extension: f.extension, directory: f.directory)
        .select(:id)
        .first
        (sql) ? sql.id : sql
      end
    end
    class Extensions < ::ROM::Repository[:extensions]
      commands :create
      def [](id)
        extensions.by_pk(id).one!
      end
    end
    class Directories < ::ROM::Repository[:directories]
      commands :create
      def [](id)
        directories.by_pk(id).one!
      end
    end

  end # Repositories
end # Ordnung
