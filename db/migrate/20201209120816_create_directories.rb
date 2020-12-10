# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :directories do
      primary_key :id
      string :name, null: false
      foreign_key :parent, :directories
    end
  end
end
