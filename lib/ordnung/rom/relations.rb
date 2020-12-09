
module Ordnung
  module Relations

    class Files < ::ROM::Relation[ROM_TYPE]
      schema(:files) do
        attribute :id, Types::Integer
        attribute :name, Types::String
        attribute :extension, Types::String
        attribute :directory, Types::String

        primary_key :id
      end
    end

    class Extensions < ::ROM::Relation[ROM_TYPE]
      schema(:extensions) do
        attribute :id, Types::Integer
        attribute :name, Types::String

        primary_key :id
      end
    end

    class Directories < ::ROM::Relation[ROM_TYPE]
      schema(:directories) do
        attribute :id, Types::Integer
        attribute :parent, Types::Integer
        attribute :name, Types::String

       primary_key :id
      end
    end

  end # Relations
end # Ordnung
