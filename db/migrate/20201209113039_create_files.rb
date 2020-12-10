# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :files do
      primary_key :id
      string :name, null: false
      foreign_key :extension_id, :extensions
      foreign_key :directory_id, :directories, null: false
    end
  end
end
