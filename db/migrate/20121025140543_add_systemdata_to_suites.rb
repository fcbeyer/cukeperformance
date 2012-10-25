class AddSystemdataToSuites < ActiveRecord::Migration
  def change
    add_column :suites, :browser, :string

    add_column :suites, :os, :string

    add_column :suites, :mobilizer, :string

    add_column :suites, :mobilizer_build_tag, :string

    add_column :suites, :url, :string

  end
end
