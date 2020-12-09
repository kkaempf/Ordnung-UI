# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :files do
      primary_key :id
      string :name, null: false
      string :extension
      string :directory, null: false
    end
  end
end
