class TechDebtsMigrationGenerator < Rails::Generator::NamedBase
  attr_reader :tech_debts_table_name
  def initialize(runtime_args, runtime_options = {})
    @tech_debts_table_name = (runtime_args.length < 2 ? 'tech_debts' : runtime_args[1]).tableize
    runtime_args << 'add_tech_debts_table' if runtime_args.empty?
    super
  end

  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate'
    end
  end
end
