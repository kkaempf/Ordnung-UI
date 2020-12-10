# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :mimetypes do
      primary_key :id
      string :name, null: false
    end
  end
end
